import 'dart:convert';
import 'dart:io';

import 'package:service_locator/service_locator.dart';
import 'package:http/http.dart' as http;
import 'domain/menu_model.dart';

class MenuRepository {
  final SecureStorage _ss = sl<SecureStorage>();

  Future<List<Menu>?> getMenus() async {
    List<Menu> result = [];
    final response = await http.get(
      Uri.parse('http://localhost:3000/menu'),
      headers: {
        "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
        "Content-Type": 'application/json',
      },
    );

    if (response.statusCode == 200) {
      try {
        List<dynamic> _decoded = List.of(
          jsonDecode(response.body),
        );
        _decoded.forEach(
          (e) {
            result.add(Menu.fromJson(e));
          },
        );
        return result;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Future<Menu?> getMenuByTitle(String title) async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/menu/${title}'),
      headers: {
        "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
        "Content-Type": 'application/json',
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      try {
        return Menu.fromJson(
          jsonDecode(
            response.body,
          ),
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Future<bool> deleteMenuById(String id) async {
    final response = await http.delete(
      Uri.parse('http://localhost:3000/menu/delete/${id}'),
      headers: {
        "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
        "Content-Type": 'application/json',
      },
    );

    if (response.statusCode == HttpStatus.accepted) {
      return true;
    }
    return false;
  }

  Future<Menu?> getMenuIdByTitle(String title) async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/menu/id/${title}'),
      headers: {
        "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
        "Content-Type": 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return Menu.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<Menu?> getMenuById(String id) async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/menu/menu/${id}'),
      headers: {
        "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
        "Content-Type": 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return Menu.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<bool> addMenu(Menu menu) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/menu'),
      headers: {
        "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
        "Content-Type": 'application/json',
      },
      body: jsonEncode(menu.toJson()),
    );
    if (response.statusCode == HttpStatus.created) {
      return true;
    }
    return false;
  }

  Future<String?> uploadImage(File? file) async {
    Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      "Authorization": 'Bearer ${await _ss.readKey('access_token')}'
    };
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(
        'http://localhost:3000/menu/upload/icon',
      ),
    )
      ..fields['image'] = 'image'
      ..files.add(
          await http.MultipartFile.fromPath('file', File(file!.path).path));

    request.headers.addAll(headers);
    final response = await request.send();

    if (response.statusCode == HttpStatus.accepted) {
      final data = await http.Response.fromStream(response);
      String url = extracturl(data.body);
      return url;
    }
    return null;
  }

  String extracturl(String url) {
    String newData = url.replaceFirst('public', 'http://localhost:3000');
    return newData;
  }
}
