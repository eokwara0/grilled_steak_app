import 'package:flutter/material.dart';

class SearchBottomSheetNotFound extends StatelessWidget {
  final String message;

  const SearchBottomSheetNotFound({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                ),
              ),
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.all(20)),
        Column(
          children: [
            const CircularProgressIndicator.adaptive(),
            const Padding(padding: EdgeInsets.all(9)),
            Text(message),
          ],
        ),
      ],
    );
  }
}
