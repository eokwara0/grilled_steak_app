import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    String? id,
    String? role,
    String? username,
    String? firstname,
    String? lastname,
    String? emaill,
  })  : _id = id,
        _role = role,
        _username = username,
        _firstname = firstname,
        _lastname = lastname,
        _emaill = emaill;
  final String? _id;
  final String? _role;
  final String? _username;
  final String? _firstname;
  final String? _lastname;
  final String? _emaill;

  get id => _id;
  get role => _role;
  get username => _username;
  get firstname => _firstname;
  get lastname => _lastname;
  get email => _emaill;

  bool get isAdmin => _role == 'ADMIN' || _role == "MANAGER";

  @override
  List<Object?> get props => [
        _id,
        _role,
        _username,
        _firstname,
        _lastname,
        _emaill,
      ];

  Map<String, String> toJson() => {
        role: _role ?? '',
        email: _emaill ?? '',
        lastname: _lastname ?? '',
        firstname: _firstname ?? '',
        username: _firstname ?? '',
      };
  // user from json
  static User fromJson(Map<dynamic, dynamic> user) {
    return User(
      id: '${user['_id']}',
      role: '${user['role']}',
      emaill: '${user['email']}',
      lastname: '${user['lastname']}',
      username: '${user['username']}',
      firstname: '${user['firstname']}',
    );
  }

  // Empty users
  static const empty = User();
}
