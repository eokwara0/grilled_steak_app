import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grilled_steak_app/ui/order/ui/order_body.dart';
import 'package:grilled_steak_app/ui/order/ui/order_button_widget.dart';
import 'package:grilled_steak_app/ui/splash/view/splash_page.dart';
import 'package:user_repository/user_repository.dart';

import '../cubit/user_cubit.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(
          userRepository: RepositoryProvider.of<UserRepository>(context)),
      child: Scaffold(
        body: BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state.isAccessRevoked) {
              OrderBody.showSnackBar(
                context,
                Colors.amber[600],
                'User Access has been revoked',
              );
            } else if (state.isAccessRevokedError) {
              OrderBody.showSnackBar(
                context,
                Colors.red,
                'An Error Occured while revoking access',
              );
            } else if (state.isAccessGranted) {
              OrderBody.showSnackBar(
                context,
                Colors.amber[600],
                'Access has been granted to user',
              );
            } else if (state.isAccessGrantedError) {
              OrderBody.showSnackBar(
                context,
                Colors.red[500],
                'An Error occured while granting access',
              );
            }
          },
          child: BlocBuilder<UserCubit, UserState>(
            buildWhen: (previous, current) {
              print(previous.status);
              print(current.status);
              return previous.status != current.status;
            },
            builder: (context, state) {
              if (state.isLoaded) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      leading: IconButton(
                          splashRadius: 15,
                          onPressed: () {
                            context.go('/');
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.grey[500],
                          )),
                      backgroundColor:
                          Theme.of(context).colorScheme.onBackground,
                      pinned: true,
                      title: Text(
                        '# User Management',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(20),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Chip(
                                  label: Text(
                                    'Team',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  backgroundColor: Colors.amber[300],
                                ),
                                Chip(
                                  label: Text('${state.users.length}'),
                                  backgroundColor: Colors.amber[100],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ...state.users.map((user) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[100]),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 30,
                                                child: Text(
                                                  user.firstname![0]
                                                      .toUpperCase(),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '${user.firstname![0].toUpperCase()}${user.firstname!.substring(1)} ${user.lastname}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.grey[600],
                                                  fontSize: 15,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                '@${user.username}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Firstname',
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                  Text(
                                                    '${user.firstname![0].toUpperCase()}${user.firstname!.substring(1)}',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey[600],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Lastname',
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                  Text(
                                                    '${user.lastname![0].toUpperCase()}${user.lastname!.substring(1)}',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey[600],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Username',
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                  Text(
                                                    '${user.username![0].toUpperCase()}${user.username!.substring(1)}',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey[600],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Role',
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                  Text(
                                                    '${user.role![0].toUpperCase()}${user.role!.substring(1)}',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey[600],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Access',
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      user.hasAccess
                                                          ? Container(
                                                              width: 35,
                                                              height: 35,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .amber[100],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  100,
                                                                ),
                                                              ),
                                                              child: const Icon(
                                                                Icons
                                                                    .check_circle,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                            )
                                                          : Container(
                                                              width: 35,
                                                              height: 35,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .red[100],
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  100,
                                                                ),
                                                              ),
                                                              child: const Icon(
                                                                Icons.error,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                      const SizedBox(width: 10),
                                                      Text(
                                                        '${user.access![0].toUpperCase()}${user.access!.substring(1)}',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Colors.grey[600],
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 15),
                                              if (user.hasAccess)
                                                OrderButtonWidget(
                                                  content: 'Revoke Access',
                                                  color: Colors.amber,
                                                  onPressed: () {
                                                    context
                                                        .read<UserCubit>()
                                                        .revokeAccess(user);
                                                  },
                                                ),
                                              if (!user.hasAccess)
                                                OrderButtonWidget(
                                                  content: 'Grant Access',
                                                  color: Colors.green,
                                                  onPressed: () {
                                                    context
                                                        .read<UserCubit>()
                                                        .grantAccess(user);
                                                  },
                                                )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              );
                            })
                          ],
                        ),
                      ),
                    )
                  ],
                );
              } else if (state.isInitial) {
                return const SizedBox(
                  height: 400,
                  child: SplashPage(),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
