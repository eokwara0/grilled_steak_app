import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grilled_steak_app/ui/user/cubit/user_cubit.dart';
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:service_locator/service_locator.dart';
import 'package:user_repository/user_repository.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([http.Client])
void main() {
  blocTest<UserCubit, UserState>(
    'emits.',
    build: () {
      TestWidgetsFlutterBinding.ensureInitialized();
      sl.registerSingleton<SecureStorage>(SecureStorage(
        const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
        ),
      ));
      return UserCubit(userRepository: UserRepository());
    },
    act: (bloc) {
      bloc.emit(const UserInitial(users: [], status: UserStateStatus.initial));
      bloc.emit(const UserAccessGranted(
          users: [User.empty], status: UserStateStatus.accessGranted));
    },
    expect: () => [
      const UserInitial(users: [], status: UserStateStatus.initial),
      const UserAccessGranted(
          users: [User.empty], status: UserStateStatus.accessGranted)
    ],
  );

  group('UserCubit', () {
    late UserCubit counterBloc;
    late MockClient client;

    // TestWidgetsFlutterBinding.ensureInitialized();
    // sl.registerSingleton<SecureStorage>(SecureStorage(
    //   const FlutterSecureStorage(
    //     aOptions: AndroidOptions(encryptedSharedPreferences: true),
    //   ),
    // ));
    setUp(() {
      client = MockClient((request) async {
        return http.Response('data', 200);
      });
      counterBloc = UserCubit(userRepository: UserRepository(cli: client));
    });

    test('initial state is UserInitial', () async {
      expect(counterBloc.state,
          const UserInitial(users: [], status: UserStateStatus.initial));
    });
  });
}
