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
        return items;
      } catch (err) {
        return null;
        // throw Exception(
        //   'An error occurred while decoding the response ==> MenuItemRepository.getItemsBySearch',
        // );
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
      if (response.statusCode == HttpStatus.accepted) {
        final List<dynamic> decoded = List.of(jsonDecode(response.body));
        decoded.forEach((el) {
          items.add(MenuItem.fromJson(el));
        });
        return items;
      }
    } catch (e) {
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
}
