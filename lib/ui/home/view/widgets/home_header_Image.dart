import 'package:flutter/material.dart';
import 'package:blur/blur.dart';

class HeaderBackGroundImage extends StatelessWidget {
  const HeaderBackGroundImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Blur(
      blur: 1,
      colorOpacity: .3,
      blurColor: Colors.black,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: .9,
            image: AssetImage('images/bag.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
