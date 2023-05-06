import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/menu_item_edit_bloc.dart';
import 'text_field_edit.dart';

class EditMenuItemInstructions extends StatelessWidget {
  const EditMenuItemInstructions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuItemEditBloc, MenuItemEditState>(
      buildWhen: (previous, current) {
        final ins = previous.menuItem.item!.instructions!.split('\n').length;
        final ins1 = current.menuItem.item!.instructions!.split('\n').length;

        if (ins == ins1) {
          return false;
        }
        return true;
      },
      builder: (context, state) {
        List<String> instructions =
            state.menuItem.item!.instructions!.split('\n');

        return ExpansionTile(
          shape: const RoundedRectangleBorder(
            side: BorderSide.none,
          ),
          title: Text(
            'Instructions',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextButton(
                    onPressed: () {
                      instructions.add('${instructions.length + 1}');
                      context.read<MenuItemEditBloc>().add(
                            MenuItemInstructionsChangedEvent(
                              instructions.join('\n'),
                            ),
                          );
                    },
                    child: const Text('Add Recipe'),
                  ),
                ),
              ],
            ),
            ...instructions.map((e) {
              int index = instructions.indexOf(e);
              return Dismissible(
                key: Key(
                  '#Instruction$e',
                ),

                // callback functions
                dismissThresholds: const {
                  DismissDirection.endToStart: .98,
                },
                onDismissed: (direction) {
                  instructions.remove(e);
                  context.read<MenuItemEditBloc>().add(
                        MenuItemInstructionsChangedEvent(
                          instructions.join('\n'),
                        ),
                      );
                },
                confirmDismiss: (direction) async {
                  if (direction.index == 2) {
                    return true;
                  }
                  return false;
                },

                // behaviour and dismissal direction
                behavior: HitTestBehavior.translucent,
                direction: DismissDirection.endToStart,

                background: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    ExpansionTile(
                      shape: const RoundedRectangleBorder(
                        side: BorderSide.none,
                      ),
                      title: Text(
                        'Step ${instructions.indexOf(e) + 1}',
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: EditTextField(
                            onChanged: (p0) {
                              instructions[index] = p0;
                              context.read<MenuItemEditBloc>().add(
                                    MenuItemInstructionsChangedEvent(
                                      instructions.join('\n'),
                                    ),
                                  );
                            },
                            maxLines: 1,
                            maxLength: 580,
                            padding: const EdgeInsets.only(left: 10),
                            label: 'step ${instructions.indexOf(e) + 1}',
                            hint: e,
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                    ),
                  ],
                ),
              );
            }).toList()
          ],
        );
      },
    );
  }
}
