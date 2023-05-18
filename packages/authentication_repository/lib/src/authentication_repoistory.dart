import 'dart:async';
import 'package:service_locator/service_locator.dart';

import 'domain/models/models.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final SecureStorage fss = sl<SecureStorage>();
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unknown;
    yield* _controller.stream;
  }

  Future<bool> logIn({
    required String username,
    required String password,
  }) async {
    final request = Post(
      uri: Uri.parse('http://localhost:3000/auth/login'),
      headers: {},
      body: {
        "username": username,
        "password": password,
      },
    );

    final Response res = await request.request();

    switch (res.statucode) {
      case 200:
        print(' Authentication Repository ${res.resBody['access_token']}');
        fss.writeAll({
          "username": username,
          "password": password,
          "access_token": res.resBody['access_token'],
        });
        _controller.add(AuthenticationStatus.authenticated);

        return true;

      case 401:
        _controller.add(AuthenticationStatus.unauthenticated);
        fss.writeValue('access_token', '');
        return false;
      default:
        _controller.add(AuthenticationStatus.unauthenticated);
        fss.writeValue('access_token', '');
        return false;
    }
  }

  Future<dynamic> forgotPassword({
    required String email,
  }) async {
    Request request = Post(
      uri: Uri.parse('http://localhost:3000/auth/forgot/${email}'),
      headers: {},
      body: {},
    );
    Response res = await request.request();
    if (res.statucode == 201) {
      return true;
    }
    return false;
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
    fss.writeValue('access_token', '');
  }

  void addStatus(AuthenticationStatus status) {
    _controller.add(status);
  }

  void dispose() => _controller.close();
}
