import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grilled_steak_app/ui/menu/cubit/menu_cubit.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'cubit/home_menu_section_cubit.dart';
import 'home_menu_bottom_sheet.dart';

class HomeMenuSection extends StatelessWidget {
  const HomeMenuSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // HomeMenuSection Body
    return BlocProvider(
      create: (context) => HomeMenuSectionCubit(
        menuRepo: RepositoryProvider.of<MenuRepository>(context),
      ),
      child: BlocBuilder<HomeMenuSectionCubit, HomeMenuSectionState>(
        builder: (context, state) {
          if (state.isLoaded) {
            return Column(
              children: [
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.categories,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      child: Text(
                        AppLocalizations.of(context)!.seemore,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        /** */

                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          context: context,
                          builder: (context) {
                            return HomeMenuSectionBottomSheet(
                              menus: state.menus,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),

                // Padding
                const Padding(
                  padding: EdgeInsets.all(10),
                ),

                // menuItems
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      state.menus.length,
                      (index) => Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Ink(
                          width: 90,
                          height: 90,
                          child: InkWell(
                            onTap: () {
                              /** */
                              context.read<MenuCubit>().addMenu(
                                    state.menus[index],
                                  );

                              context.go('/menu');
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FractionallySizedBox(
                                  widthFactor: .4,
                                  child: Image.network(
                                    state.menus[index].imageUrl!,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    state.menus[index].title!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
