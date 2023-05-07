import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:service_locator/service_locator.dart';
import 'domain/menu_item_model.dart';

class MenuItemRepository {
  final SecureStorage _ss = sl<SecureStorage>();

  /// gets a menu item by its id
  Future<MenuItem?> getMenuItemById(String? id) async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/menuItem/item/${id}'),
      headers: {
        "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
        "Content-Type": 'application/json',
      },
    );

    if (response.statusCode == 200) {
      try {
        return MenuItem.fromJson(jsonDecode(response.body));
      } catch (e) {
        return null;
        //   throw Exception(
        //       'An error occurred while decoding the response body to Menuitem');
      }
    }
    return null;
  }

  /// deletes menu item by it's Id
  Future<bool?> deleteItemById(String id) async {
    final response = await http.delete(
      Uri.parse('http://localhost:3000/menuItem/${id}'),
      headers: {
        "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
        "Content-Type": 'application/json',
      },
    );

    if (response.statusCode == HttpStatus.accepted) {
      return true;
    } else {
      return false;
    }
  }

  /// returns a list of menu items based on the word search
  Future<List<MenuItem>?> getItemsBySearch(String regex) async {
    List<MenuItem> items = [];
    final response = await http.get(
      Uri.parse(
        'http://localhost:3000/menuItem/search/${regex}',
      ),
      headers: {
        "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
        "Content-Type": 'application/json',
      },
    );

    if (response.statusCode == 200) {
      try {
        final List<dynamic> decoded = List.of(jsonDecode(response.body));
        decoded.forEach((e) {
          items.add(
            MenuItem.fromJson(e),
          );
        });
        // print(items);
        return items;
      } catch (err) {
        return null;
      }
    }
    return null;
  }

  Future<List<MenuItem>?> getRecommendedItems() async {
    List<MenuItem> items = [];

    final response = await http.get(
      Uri.parse('http://localhost:3000/menuItem/recommended'),
      headers: {
        "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
        "Content-Type": 'application/json',
      },
    );

    try {
      if (response.statusCode == HttpStatus.ok) {
        print('got here ');
        final List<dynamic> decoded = List.of(jsonDecode(response.body));
        // print(decoded);
        decoded.forEach((el) {
          // print('Geneniva ===> ${el.title}');
          items.add(MenuItem.fromJson(el));
        });
        // print('other side');
        return items;
      }
      return null;
    } catch (e) {
      // print('an error occured');
      return null;
    }
  }

  /// returns a list of menu items based on the word search
  Future<List<MenuItem>?> getItemsByMenuId(String id) async {
    List<MenuItem> items = [];
    final response = await http.get(
      Uri.parse(
        'http://localhost:3000/menuItem/menuId/${id}',
      ),
      headers: {
        "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
        "Content-Type": 'application/json',
      },
    );

    if (response.statusCode == 200) {
      try {
        final List<dynamic> decoded = List.of(jsonDecode(response.body));
        decoded.forEach((e) {
          items.add(
            MenuItem.fromJson(e),
          );
        });
        return items;
      } catch (err) {
        return null;
      }
    }
    return null;
  }

  Future<bool> createMenuItem(MenuItem item) async {
    final response =
        await http.post(Uri.parse('http://localhost:3000/menuItem/add'),
            headers: {
              "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
              "Content-Type": 'application/json',
            },
            body: jsonEncode(item.toJson()));

    // print(response.statusCode);
    if (response.statusCode == HttpStatus.ok) {
      return true;
    }
    return false;
  }

  Future<bool> replaceMenuItem(MenuItem item) async {
    final response = await http.post(
        Uri.parse('http://localhost:3000/menuItem/replace/${item.id}'),
        headers: {
          "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
          "Content-Type": 'application/json',
        },
        body: jsonEncode(item.toJson()));

    // print(response.statusCode);
    if (response.statusCode == HttpStatus.accepted) {
      return true;
    }
    return false;
  }

  Future<String?> uploadImage(File? file, String dir) async {
    Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      "Authorization": 'Bearer ${await _ss.readKey('access_token')}'
    };
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(
        'http://localhost:3000/menuItem/upload/image/$dir',
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
