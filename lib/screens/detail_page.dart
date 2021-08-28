import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/state.dart';
import 'package:restaurant_app/model/restaurant_detail.dart';
import 'package:restaurant_app/provider/detail_provider.dart';
import 'package:restaurant_app/screens/post_review_screen.dart';
import 'package:restaurant_app/themes/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:restaurant_app/widgets/menu_item.dart';

class DetailPage extends StatefulWidget {
  static const String route = "/detail";
  final String id;

  DetailPage({required this.id});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<DetailProvider>(context, listen: false)
          .getDetailRestaurant(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DetailProvider>(
        builder: (context, value, child) {
          if (value.state == ResultState.Loading) {
            return Center(
              child: Lottie.asset('assets/loading.json', height: 200),
            );
          } else if (value.state == ResultState.HasData) {
            final data = value.detailResult?.restaurant;
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 300,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Hero(
                        tag: data?.id ?? "",
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: data?.pictureId ?? "",
                          placeholder: (context, url) =>
                              Image.asset("assets/images/placeholder.png"),
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/images/placeholder.png"),
                        ),
                      ),
                    ),
                  )
                ];
              },
              body: Padding(
                padding: const EdgeInsets.all(15),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Text(
                      data?.name ?? "",
                      style: myTextTheme.bodyText1!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.map,
                          color: Colors.blueGrey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          data?.city ?? "",
                          style: myTextTheme.bodyText2!
                              .copyWith(fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_half_rounded,
                          color: Colors.yellow,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          data?.rating.toString() ?? "",
                          style: myTextTheme.bodyText2!
                              .copyWith(fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Container(
                        height: 40,
                        child: ListView.builder(
                          itemCount: data?.categories.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var categoryName = data?.categories[index].name;
                            return MenuItem(
                              menuItem: categoryName ?? "",
                              color: Colors.black26,
                              icons: Icons.label,
                            );
                          },
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Description",
                      style: myTextTheme.bodyText1!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      data?.description ?? "",
                      textAlign: TextAlign.justify,
                      style: myTextTheme.bodyText2!
                          .copyWith(fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Menu",
                      style: myTextTheme.bodyText1!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Container(
                        height: 40,
                        child: ListView.builder(
                          itemCount: data?.menus?.foods.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var foodsName = data?.menus?.foods[index].name;
                            return MenuItem(
                              menuItem: foodsName ?? "",
                              color: Colors.red,
                              icons: Icons.food_bank_sharp,
                            );
                          },
                        )),
                    Container(
                        height: 40,
                        child: ListView.builder(
                          itemCount: data?.menus?.drinks.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var drinkName = data?.menus?.drinks[index].name;
                            return MenuItem(
                              menuItem: drinkName ?? "",
                              color: Colors.orange,
                              icons: Icons.local_drink,
                            );
                          },
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Reviews",
                      style: myTextTheme.bodyText1!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 200,
                        child: ListView.builder(
                          itemCount: data?.customerReviews.length,
                          itemBuilder: (context, index) {
                            var reviews = data?.customerReviews;
                            var itemReviews = data?.customerReviews[index];

                            if (reviews!.isEmpty) {
                              return Column(
                                children: [
                                  LottieBuilder.asset('assets/no_data.json'),
                                  Text("No Reviews")
                                ],
                              );
                            } else {
                              return Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${itemReviews?.name}",
                                            style: myTextTheme.bodyText1
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w800),
                                          ),
                                          Text(
                                            "${itemReviews?.date}",
                                            style: myTextTheme.overline,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "'' ${itemReviews?.review} ''",
                                        style: myTextTheme.caption?.copyWith(
                                            fontStyle: FontStyle.italic),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        )),
                    Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PostReviewScreen(
                                        model: data as Restaurant),
                                  ));
                            },
                            child: Text(
                              'Add Review',
                              style: myTextTheme.button
                                  ?.copyWith(color: Colors.white),
                            )))
                  ],
                ),
              ),
            );
          } else if (value.state == ResultState.NoData) {
            return Center(
              child: Column(
                children: [
                  Lottie.asset('assets/no_data.json', height: 200),
                  Text(
                    "aw...Not Found",
                    style: myTextTheme.headline6,
                  )
                ],
              ),
            );
          } else if (value.state == ResultState.Error) {
            return Center(
              child: Column(
                children: [
                  Lottie.asset('assets/error.json', height: 200),
                  Text(
                    "oops...something went wrong",
                    style: myTextTheme.headline6,
                  )
                ],
              ),
            );
          } else {
            return Center(child: Text(''));
          }
        },
      ),
    );
  }
}
