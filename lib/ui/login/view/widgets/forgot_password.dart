import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).go('/forgot'),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Forgot Password',
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
