import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grilled_steak_app/bloc_auth/authentication/bloc/authentication_event.dart';
import '../../authentication/bloc/authentication_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME PAGE'),
      ),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Builder(
            builder: (context) {
              final userId = context.select(
                (AuthenticationBloc bloc) => bloc.state.user.id,
              );
              return Text('UserID: $userId');
            },
          ),
          ElevatedButton(
            onPressed: () {
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequest());
            },
            child: const Text('Logout'),
          )
        ],
      )),
    );
  }
}
