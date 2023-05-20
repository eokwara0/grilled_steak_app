import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:service_locator/service_locator.dart';
import 'models/user.dart';
import 'package:http/http.dart' as http;

/// User repository
/// This class exposes the application to
/// user API
class UserRepository {
  // secure storage
  SecureStorage _ss = sl<SecureStorage>();

  // user

  // Returns user from the user API
  Future<User?> getUser() async {
    final _user = User.fromJson(await makeRequest());
    return _user;
  }

  // Makes a request to the user API to get user with
  // username
  Future<dynamic> makeRequest() async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/auth/profile'),
      headers: {
        "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
        "Content-Type": 'application/json',
      },
    );

    return response.statusCode == 200 ? jsonDecode(response.body) : null;
  }

  Future<bool> grantAccess(String userId) async {
    final response = await http.put(
      Uri.parse('http://localhost:3000/user/grant/${userId}'),
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

  Future<bool> revokeAccess(String userId) async {
    final response = await http.put(
      Uri.parse('http://localhost:3000/user/revoke/${userId}'),
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

  Future<List<User>?> getAllUsers() async {
    List<User> users = [];
    final response = await http.get(
      Uri.parse('http://localhost:3000/user'),
      headers: {
        "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
        "Content-Type": 'application/json',
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      List<dynamic> userList = jsonDecode(response.body);
      try {
        userList.forEach((user) {
          User user_ = User.fromJson(user);
          users.add(user_);
        });
      } catch (e) {
        return null;
      }
      return users;
    }
    return null;
  }

  Future<List<User>?> changePassword(String userId, String password) async {
    List<User> users = [];
    final response = await http.put(
      Uri.parse(
          'http://localhost:3000/user/change/password/${userId}?password=${password}'),
      headers: {
        "Authorization": 'Bearer ${await _ss.readKey('access_token')}',
        "Content-Type": 'application/json',
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      List<dynamic> userList = jsonDecode(response.body);
      try {
        userList.forEach((user) {
          User user_ = User.fromJson(user);
          users.add(user_);
        });
      } catch (e) {
        return null;
      }
      return users;
    }
    return null;
  }
}
