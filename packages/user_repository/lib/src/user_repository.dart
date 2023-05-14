import 'dart:async';
import 'dart:convert';
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
}
