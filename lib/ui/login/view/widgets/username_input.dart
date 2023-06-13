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
          key: const Key('loginForm_usernameInput_textField'),
          enableSuggestions: false,
          onChanged: (username) => context.read<LoginBloc>().add(
                LoginUsernameChanged(username),
              ),
          cursorColor: Colors.amber,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.amber.shade600,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.amber.shade600,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            // labelText: 'username',
            label: Text(
              'username',
              style: TextStyle(
                color: Colors.grey[500],
                fontWeight: FontWeight.w700,
              ),
            ),
            errorText: state.username.invalid ? 'Invalid username' : null,
          ),
        );
      },
    );
  }
}
