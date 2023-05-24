import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:grilled_steak_app/ui/widgets/snack_bar.dart';
import '../bloc/login_bloc.dart';
import 'widgets/forgot_password.dart';
import 'widgets/login_button.dart';
import 'widgets/password_input.dart';
import 'widgets/username_input.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          showSnackBar(Colors.red[500], 'Authenticatoin Failure', context);
        }
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/logo.jpg'),
            const UsernameInput(),
            const Padding(padding: EdgeInsets.all(12)),
            const PasswordInput(),
            const Padding(padding: EdgeInsets.all(12)),
            const LoginButton(),
            const ForgotPassword(),
          ],
        ),
      ),
    );
  }
}
