import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_repository/menu_repository.dart';

import 'cubit/home_menu_section_cubit.dart';

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
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      child: Text(
                        'see all',
                        style: TextStyle(
                          color: Colors.amber.shade400,
                        ),
                      ),
                      onTap: () {/** */},
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
                        child: Ink(
                          width: 90,
                          height: 90,
                          child: InkWell(
                            onTap: () {
                              /** */
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FractionallySizedBox(
                                  widthFactor: .4,
                                  child: Image.network(
                                      state.menus[index].imageUrl!),
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
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
