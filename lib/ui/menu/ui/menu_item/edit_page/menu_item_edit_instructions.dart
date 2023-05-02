import 'package:flutter/material.dart';

import 'text_field_edit.dart';

class EditMenuItemInstructions extends StatefulWidget {
  const EditMenuItemInstructions({
    super.key,
    required this.instructions,
    this.instructionsChanged,
  });

  final List<String> instructions;
  final Function(List<String>)? instructionsChanged;

  @override
  State<EditMenuItemInstructions> createState() =>
      _EditMenuItemInstructionsState();
}

class _EditMenuItemInstructionsState extends State<EditMenuItemInstructions> {
  late List<String> _instructions;

  @override
  void initState() {
    super.initState();
    _instructions = widget.instructions;
  }

  @override
  Widget build(BuildContext context) {
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
                  setState(
                    () {
                      _instructions.add('${_instructions.length}');
                    },
                  );
                },
                child: const Text('Add Recipe'),
              ),
            ),
          ],
        ),
        ..._instructions.map((e) {
          int index = _instructions.indexOf(e);
          return Dismissible(
            key: Key(
              '#Instruction$e',
            ),

            // callback functions
            dismissThresholds: const {
              DismissDirection.endToStart: .98,
            },
            onDismissed: (direction) {
              setState(
                () {
                  _instructions.remove(e);
                  widget.instructionsChanged!(_instructions);
                },
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
                    'Step ${_instructions.indexOf(e) + 1}',
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: EditTextField(
                        onFieldSubmitted: (p0) {
                          _instructions[index] = p0;
                          widget.instructionsChanged!(_instructions);
                        },
                        onTapOutside: (p0) {
                          widget.instructionsChanged!(_instructions);
                        },
                        onEditingComplete: () {
                          widget.instructionsChanged!(
                            _instructions,
                          );
                        },
                        onChanged: (value) {
                          _instructions[index] = value;
                        },
                        maxLines: 1,
                        maxLength: 580,
                        padding: const EdgeInsets.only(left: 10),
                        label: '${_instructions.indexOf(e) + 1}',
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
  }
}
