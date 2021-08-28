import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:restaurant_app/data/images_slider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/themes/style.dart';
import 'package:restaurant_app/widgets/build_list.dart';
import 'package:restaurant_app/widgets/build_search.dart';
import 'package:restaurant_app/widgets/item_slider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselController _carouselController = CarouselController();

  final TextEditingController _textController = TextEditingController();
  String query = "";

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<RestaurantProvider>(
            builder: (context, data, child) {
              return TextField(
                controller: _textController,
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                  data.getRestaurantsSearch(query);
                },
                decoration: InputDecoration(
                    hintText: "search by name, category, or menu",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
          CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount: images.length,
              itemBuilder: (context, index, realIndex) {
                return ItemSlider(
                  imageName: images[index],
                );
              },
              options: CarouselOptions(
                height: 180,
                viewportFraction: .6,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                enlargeCenterPage: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                scrollPhysics: BouncingScrollPhysics(),
              )),
          SizedBox(
            height: 20,
          ),
          Text(
            "Recomended for you",
            style: myTextTheme.headline6,
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(child: (query.trim().isEmpty) ? BuildList() : BuildSearch())
        ],
      ),
    )));
  }
}
