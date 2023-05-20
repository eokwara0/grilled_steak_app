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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.amber,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.amber,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            // labelText: 'username',
            label: Text(
              'username',
              style: TextStyle(
                color: Colors.amber[800],
                fontWeight: FontWeight.w500,
              ),
            ),
            errorText: state.username.invalid ? 'Invalid username' : null,
          ),
        );
      },
    );
  }
}
