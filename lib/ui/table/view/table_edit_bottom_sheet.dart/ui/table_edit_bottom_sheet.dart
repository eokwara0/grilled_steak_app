import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grilled_steak_app/ui/menu/ui/menu_item/menu_item_edit/ui/text_field_edit.dart';
import 'package:grilled_steak_app/ui/table/view/table_edit_bottom_sheet.dart/cubit/table_edit_cubit.dart';

import '../../../cubit/manage_table_cubit.dart';

class TableEditBottomSheet extends StatefulWidget {
  const TableEditBottomSheet({
    super.key,
  });

  @override
  State<TableEditBottomSheet> createState() => _TableEditBottomSheetState();
}

class _TableEditBottomSheetState extends State<TableEditBottomSheet> {
  late bool show;

  @override
  void initState() {
    super.initState();
    show = false;
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      constraints: const BoxConstraints(minHeight: 600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onClosing: () {},
      builder: (context) {
        return BlocBuilder<TableEditCubit, TableEditState>(
          builder: (context, state) {
            print(state.table.capacity);
            return CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: SliverHeader(),
                  pinned: true,
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EditTextField(
                              onChanged: (p0) {
                                context
                                    .read<TableEditCubit>()
                                    .capacityChanged(p0);
                              },
                              label: 'Capacity',
                              hint: '${state.table.capacity}',
                              maxLines: 1,
                            ),
                            if (!show)
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.amber,
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    show = !show;
                                  });
                                },
                                child: const Text(
                                  'Add Reservation',
                                ),
                              ),
                            if (show) const ReservationBody(),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}

class SliverHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return BlocBuilder<TableEditCubit, TableEditState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Theme.of(context).colorScheme.onBackground,
          ),
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '# Table ${context.read<ManageTableCubit>().state.availableTables.indexOf(state.table) + 1}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      '${state.table.capacity} seats',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
              const Spacer(),

              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextButton(
                  onPressed: () {
                    context.pop(context);
                  },
                  child: Row(
                    children: const <Widget>[
                      Icon(
                        Icons.cancel_outlined,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Close',
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              )
              // Text('helo')
            ],
          ),
        );
      },
    );
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class ReservationBody extends StatelessWidget {
  const ReservationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TableEditCubit, TableEditState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              EditTextField(
                onChanged: (p0) {
                  context.read<TableEditCubit>().firstNameChanged(p0);
                },
                errorText:
                    state.firstname!.invalid ? 'Invalid firstname' : null,
                label: 'Firstname',
                hint: 'firstname',
                maxLines: 1,
              ),
              EditTextField(
                onChanged: (p0) {
                  context.read<TableEditCubit>().lastNameChanged(p0);
                },
                errorText: state.lastname!.invalid ? 'Invalid lastname' : null,
                label: 'Lastname',
                hint: 'lastname',
                maxLines: 1,
              ),
              EditTextField(
                onChanged: (p0) {
                  context.read<TableEditCubit>().mobileChanged(p0);
                },
                errorText:
                    state.number!.invalid ? 'Invalid mobile Number' : null,
                label: 'Mobile',
                hint: 'mobile',
                maxLines: 1,
              ),
              EditTextField(
                onChanged: (p0) {
                  context.read<TableEditCubit>().emailChanged(p0);
                },
                errorText: state.email!.invalid ? 'Invalid email' : null,
                label: 'Email',
                hint: 'email',
                maxLines: 1,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.amber,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime(DateTime.now().year,
                        DateTime.now().month, DateTime.now().day),
                    firstDate: DateTime(DateTime.now().year,
                        DateTime.now().month, DateTime.now().day),
                    lastDate: DateTime(DateTime.now().year,
                        DateTime.now().month, DateTime.now().day + 5),
                    initialEntryMode: DatePickerEntryMode.input,
                    initialDatePickerMode: DatePickerMode.day,
                  );

                  // ignore: use_build_context_synchronously
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  final datetime = date!.add(
                    Duration(
                      hours: time!.hour,
                      minutes: time.minute,
                    ),
                  );

                  final datetime2 = datetime.add(
                    const Duration(hours: 1, minutes: 30),
                  );

                  // ignore: use_build_context_synchronously
                  context
                      .read<TableEditCubit>()
                      .dateChanged(datetime, datetime2);
                },
                child: const Text('Select Date'),
              ),
            ],
          ),
        );
      },
    );
  }
}
