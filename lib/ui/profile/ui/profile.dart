import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grilled_steak_app/app/authentication/authentication.dart';

import 'change_password_dialog.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leadingWidth: 100,
            leading: TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.amber),
              onPressed: () {
                if (BlocProvider.of<AuthenticationBloc>(context)
                    .state
                    .user
                    .isChef) {
                  context.go('/chefPage');
                } else {
                  context.go('/');
                }
              },
              child: const Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.arrow_back_ios_new_rounded),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Back',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
            title: const Text(
              'Profile',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 241, 250, 254),
                          Color.fromARGB(255, 245, 245, 245),
                          Color.fromARGB(255, 239, 247, 252),
                        ],
                      ),
                    ),
                    child: Center(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: Text(
                          '${user.firstname![0].toUpperCase()}${user.lastname![0].toUpperCase()}',
                          style: const TextStyle(
                            letterSpacing: 3,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Account information',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.grey[100],
                    ),
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Username',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber[600],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${user.username}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.grey[100],
                    ),
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Firstname',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber[600],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${user.firstname![0].toUpperCase()}${user.firstname!.substring(
                            1,
                          )}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.grey[100],
                    ),
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Lastname',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber[600],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${user.lastname![0].toUpperCase()}${user.lastname!.substring(
                            1,
                          )}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Contact Information',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.email_outlined,
                          color: Colors.amber[400],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          user.email!.substring(
                            0,
                          ),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  if (user.mobile != 'null')
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.amber[400],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                '${user.mobile}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Security Settings',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const ChangePasswordDialog();
                        },
                      );
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[100],
                      ),
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.password_outlined,
                                color: Colors.amber[400],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Change Password',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
