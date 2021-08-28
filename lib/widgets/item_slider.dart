import 'package:flutter/material.dart';

class ItemSlider extends StatelessWidget {
  final imageName;
  ItemSlider({this.imageName});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage(imageName), fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }
}
