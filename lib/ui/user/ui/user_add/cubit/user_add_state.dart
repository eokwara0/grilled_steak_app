part of 'user_add_cubit.dart';

abstract class UserAddState extends Equatable {
  const UserAddState({
    required User user,
    required Username username,
    required Username firstname,
    required Username lastname,
    required PhoneNumber number,
    required Email email,
    required Password password,
    required FormzStatus status,
  })  : _user = user,
        _username = username,
        _firstname = firstname,
        _password = password,
        _number = number,
        _email = email,
        _lastname = lastname,
        _status = status;

  final User _user;
  final Username _username;
  final Username _firstname;
  final Username _lastname;
  final Password _password;
  final PhoneNumber _number;
  final Email _email;
  final FormzStatus _status;

  User get user => _user;
  Username get username => _username;
  Username get firstname => _firstname;
  Username get lastname => _lastname;
  Password get password => _password;
  PhoneNumber get number => _number;
  Email get email => _email;
  FormzStatus get status => _status;

  bool get isInitial => this is UserAddInitial;
  bool get isSuccessful => this is UserAddedSuccessfully;
  bool get isError => this is UserAddError;
  bool get isChanged => this is UserDataChanged;

  @override
  List<Object> get props => [
        _user,
        _username,
        _firstname,
        _lastname,
        _password,
        _number,
        _email,
        _status
      ];
}

class UserAddInitial extends UserAddState {
  const UserAddInitial({
    required super.user,
    required super.username,
    required super.firstname,
    required super.lastname,
    required super.number,
    required super.email,
    required super.password,
    required super.status,
  });
}

class UserDataChanged extends UserAddState {
  const UserDataChanged({
    required super.user,
    required super.username,
    required super.firstname,
    required super.lastname,
    required super.number,
    required super.email,
    required super.password,
    required super.status,
  });
}

class UserAddedSuccessfully extends UserAddState {
  const UserAddedSuccessfully({
    required super.user,
    required super.username,
    required super.firstname,
    required super.lastname,
    required super.number,
    required super.email,
    required super.password,
    required super.status,
  });
}

class UserAddError extends UserAddState {
  const UserAddError({
    required super.user,
    required super.username,
    required super.firstname,
    required super.lastname,
    required super.number,
    required super.email,
    required super.password,
    required super.status,
  });
}
