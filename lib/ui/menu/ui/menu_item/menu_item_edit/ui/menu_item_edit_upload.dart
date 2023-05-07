import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/menu_item_edit_bloc.dart';

class MenuItemEditUploadImage extends StatelessWidget {
  const MenuItemEditUploadImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuItemEditBloc, MenuItemEditState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              style: BorderStyle.solid,
              color: Colors.amber.shade400,
            ),
          ),
          child: TextButton(
            onPressed: () {
              context
                  .read<MenuItemEditBloc>()
                  .add(const MenuItemFileChangedEvent(''));
            },
            style: TextButton.styleFrom(
              minimumSize: const Size(100, 50),
            ),
            child: Text(
              'Upload Image',
              style: TextStyle(
                color: Colors.grey.shade500,
              ),
            ),
          ),
        );
      },
    );
  }
}
