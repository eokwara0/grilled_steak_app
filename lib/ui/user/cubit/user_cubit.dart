import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const UserInitial(users: [], status: UserStateStatus.initial)) {
    initialize();
  }

  final UserRepository _userRepository;

  Future<void> initialize() async {
    List<User>? users = await _userRepository.getAllUsers();

    if (users != null) {
      return emit(
        UserDataLoaded(users: users, status: UserStateStatus.loaded),
      );
    }
    return emit(const UserDataLoadedError(
      users: [],
      status: UserStateStatus.error,
    ));
  }

  revokeAccess(User user) async {
    emit(
      const UserInitial(users: [], status: UserStateStatus.initial),
    );
    bool response = await _userRepository.revokeAccess(user.id!);

    if (response) {
      List<User>? users = await _getUsers();
      emit(
        UserAccessRevoked(
          users: users ?? [],
          status: UserStateStatus.accessRevoked,
        ),
      );

      return emit(
        UserDataLoaded(
          users: users ?? state._users,
          status: UserStateStatus.loaded,
        ),
      );
    } else {
      emit(
        UserAccessRevokedError(
          users: state._users,
          status: UserStateStatus.accessRevokedError,
        ),
      );
      return emit(
        UserDataLoaded(
          users: state._users,
          status: UserStateStatus.loaded,
        ),
      );
    }
  }

  grantAccess(User user) async {
    emit(
      const UserInitial(users: [], status: UserStateStatus.initial),
    );
    bool response = await _userRepository.grantAccess(user.id!);

    if (response) {
      List<User>? users = await _getUsers();

      emit(
        UserAccessGranted(
          users: users ?? [],
          status: UserStateStatus.accessGranted,
        ),
      );

      return emit(
        UserDataLoaded(
          users: users ?? state._users,
          status: UserStateStatus.loaded,
        ),
      );
    } else {
      emit(
        UserAccessGrantedError(
          users: state._users,
          status: UserStateStatus.accessGrantedError,
        ),
      );
      return emit(
        UserDataLoaded(
          users: state._users,
          status: UserStateStatus.loaded,
        ),
      );
    }
  }

  Future<List<User>?> _getUsers() async {
    final res = await _userRepository.getAllUsers();
    if (res != null) {
      return res;
    }
    return null;
  }
}
