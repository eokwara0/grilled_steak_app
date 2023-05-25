import 'package:flutter/material.dart';

class GrilledHouseButton extends StatelessWidget {
  const GrilledHouseButton({
    super.key,
    required this.content,
    required this.color,
    required this.onPressed,
  });

  final String content;
  final Color? color;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: color ?? Colors.red[500],
        ),
        child: Text(
          content,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
