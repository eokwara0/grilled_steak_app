import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../app/authentication/authentication.dart';

class HeaderProfile extends StatelessWidget {
  const HeaderProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(10),
        ),
        InkWell(
          onTap: () {
            context.go('/profile');
          },
          child: Ink(
            child: CircleAvatar(
              radius: 17,
              backgroundColor: Colors.grey.shade100,
              child: Text(
                context
                    .read<AuthenticationBloc>()
                    .state
                    .user
                    .username![0]
                    .toUpperCase(),
                style: TextStyle(
                  color: Colors.amber[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(10),
        ),
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
            const Padding(
              padding: EdgeInsets.all(2.0),
            ),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.greeting,
                  style: TextStyle(
                    color: Colors.white.withOpacity(1),
                    fontSize: 13,
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
