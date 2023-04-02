import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

// Authentication Statuses
enum AuthenticationStatus { unknown, authenticated, unauthenticated }

// Authentication repository
class AuthenticationRepository {
  // Stream controller
  final _controller = StreamController<AuthenticationStatus>();

  // Login method
  Future<dynamic> login({
    required String username,
    required String password,
  }) async {
    // making call to back-end server to authenticate the user credentials
    // using the password and username of the user.
    final response = await http.post(
      Uri.parse('http://localhost:3000/auth/login'),
      body: {
        "username": username,
        "password": password,
      },
    );

    print(jsonDecode(response.body));
  }
}

void main(List<String> args) async {
  AuthenticationRepository repo = AuthenticationRepository();
  repo.login(username: 'jamie', password: 'P@\$\$123w0rD#01');
}
