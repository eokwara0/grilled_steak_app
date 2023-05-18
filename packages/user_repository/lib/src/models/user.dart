import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    String? id,
    String? role,
    String? username,
    String? firstname,
    String? lastname,
    String? emaill,
    String? access,
  })  : _id = id,
        _role = role,
        _username = username,
        _firstname = firstname,
        _lastname = lastname,
        _emaill = emaill,
        _access = access;
  final String? _id;
  final String? _role;
  final String? _username;
  final String? _firstname;
  final String? _lastname;
  final String? _emaill;
  final String? _access;

  get id => _id;
  get role => _role;
  get username => _username;
  get firstname => _firstname;
  get lastname => _lastname;
  get email => _emaill;
  get access => _access;

  bool get isAdmin => _role == 'ADMIN' || _role == "MANAGER";
  bool get isChef => _role == 'CHEF';

  @override
  List<Object?> get props => [
        _id,
        _role,
        _username,
        _firstname,
        _lastname,
        _emaill,
        _access,
      ];

  Map<String, String> toJson() => {
        role: _role ?? '',
        email: _emaill ?? '',
        lastname: _lastname ?? '',
        firstname: _firstname ?? '',
        username: _firstname ?? '',
        access: _access ?? '',
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
      access: '${user['access']}',
    );
  }

  // Empty users
  static const empty = User();
}
