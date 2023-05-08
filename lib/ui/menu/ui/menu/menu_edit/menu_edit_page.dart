import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grilled_steak_app/ui/menu/ui/menu/menu_edit/cubit/menu_edit_cubit.dart';
import 'package:grilled_steak_app/ui/menu/ui/menu_item/menu_item_edit/ui/menu_item_edit_error.dart';
import 'package:grilled_steak_app/ui/menu/ui/menu_item/menu_item_edit/ui/menu_item_edit_success.dart';
import 'package:grilled_steak_app/ui/menu/ui/menu_item/menu_item_edit/ui/text_field_edit.dart';

class MenuEditPage extends StatelessWidget {
  const MenuEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuEditCubit, MenuEditState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: !state.isSubmitted || !state.isError
              ? BottomAppBar(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          context.read<MenuEditCubit>().addMenu(state.menu);
                        },
                        child: const Text(
                          'Add Menu',
                          style: TextStyle(
                            color: Colors.amber,
                          ),
                        ),
                      ),
                      // Spacer(),
                    ],
                  ),
                )
              : null,
          body: state.isSubmitted
              ? const MenuItemEditSuccess(
                  message: 'Menu has been added successfully')
              : state.isError
                  ? const MenuItemEditErrorPage(message: 'An Error occured')
                  : CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          // expandedHeight: 100,
                          pinned: true,
                          backgroundColor:
                              Theme.of(context).colorScheme.onBackground,
                          leading: IconButton(
                            onPressed: () {
                              context.go('/');
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          title: !state.isSubmitted || !state.isError
                              ? SizedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        width: 40,
                                        height: 40,
                                        state.menu.imageUrl!,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        '#${state.menu.title!}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          overflow: TextOverflow.fade,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : null,
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(20),
                          sliver: SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      style: BorderStyle.solid,
                                      color: Colors.amber.shade400,
                                    ),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      context
                                          .read<MenuEditCubit>()
                                          .uploadImage();
                                    },
                                    style: TextButton.styleFrom(
                                      minimumSize: const Size(100, 50),
                                    ),
                                    child: Text(
                                      'Upload Image',
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                EditTextField(
                                  onChanged: (value) {
                                    context
                                        .read<MenuEditCubit>()
                                        .titleChange(value);
                                  },
                                  maxLength: 20,
                                  maxLines: 1,
                                  padding: const EdgeInsets.all(10),
                                  label: 'Title',
                                  hint: state.menu.title!,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                EditTextField(
                                  onChanged: (value) {
                                    context
                                        .read<MenuEditCubit>()
                                        .summaryChanged(value);
                                  },
                                  maxLength: 100,
                                  maxLines: 1,
                                  padding: const EdgeInsets.all(10),
                                  label: 'Summary',
                                  hint: state.menu.summary!,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                EditTextField(
                                  onChanged: (value) {
                                    context
                                        .read<MenuEditCubit>()
                                        .contentChanged(value);
                                  },
                                  maxLength: 500,
                                  maxLines: 1,
                                  padding: const EdgeInsets.all(10),
                                  label: 'Content',
                                  hint: state.menu.content ?? '',
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
        );
      },
    );
  }
}
