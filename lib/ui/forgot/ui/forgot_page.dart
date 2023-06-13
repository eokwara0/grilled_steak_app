import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:grilled_steak_app/ui/forgot/cubit/forgot_password_cubit.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  context.go('/login');
                },
                child: const Icon(
                  Icons.arrow_back,
                ),
              ),
              Image.asset('images/logo1.jpg'),
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Forgot',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Ubuntu Mono',
                      ),
                    ),
                    Text(
                      'Password',
                      style: TextStyle(
                        color: Colors.red.shade300,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Ubuntu Mono',
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.all(20)),
              const EmailForm(),
              const Padding(
                padding: EdgeInsets.all(20),
              ),
              const SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class EmailForm extends StatelessWidget {
  const EmailForm({super.key});

  @override
  Widget build(BuildContext context) {
    // bloc builder
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Form(
          child: Column(
            children: [
              TextField(
                autofocus: true,
                maxLength: 50,
                onChanged: (value) {
                  context.read<ForgotPasswordCubit>().onEmailChanged(value);
                },
                // decorations
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorText:
                      state.email.invalid ? "Please input a valid email" : null,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordLoaded) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const Dialog(
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: DialogBox(
                  text: 'Check your email for link',
                  icon: Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 100,
                  ),
                ),
              );
            },
          );
        } else if (state is ForgotPasswordError) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return const Dialog(
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: DialogBox(
                  text: 'An Error occured',
                  icon: Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 100,
                  ),
                ),
              );
            },
          );
        }
      },
      child: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
        builder: (context, state) {
          if (state is ForgotPasswordSubmissionInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ElevatedButton(
              onPressed: () {
                if (state.status.isValidated) {
                  context.read<ForgotPasswordCubit>().submit();
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(12),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              child: Row(
                children: const <Widget>[
                  Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class DialogBox extends StatelessWidget {
  final String text;
  final Widget icon;
  const DialogBox({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      alignment: Alignment.center,
      child: Container(
        width: 300,
        height: 200,
        alignment: Alignment.center,
        child: Column(
          children: [
            IconButton(
              padding: const EdgeInsets.only(
                right: 20,
              ),
              onPressed: () {
                context.go('/login');
              },
              icon: const Icon(
                Icons.close,
                color: Colors.grey,
              ),
            ),
            icon,
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(text),
            )
          ],
        ),
      ),
    );
  }
}
