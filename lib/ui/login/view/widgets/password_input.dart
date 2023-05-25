import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login_bloc.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) {
        return previous.password != current.password;
      },
      builder: (context, state) {
        return TextField(
          obscureText: true,
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) => context.read<LoginBloc>().add(
                LoginPasswordChanged(password),
              ),
          cursorColor: Colors.amber,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.amber,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.amber,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            label: Text(
              'password',
              style: TextStyle(
                color: Colors.grey[500],
                fontWeight: FontWeight.w600,
              ),
            ),
            errorText: state.password.invalid ? 'invalid' : null,
          ),
        );
      },
    );
  }
}
