part of 'user_cubit.dart';

enum UserStateStauts {
  initial,
  loaded,
  error,
}

enum UserStateStatus {
  initial,
  loaded,
  error,
  accessRevoked,
  accessRevokedError,
  accessGranted,
  accessGrantedError
}

abstract class UserState extends Equatable {
  const UserState({
    required List<User> users,
    required UserStateStatus status,
  })  : _users = users,
        _status = status;

  final List<User> _users;
  final UserStateStatus _status;

  List<User> get users => _users;
  UserStateStatus get status => _status;
  bool get isInitial => this is UserInitial;
  bool get isLoaded => this is UserDataLoaded;
  bool get isLoadedError => this is UserDataLoadedError;
  bool get isAccessRevoked => this is UserAccessRevoked;
  bool get isAccessGranted => this is UserAccessGranted;
  bool get isAccessRevokedError => this is UserAccessRevokedError;
  bool get isAccessGrantedError => this is UserAccessGrantedError;

  @override
  List<Object> get props => [
        _users,
        _status,
      ];
}

class UserInitial extends UserState {
  const UserInitial({required super.users, required super.status});
}

class UserAccessRevoked extends UserState {
  const UserAccessRevoked({required super.users, required super.status});
}

class UserAccessRevokedError extends UserState {
  const UserAccessRevokedError({required super.users, required super.status});
}

class UserAccessGranted extends UserState {
  const UserAccessGranted({required super.users, required super.status});
}

class UserAccessGrantedError extends UserState {
  const UserAccessGrantedError({required super.users, required super.status});
}

class UserDataLoaded extends UserState {
  const UserDataLoaded({required super.users, required super.status});
}

class UserDataLoadedError extends UserState {
  const UserDataLoadedError({required super.users, required super.status});
}
