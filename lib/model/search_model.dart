import 'package:restaurant_app/model/list_restaurant.dart';

class SearchModel {
  bool? error;
  int? founded;
  List<Restaurants>? restaurants;

  SearchModel(
      {required this.error, required this.founded, required this.restaurants});

  SearchModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    founded = json['founded'];
    if (json['restaurants'] != null) {
      restaurants = [];
      json['restaurants'].forEach((v) {
        restaurants?.add(new Restaurants.fromJsonList(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['founded'] = this.founded;

    data['restaurants'] = this.restaurants?.map((v) => v.toJson()).toList();

    return data;
  }
}
