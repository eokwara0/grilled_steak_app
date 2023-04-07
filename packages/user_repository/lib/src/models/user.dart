import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
    this.id,
    this.role,
    this.username,
  );
  final id;
  final role;
  final username;

  @override
  List<Object> get props => [id, role, username];

  // user from json
  User.fromJson(dynamic user)
      : id = user['_id'] ?? '',
        role = user['_role'] ?? '',
        username = user['_username'] ?? '';

  // Empty users
  static const empty = User(
    '',
    '',
    '',
  );
}
