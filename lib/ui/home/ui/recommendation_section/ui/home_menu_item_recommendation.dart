import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:menu_repository/menu_repository.dart';

import '../../../../menu/ui/menu_item/cubit/menu_item_cubit.dart';
import '../cubit/home_menu_item_recommendation_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'home_menu_item_recommendation_bottom_sheet.dart';

class HomeRecommendedMenuItems extends StatelessWidget {
  const HomeRecommendedMenuItems({super.key, required this.sectionText});

  final String sectionText;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return HomeMenuItemRecommendationCubit(
          repo: RepositoryProvider.of<MenuItemRepository>(context),
        );
      },
      child: BlocBuilder<HomeMenuItemRecommendationCubit,
          HomeMenuItemRecommendationState>(
        builder: (context, state) {
          if (state.isLoaded) {
            List<MenuItem> some =
                state.menuItem.sublist(0, state.menuItem.length ~/ 2);
            some.shuffle();
            return Column(
              children: [
                Row(
                  children: [
                    Text(
                      sectionText,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const Spacer(),
                    Ink(
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            context: context,
                            builder: (context) {
                              return HomeMenuItemRecommendationBottomSheet(
                                items: state.menuItem,
                              );
                            },
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.seemore,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.all(10)),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: some
                        .map(
                          (e) => SizedBox(
                            height: 270,
                            child: Ink(
                              child: Card(
                                margin: const EdgeInsets.only(right: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Ink(
                                      width: 200,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            e.imageUrl!,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          context
                                              .read<MenuItemCubit>()
                                              .addItem(e);

                                          context.go('/menuItem');
                                        },
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.centerLeft,
                                      width: 190,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.item!.title!,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(5),
                                          ),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.schedule,
                                                    size: 18,
                                                    color: Colors.grey,
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.all(2),
                                                  ),
                                                  Text(
                                                    e.item!.prep!,
                                                    style: TextStyle(
                                                      color:
                                                          Colors.grey.shade700,
                                                      fontSize: 11,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                  right: 8.0,
                                                  left: 8.0,
                                                ),
                                                child: Icon(
                                                  Icons.fiber_manual_record,
                                                  color: Colors.grey,
                                                  size: 10,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .local_fire_department_sharp,
                                                    color: Colors.grey.shade400,
                                                  ),
                                                  Text(
                                                    '${e.item?.nutrition?.calories} Kal',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(2),
                                          ),
                                          Text(
                                            'R${(e.item?.price)?.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                              color: Colors.grey.shade600,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
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
