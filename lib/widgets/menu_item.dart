import 'package:flutter/material.dart';
import 'package:restaurant_app/themes/style.dart';

class MenuItem extends StatelessWidget {
  final String menuItem;
  final Color color;
  final IconData icons;
  MenuItem({required this.menuItem, required this.color, required this.icons});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Chip(
          backgroundColor: color,
          avatar: Icon(
            icons,
            size: 15,
            color: Colors.white,
          ),
          label: Text(
            menuItem,
            style: myTextTheme.subtitle2!
                .copyWith(fontWeight: FontWeight.w100, color: Colors.white),
          )),
    );
  }
}
