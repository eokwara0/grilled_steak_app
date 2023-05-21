import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';

import '../../../../login/models/email.dart';
import '../../../../login/models/number.dart';
import '../../../../login/models/password.dart';
import '../../../../login/models/username.dart';

part 'user_add_state.dart';

class UserAddCubit extends Cubit<UserAddState> {
  UserAddCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(
          UserAddInitial(
            email: const Email.dirty(),
            firstname: const Username.dirty(),
            lastname: const Username.dirty(),
            number: const PhoneNumber.dirty(),
            password: const Password.dirty(),
            user: User.empty.copyWith(access: 'ACTIVE'),
            username: const Username.dirty(),
            status: FormzStatus.invalid,
          ),
        );
  final UserRepository _userRepository;

  onEmailChanged(String email) {
    emit(
      UserDataChanged(
        user: state._user.copyWith(email: email),
        username: state._username,
        firstname: state._firstname,
        lastname: state._lastname,
        number: state._number,
        email: Email.dirty(email),
        password: state._password,
        status: Formz.validate(
          [
            Email.dirty(email),
          ],
        ),
      ),
    );
  }

  onFirstNameChanged(String firstname) {
    return emit(
      UserDataChanged(
        user: state._user.copyWith(firstname: firstname),
        username: state._username,
        firstname: Username.dirty(firstname),
        lastname: state._lastname,
        number: state._number,
        email: state.email,
        password: state._password,
        status: Formz.validate(
          [
            Username.dirty(firstname),
          ],
        ),
      ),
    );
  }

  onLastNameChanged(String lastname) {
    return emit(
      UserDataChanged(
        user: state._user.copyWith(lastname: lastname),
        username: state._username,
        firstname: state._firstname,
        lastname: Username.dirty(lastname),
        number: state._number,
        email: state.email,
        password: state._password,
        status: Formz.validate(
          [
            Username.dirty(lastname),
          ],
        ),
      ),
    );
  }

  onUserNameChanged(String username) {
    return emit(
      UserDataChanged(
        user: state._user.copyWith(username: username),
        username: Username.dirty(username),
        firstname: state._firstname,
        lastname: state._lastname,
        number: state._number,
        email: state._email,
        password: state._password,
        status: Formz.validate(
          [
            Username.dirty(username),
          ],
        ),
      ),
    );
  }

  onNumberChanged(String number) {
    return emit(
      UserDataChanged(
        user: state._user.copyWith(mobile: number),
        username: state._username,
        firstname: state._firstname,
        lastname: state._lastname,
        number: PhoneNumber.dirty(number),
        email: state.email,
        password: state._password,
        status: Formz.validate(
          [
            PhoneNumber.dirty(number),
          ],
        ),
      ),
    );
  }

  onPasswordChanged(String password) {
    return emit(
      UserDataChanged(
        user: state._user.copyWith(password: password),
        username: state._username,
        firstname: state._firstname,
        lastname: state._lastname,
        number: state._number,
        email: state.email,
        password: Password.dirty(password),
        status: Formz.validate(
          [
            Password.dirty(password),
          ],
        ),
      ),
    );
  }

  onRoleChange(String role) {
    return emit(
      UserDataChanged(
        user: state._user.copyWith(role: role),
        username: state._username,
        firstname: state._firstname,
        lastname: state._lastname,
        number: state._number,
        email: state.email,
        password: state.password,
        status: FormzStatus.valid,
      ),
    );
  }

  addUser() async {
    bool res = await _userRepository.addUser(state.user);
    if (res) {
      return emit(
        UserAddedSuccessfully(
          user: state._user,
          username: state._username,
          firstname: state._firstname,
          lastname: state._lastname,
          number: state._number,
          email: state.email,
          password: state.password,
          status: FormzStatus.valid,
        ),
      );
    }
    return emit(
      UserAddError(
        user: state._user,
        username: state._username,
        firstname: state._firstname,
        lastname: state._lastname,
        number: state._number,
        email: state.email,
        password: state.password,
        status: FormzStatus.valid,
      ),
    );
  }
}
