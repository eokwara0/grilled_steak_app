import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grilled_steak_app/app/authentication/authentication.dart';
import 'package:grilled_steak_app/ui/order/ui/order_body.dart';
import 'package:user_repository/user_repository.dart';

import '../../menu/ui/menu_item/menu_item_edit/ui/text_field_edit.dart';
import '../../widgets/snack_bar.dart';
import 'cubit/change_password_cubit.dart';

class ChangePasswordDialog extends StatelessWidget {
  const ChangePasswordDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(
        userRepository: RepositoryProvider.of<UserRepository>(context),
      ),
      child: BlocListener<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if (state.isSuccess) {
            context.pop();
            showSnackBar(
                Colors.amber[500], 'Password updated successfully', context);
          } else if (state.isError) {
            context.pop();
            showSnackBar(Colors.red[500],
                'An error occured while changing password', context);
          }
        },
        child: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
          builder: (context, state) {
            return Dialog(
              child: Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.center,
                width: 400,
                height: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: const Text(
                        'Change password',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    EditTextField(
                      onChanged: (p0) {
                        context
                            .read<ChangePasswordCubit>()
                            .oldPasswordChanged(p0);
                      },
                      errorText:
                          !state.oldPassword.valid ? 'Invalid Password' : null,
                      obscureText: true,
                      label: 'Current Password',
                      hint: '@oldPassword',
                      maxLines: 1,
                    ),
                    EditTextField(
                      onChanged: (p0) {
                        context
                            .read<ChangePasswordCubit>()
                            .newPasswordChanged(p0);
                      },
                      errorText:
                          !state.newPassword.valid ? 'Invalid Password' : null,
                      obscureText: true,
                      label: 'New Password',
                      hint: '@newPassword',
                      maxLines: 1,
                    ),
                    SizedBox(
                      width: 300,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.amber[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          if (state.oldPassword.valid) {
                            context.read<ChangePasswordCubit>().changePassword(
                                context
                                    .read<AuthenticationBloc>()
                                    .state
                                    .user
                                    .id!);
                          }
                        },
                        child: const Text('Change Password'),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
