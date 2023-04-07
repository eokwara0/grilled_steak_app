// import 'dart:async';

// import 'package:http/http.dart' as http;

// // Authentication Statuses
// enum AuthenticationStatus { unknown, authenticated, unauthenticated }

// // Authentication repository
// class AuthenticationRepository {
//   // Stream controller
//   final _controller = StreamController<AuthenticationStatus>();

//   Stream<AuthenticationStatus> get status async* {
//     yield AuthenticationStatus.unauthenticated;
//     yield* _controller.stream;
//   }

//   // Login method
//   Future<dynamic> login({
//     required String username,
//     required String password,
//   }) async {
//     // making request to server to signin
//     final response = await http.post(
//       Uri.parse('http://localhost:3000/auth/login'),
//       body: {
//         "username": username,
//         "password": password,
//       },
//     );

//     // checking for status code.
//     switch (response.statusCode) {
//       case 200:
//         _controller.add(AuthenticationStatus.authenticated);
//         break;
//       case 401:
//         _controller.add(AuthenticationStatus.unauthenticated);
//         break;
//       default:
//         _controller.add(AuthenticationStatus.unknown);
//         break;
//     }
//   }

//   void logOut() {
//     _controller.add(AuthenticationStatus.unauthenticated);
//   }

//   void dispose() => _controller.close();
// }

// // void main(List<String> args) async {
// //   AuthenticationRepository repo = AuthenticationRepository();
// //   repo.login(username: 'jamie', password: 'P@\$\$123w0rD#01');
// // }
