import 'package:blur/blur.dart';
import 'package:flutter/material.dart';

import 'home_header_Image.dart';
import 'home_header_profile.dart';
import 'home_header_search.dart';

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
          // pinned: true,
          backgroundColor: Colors.white,
          elevation: 0.0,

          // leading icons
          leadingWidth: 200,

          leading: HeaderProfile(),

          bottom: PreferredSize(
            preferredSize: Size(
              double.infinity,
              50,
            ),
            child: MenuSearch(),
          ),

          // flexible space
          flexibleSpace: HeaderBackGroundImage(),
          expandedHeight: 200,
          collapsedHeight: 150,
        ),

        // sliver list
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Column(
                children: [
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: const Text('item'),
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
