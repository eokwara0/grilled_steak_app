// import 'dart:convert';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:get_it/get_it.dart';
// import 'package:grilled_steak_app/ui/user/cubit/user_cubit.dart';
// import 'package:http/testing.dart';
// import 'package:mockito/annotations.dart';
// import 'package:http/http.dart' as http;
// import 'package:mocktail/mocktail.dart';
// import 'package:service_locator/service_locator.dart';
// import 'package:user_repository/user_repository.dart';

// @GenerateMocks([http.Client, UserCubit])
// void main() {
//   group('UserBlocTest', () {
//     GetIt getIt = GetIt.I;

//     setUp(() {
//       TestWidgetsFlutterBinding.ensureInitialized();
//       getIt.registerSingleton(SecureStorage(
//         const FlutterSecureStorage(
//           aOptions: AndroidOptions(encryptedSharedPreferences: true),
//         ),
//       ));
//       SecureStorage ss = getIt<SecureStorage>();
//       ss.writeValue('access_token', '243230dfljfakjfd');
//     });
//     test('userBlocInitialize', () async {
//       final users = List.generate(2, (index) => User.empty);
//       final client = MockClient((request) async {
//         if (request.url == 'http://localhost:3000/user') {
//           return http.Response(
//             jsonEncode(users.map((e) => e.toJson()).toList()),
//             200,
//           );
//         }
//         return http.Response('error', 404);
//       });

//     whe
//       final cubit =
//           UserCubit(userRepository: UserRepository(cli: client, loc: getIt));

//       expect(cubit.state.users, users);
//     });
//   });
// }
