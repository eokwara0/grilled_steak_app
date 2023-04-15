import 'dart:async';
import 'package:authentication_repository/src/domain/models/request_model/post_request.dart';
import 'package:authentication_repository/src/domain/models/request_model/request_model.dart';
import 'package:authentication_repository/src/domain/models/response_model/response.dart';
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
    print('got here...');

    // request object
    final request = Post(
      uri: Uri.parse('http://localhost:3000/auth/login'),
      headers: {},
      body: {
        "username": username,
        "password": password,
      },
    );

    // response Object
    final Response res = await request.request();

    // print(res.statucode);
    // print(res.resBody);

    // checking for status code.
    switch (res.statucode) {
      case 200:
        print(' Authentication Repository ${res.resBody['access_token']}');
        _controller.add(AuthenticationStatus.authenticated);
        fss.writeAll({
          "username": username,
          "password": password,
          "access_token": res.resBody['access_token'],
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

  void dispose() => _controller.close();
}
