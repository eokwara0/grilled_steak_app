import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:grilled_steak_app/ui/menu/ui/menu_item/menu_item_edit/ui/text_field_edit.dart';
import 'package:user_repository/user_repository.dart';

import '../cubit/user_add_cubit.dart';

class UserAddPage extends StatefulWidget {
  const UserAddPage({super.key});

  @override
  State<UserAddPage> createState() => _UserAddPageState();
}

class _UserAddPageState extends State<UserAddPage> {
  late String _value;
  @override
  void initState() {
    _value = "Manager";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserAddCubit(
        userRepository: RepositoryProvider.of<UserRepository>(context),
      ),
      child: BlocListener<UserAddCubit, UserAddState>(
        listener: (context, state) {
          if (state.isSuccessful) {
            context.go('/success?message=user has been added');
          } else if (state.isError) {
            context.go('/error?message=An Error occured while adding user');
          }
        },
        child: BlocBuilder<UserAddCubit, UserAddState>(
          builder: (context, state) {
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    leadingWidth: 100,
                    leading: Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        IconButton(
                          padding: const EdgeInsets.all(10),
                          splashRadius: 15,
                          onPressed: () {
                            context.go('/users');
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    title: Text(
                      '# Add User',
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
                              const Text(
                                "Role",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              DropdownButton(
                                iconSize: 30,
                                elevation: 0,
                                underline: Container(),
                                hint: Text(
                                  _value,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                items: [
                                  DropdownMenuItem<String>(
                                    value: 'Manager',
                                    onTap: () {},
                                    child: const Text('Manager'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Waiter',
                                    onTap: () {},
                                    child: const Text('Waiter'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Cashier',
                                    onTap: () {},
                                    child: const Text('Cashier'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Chef',
                                    onTap: () {},
                                    child: const Text('Chef'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _value =
                                        '${value![0]}${value.substring(1)}';
                                    context
                                        .read<UserAddCubit>()
                                        .onRoleChange(value);
                                  });
                                },
                                // dropdownColor: Colors.amber,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(),
                          EditTextField(
                            errorText: state.firstname.invalid
                                ? "Phone number  is Invalid"
                                : null,
                            onChanged: (p0) {
                              context
                                  .read<UserAddCubit>()
                                  .onFirstNameChanged(p0);
                            },
                            label: 'Firstname',
                            hint: state.firstname.value,
                            maxLines: 1,
                          ),
                          const Divider(),
                          EditTextField(
                            errorText: state.lastname.invalid
                                ? "Phone number  is Invalid"
                                : null,
                            onChanged: (p0) {
                              context
                                  .read<UserAddCubit>()
                                  .onLastNameChanged(p0);
                            },
                            label: 'Lastname',
                            hint: state.lastname.value,
                            maxLines: 1,
                          ),
                          const Divider(),
                          EditTextField(
                            errorText: state.username.invalid
                                ? "Phone number  is Invalid"
                                : null,
                            onChanged: (p0) {
                              context
                                  .read<UserAddCubit>()
                                  .onUserNameChanged(p0);
                            },
                            label: 'Username',
                            hint: state.username.value,
                            maxLines: 1,
                          ),
                          const Divider(),
                          EditTextField(
                            errorText: state.email.invalid
                                ? "Phone number  is Invalid"
                                : null,
                            onChanged: (p0) {
                              context.read<UserAddCubit>().onEmailChanged(p0);
                            },
                            label: 'Email',
                            hint: state.email.value,
                            maxLines: 1,
                          ),
                          const Divider(),
                          EditTextField(
                            errorText: state.number.invalid
                                ? "Phone number  is Invalid"
                                : null,
                            onChanged: (p0) {
                              context.read<UserAddCubit>().onNumberChanged(p0);
                            },
                            label: 'PhoneNumber',
                            hint: state.number.value,
                            maxLines: 1,
                          ),
                          const Divider(),
                          EditTextField(
                            onChanged: (p0) {
                              context
                                  .read<UserAddCubit>()
                                  .onPasswordChanged(p0);
                            },
                            errorText: state.password.invalid
                                ? "Password is Invalid"
                                : null,
                            obscureText: true,
                            label: 'Password',
                            hint: state.password.value,
                            maxLines: 1,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              bottomNavigationBar: BottomAppBar(
                padding: const EdgeInsets.all(10),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.amber,
                  ),
                  onPressed: () {
                    if (state.status.isValidated) {
                      context.read<UserAddCubit>().addUser();
                    }
                  },
                  child: const Text('Add User'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
