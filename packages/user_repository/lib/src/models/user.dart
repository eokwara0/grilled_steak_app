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
    String? mobile,
  })  : _id = id,
        _role = role,
        _username = username,
        _firstname = firstname,
        _lastname = lastname,
        _emaill = emaill,
        _access = access,
        _mobile = mobile;
  final String? _id;
  final String? _role;
  final String? _username;
  final String? _firstname;
  final String? _lastname;
  final String? _emaill;
  final String? _access;
  final String? _mobile;

  String? get id => _id;
  String? get role => _role;
  String? get username => _username;
  String? get firstname => _firstname;
  String? get lastname => _lastname;
  String? get email => _emaill;
  String? get access => _access;
  String? get mobile => _mobile;

  bool get isAdmin => _role == 'ADMIN' || _role == "MANAGER";
  bool get isChef => _role == 'CHEF';
  bool get hasAccess => access == 'ACTIVE';

  @override
  List<Object?> get props => [
        _id,
        _role,
        _username,
        _firstname,
        _lastname,
        _emaill,
        _access,
        _mobile,
      ];

  Map<String, String> toJson() => {
        "role": _role ?? "",
        "email": _emaill ?? '',
        "lastname": _lastname ?? '',
        "firstname": _firstname ?? '',
        "username": _firstname ?? '',
        "access": _access ?? '',
        "mobile": _mobile ?? '',
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
      mobile: '${user['mobile']}',
    );
  }

  // Empty users
  static const empty = User();
}
