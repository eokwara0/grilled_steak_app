import 'package:blur/blur.dart';
import 'package:flutter/material.dart';

class HeaderBackGroundImage extends StatelessWidget {
  const HeaderBackGroundImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Blur(
      blur: 2,
      colorOpacity: .3,
      blurColor: Colors.black,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: .9,
            image: NetworkImage('http://localhost:3000/mush.webp'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
