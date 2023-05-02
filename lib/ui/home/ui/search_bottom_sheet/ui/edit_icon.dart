import 'package:flutter/material.dart';

class EditIcon extends StatelessWidget {
  const EditIcon({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.edit,
        size: 20,
      ),
    );
  }
}
