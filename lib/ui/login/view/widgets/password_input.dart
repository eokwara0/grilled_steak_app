import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/login_bloc.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({super.key});

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  late bool _obscureText = true;
  late Color? _suffixIconColor = Colors.amber;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) {
        return previous.password != current.password;
      },
      builder: (context, state) {
        return TextField(
          obscureText: _obscureText,
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) => context.read<LoginBloc>().add(
                LoginPasswordChanged(password),
              ),
          cursorColor: Colors.amber,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            suffixIconColor: _suffixIconColor,
            suffixIcon: GestureDetector(
              child: const Icon(Icons.remove_red_eye_rounded),
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                  if (_suffixIconColor == Colors.amber) {
                    _suffixIconColor = Colors.grey[400];
                  } else {
                    _suffixIconColor = Colors.amber;
                  }
                });
              },
            ),
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
