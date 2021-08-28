import 'package:flutter/material.dart';
import 'package:restaurant_app/api/api_services.dart';
import 'package:restaurant_app/data/state.dart';
import 'package:restaurant_app/model/list_restaurant.dart';
import 'package:restaurant_app/model/search_model.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiServices apiServices;

  RestaurantProvider({required this.apiServices}) {
    _callRestaurant();
  }

  late ListRestaurantModel _listRestaurant;
  String _message = '';
  late ResultState _state;

  String get message => _message;
  ListRestaurantModel get result => _listRestaurant;
  ResultState get state => _state;

  SearchModel? _searchResult;
  SearchModel? get searchResult => _searchResult;

  void getRestaurants() {
    _callRestaurant();
  }

  void getRestaurantsSearch(String query) {
    _callRestaurant(query: query);
  }

  void _callRestaurant({String query = ""}) {
    _state = ResultState.Loading;
    notifyListeners();
    Future<dynamic> result;

    if (query.isEmpty) {
      result = _fetchRestaurantList();
    } else {
      result = _searchRestaurant(query);
    }

    result.then((value) {
      if (query.isEmpty) {
        _listRestaurant = value;
      } else {
        _searchResult = value;
      }
    });
  }

  Future<dynamic> _searchRestaurant(String query) async {
    try {
      final response = await apiServices.searchRestaurant(query);
      _state = ResultState.Loading;
      print(response.founded);
      if ((response.founded == 0) | (response.restaurants!.isEmpty)) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return response;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> _fetchRestaurantList() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();

      final restaurants = await apiServices.fetchMovieList();
      if (restaurants.restaurants!.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = "No Data";
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _listRestaurant = restaurants;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = "Error Occured: $e";
    }
  }
}
