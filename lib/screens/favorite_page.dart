import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/state.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/themes/style.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          print(provider.state);
          if (provider.state == ResultState.NoData) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/no_data.json', height: 200),
                Text(
                  "No favorite restaurants",
                  style: myTextTheme.headline6,
                )
              ],
            ));
          } else {
            return ListView.builder(
              itemCount: provider.restaurants.length,
              itemBuilder: (context, index) {
                return RestaurantItem(restaurant: provider.restaurants[index]);
              },
            );
          }
        },
      ),
    );
  }
}
