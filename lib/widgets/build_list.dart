import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/state.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/themes/style.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';

class BuildList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, value, child) {
        if (value.state == ResultState.Loading) {
          return Center(
            child: Center(
              child: Lottie.asset('assets/loading.json', height: 200),
            ),
          );
        } else if (value.state == ResultState.HasData) {
          return ListView.builder(
            itemCount: value.result.restaurants!.length,
            itemBuilder: (context, index) {
              var items = value.result.restaurants![index];
              return RestaurantItem(restaurant: items);
            },
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
    );
  }
}
