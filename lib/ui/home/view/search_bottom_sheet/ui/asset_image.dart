import 'package:flutter/material.dart';

class AssetImageCover extends StatelessWidget {
  final String url;

  const AssetImageCover({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(url),
      fit: BoxFit.cover,
    );
  }
}
