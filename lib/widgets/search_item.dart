import 'package:flutter/material.dart';
import 'package:restaurant_app/model/list_restaurant.dart';
import 'package:restaurant_app/screens/detail_page.dart';
import 'package:restaurant_app/themes/style.dart';

class SearchItem extends StatelessWidget {
  final Restaurants? restaurant;

  SearchItem({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.blueGrey,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                id: "${restaurant?.id}",
              ),
            ));
      },
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        height: 100,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Hero(
                tag: "${restaurant?.pictureId}",
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage("${restaurant?.pictureId}"),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "${restaurant?.name}",
                      style: myTextTheme.bodyText2!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.map,
                          size: 20,
                          color: Colors.blueGrey[600],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${restaurant?.city}",
                          style: myTextTheme.caption!
                              .copyWith(fontWeight: FontWeight.w100),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_half_rounded,
                          color: Colors.yellow[700],
                          size: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${restaurant?.rating}",
                          style: myTextTheme.caption!
                              .copyWith(fontWeight: FontWeight.w100),
                        ),
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
