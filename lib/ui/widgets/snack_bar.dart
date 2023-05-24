import 'package:flutter/material.dart';

void showSnackBar(Color? color, String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 1300),
      elevation: 1,
      dismissDirection: DismissDirection.endToStart,
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      width: 400,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      showCloseIcon: true,
      closeIconColor: Colors.white,
      content: SizedBox(
        height: 25,
        child: Row(
          children: [
            Text(
              message,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void showOrderSnackBar(Color? color, String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 1300),
      elevation: 1,
      dismissDirection: DismissDirection.endToStart,
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      width: 400,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      showCloseIcon: true,
      closeIconColor: Colors.white,
      content: SizedBox(
        height: 25,
        child: Row(
          children: [
            Text(
              message,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                elevation: 0,
                foregroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {},
              child: const Text('checkout'),
            )
          ],
        ),
      ),
    ),
  );
}
