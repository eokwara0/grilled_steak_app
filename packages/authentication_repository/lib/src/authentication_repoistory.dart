import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:http/http.dart' as http;
import 'package:service_locator/service_locator.dart';

// Authentication Statuses
enum AuthenticationStatus { unknown, authenticated, unauthenticated }

// Authentication repository
class AuthenticationRepository {
  final SecureStorage fss = sl<SecureStorage>();
  // Stream controller
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  // Login method
  Future<dynamic> logIn({
    required String username,
    required String password,
  }) async {
    // making request to server to signin
    final response = await http.post(
      Uri.parse('http://localhost:3000/auth/login'),
      body: {
        "username": username,
        "password": password,
      },
    );

    // checking for status code.
    switch (response.statusCode) {
      case 201:
        _controller.add(AuthenticationStatus.authenticated);
        final body = jsonDecode(response.body);
        print(' Authentication Repository ${body['access_token']}');
        fss.writeAll({
          "username": username,
          "password": password,
          "access_token": body['access_token'],
        });
        break;

      case 401:
        _controller.add(AuthenticationStatus.unauthenticated);
        fss.writeValue('access_token', '');
        break;
      default:
        _controller.add(AuthenticationStatus.unknown);
        fss.writeValue('access_token', '');
        break;
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}

// void main(List<String> args) async {
//   AuthenticationRepository repo = AuthenticationRepository();
//   repo.login(username: 'jamie', password: 'P@\$\$123w0rD#01');
// }
