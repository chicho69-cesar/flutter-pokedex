import 'package:flutter/material.dart';

class PokeballImage extends StatelessWidget {
  const PokeballImage({
    Key? key, this.width, this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/pokeball.png',
      width: width,
      height: height,
      fit: width != null ? BoxFit.fitWidth : BoxFit.fitHeight,
    );
  }
}