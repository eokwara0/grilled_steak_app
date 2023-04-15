import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login_bloc.dart';

class UsernameInput extends StatelessWidget {
  const UsernameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) {
        return previous.username != current.username;
      },
      builder: (context, state) {
        return TextField(
          obscuringCharacter: '*',
          key: const Key('loginForm_usernameInput_textField'),
          enableSuggestions: true,
          onChanged: (username) => context.read<LoginBloc>().add(
                LoginUsernameChanged(username),
              ),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'username',
            errorText: state.username.invalid ? 'Invalid username' : null,
          ),
        );
      },
    );
  }
}
