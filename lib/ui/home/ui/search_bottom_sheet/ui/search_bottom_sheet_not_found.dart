import 'package:flutter/material.dart';

class SearchBottomSheetNotFound extends StatelessWidget {
  final String message;
  final Widget? header;

  const SearchBottomSheetNotFound({
    super.key,
    required this.message,
    this.header,
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
                  Navigator.of(context).pop();
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
          children: <Widget>[
            header ?? Container(),
            const Padding(padding: EdgeInsets.all(20)),
            Text(
              message,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
