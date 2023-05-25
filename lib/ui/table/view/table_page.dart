import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grilled_steak_app/ui/widgets/splash_page.dart';
import 'package:grilled_steak_app/ui/table/cubit/manage_table_cubit.dart';
import 'package:grilled_steak_app/ui/table/view/table_edit_bottom_sheet.dart/cubit/table_edit_cubit.dart';
import 'package:grilled_steak_app/ui/table/view/table_reservation_bottom_sheet.dart/cubit/reservation_bottom_sheet_cubit.dart';
import 'package:grilled_steak_app/ui/table/view/table_reservation_bottom_sheet.dart/ui/table_reservation_bottom_sheet.dart';

import 'table_edit_bottom_sheet.dart/ui/table_edit_bottom_sheet.dart';

class Tablepage extends StatefulWidget {
  const Tablepage({super.key});

  @override
  State<Tablepage> createState() => _TablepageState();
}

class _TablepageState extends State<Tablepage>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Text(
          '# Manage Reservations',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size(100, 100),
          child: TableView(
            controller: controller,
          ),
        ),
        elevation: .1,
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        leading: IconButton(
          onPressed: () {
            context.go('/');
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.grey,
          ),
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          BlocBuilder<ManageTableCubit, ManageTableState>(
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    sliver: SliverList(
                      delegate: SliverChildListDelegate.fixed(
                        [
                          if (state.isLoaded)
                            ...List.generate(
                              state.availableTables.length,
                              (index) => Column(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      context.read<TableEditCubit>().addTable(
                                            state.availableTables[index],
                                          );
                                      showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        context: context,
                                        builder: (context) {
                                          return const TableEditBottomSheet();
                                        },
                                      );
                                    },
                                    title: Text(
                                      'Table ${index + 1}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    subtitle: Text(
                                        '${state.availableTables[index].capacity} seating'),
                                  ),
                                  const Divider()
                                ],
                              ),
                            ),
                          if (state.isInitial)
                            const SizedBox(
                              width: double.infinity,
                              height: 200,
                              child: SplashPage(),
                            )
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                  )
                ],
              );
            },
          ),
          BlocBuilder<ManageTableCubit, ManageTableState>(
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    sliver: SliverList(
                      delegate: SliverChildListDelegate.fixed(
                        [
                          if (state.isLoaded)
                            ...List.generate(
                              state.reservedTables.length,
                              (index) => Column(
                                children: [
                                  ListTile(
                                    // isThreeLine: true,
                                    onTap: () {
                                      context
                                          .read<ReservationBottomSheetCubit>()
                                          .addTable(
                                            state.reservedTables[index],
                                          );

                                      showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        context: context,
                                        builder: (context) {
                                          return const ReservationBottomSheet();
                                        },
                                      );
                                    },
                                    title: Text(
                                      'Table ${index + 1}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${state.reservedTables[index].capacity} seats',
                                    ),
                                  ),
                                  const Divider()
                                ],
                              ),
                            ),
                          if (state.isInitial)
                            const SizedBox(
                              width: double.infinity,
                              height: 200,
                              child: SplashPage(),
                            )
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class TableView extends StatelessWidget {
  const TableView({
    super.key,
    required this.controller,
  });

  final TabController controller;
  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorColor: Colors.amber,
      // padding: EdgeInsets.all(20),
      controller: controller,
      tabs: const <Widget>[
        Tab(
          child: Text(
            'Available Tables',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
        Tab(
          child: Text(
            'Reservations',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }
}
