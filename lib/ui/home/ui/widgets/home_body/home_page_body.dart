import 'package:flutter/material.dart';
import 'package:grilled_steak_app/cart/ui/cart_icon.dart';
import 'package:grilled_steak_app/ui/home/ui/recommendation_section/ui/home_menu_item_recommendation.dart';

import '../home_header/home_header_Image.dart';
import '../home_header/home_header_profile.dart';
import '../home_header/home_header_search.dart';
import '../home_menu_section/home_menu_section.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          stretch: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          leadingWidth: 200,
          actions: [CartIcon()],
          leading: HeaderProfile(),
          bottom: PreferredSize(
            preferredSize: Size(
              double.infinity,
              100,
            ),
            child: MenuSearch(),
          ),
          flexibleSpace: HeaderBackGroundImage(),
          expandedHeight: 300,
          collapsedHeight: 200,
        ),
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                const HomeMenuSection(),
                const Padding(padding: EdgeInsets.all(10)),
                const HomeRecommendedMenuItems(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
