import 'package:flutter/material.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/state.dart';
import 'package:restaurant_app/model/list_restaurant.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;
  DatabaseProvider({required this.databaseHelper}) {
    _getRestaurants();
  }

  late ResultState _state;
  ResultState get state => _state;
  String _message = '';
  String get message => _message;

  List<Restaurants> _restaurants = [];
  List<Restaurants> get restaurants => _restaurants;

  void _getRestaurants() async {
    _state = ResultState.NoData;
    _restaurants = await databaseHelper.getRestaurants();

    if (_restaurants.length > 0) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = "No Data";
    }
    print(_state);
    notifyListeners();
  }

  void addRestaurant(Restaurants restaurants) async {
    try {
      await databaseHelper.insertRestaurant(restaurants);
      _getRestaurants();
      print("Berhasil");
    } catch (e) {
      _state = ResultState.Error;
      _message = "Error : $e";
      notifyListeners();
      print("Gagal");
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoritedRestaurant = await databaseHelper.getRestaurantById(id);
    return favoritedRestaurant.isNotEmpty;
  }

  void removeRestaurant(String id) async {
    try {
      await databaseHelper.removeRestaurant(id);
      _getRestaurants();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
