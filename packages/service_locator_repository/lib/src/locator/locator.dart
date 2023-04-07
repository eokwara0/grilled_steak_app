import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:service_locator/src/services/secure_storage.dart';

GetIt sl = GetIt.instance;

void registerServices(GetIt sl) {
  sl.registerSingleton(
    SecureStorage(
      FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
      ),
    ),
  );
}
