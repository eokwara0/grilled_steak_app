import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grilled_steak_app/ui/home/ui/recommendation_section/cubit/home_menu_item_recommendation_cubit.dart';
import 'package:menu_repository/menu_repository.dart';

class HomeRecommendedMenuItems extends StatefulWidget {
  const HomeRecommendedMenuItems({super.key});

  @override
  State<HomeRecommendedMenuItems> createState() =>
      _HomeRecommendedMenuItemsState();
}

class _HomeRecommendedMenuItemsState extends State<HomeRecommendedMenuItems> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) {
        return HomeMenuItemRecommendationCubit(
            repo: RepositoryProvider.of<MenuItemRepository>(context));
      },
      child: BlocBuilder(
        builder: (context, state) {
          return Column();
        },
      ),
    );
  }
}
