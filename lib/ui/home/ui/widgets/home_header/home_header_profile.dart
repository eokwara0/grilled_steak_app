import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../authentication/authentication.dart';

class HeaderProfile extends StatelessWidget {
  const HeaderProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Header row
    return Row(
      // aligning to the right
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // padding
        const Padding(
          padding: EdgeInsets.all(10),
        ),

        // circle Avatar
        CircleAvatar(
          radius: 17,
          backgroundColor: Colors.grey.shade100,
          child: Text(
            '${context.read<AuthenticationBloc>().state.user.username![0]}'
                .toUpperCase(),
          ),
        ),

        // padding seperation
        const Padding(
          padding: EdgeInsets.all(10),
        ),

        // welcome message text
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                return Text(
                  'Hi, ${state.user.firstname}'.toUpperCase(),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white.withOpacity(1),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),

            // separte text
            const Padding(
              padding: EdgeInsets.all(2.0),
            ),

            // welcome back text
            Row(
              children: [
                Text(
                  'Welcome back!',
                  style: TextStyle(
                    color: Colors.white.withOpacity(1),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
