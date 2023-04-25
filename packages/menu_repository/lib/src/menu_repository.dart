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

  Future<bool?> deleteMenuByTitle(String title) async {
    final response = await http.delete(
      Uri.parse('http://localhost:3000/menu/${title}'),
      headers: {
        "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
        "Content-Type": 'application/json',
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      return true;
    }
    return false;
  }

  Future<String?> getMenuIdByTitle(String title) async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/menu/id/${title}'),
      headers: {
        "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
        "Content-Type": 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return '${response.body}';
    }
    return '';
  }
}
