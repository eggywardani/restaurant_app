import 'dart:convert';

import 'package:restaurant_app/model/list_restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/model/restaurant_detail.dart';
import 'package:restaurant_app/model/review_model.dart';
import 'package:restaurant_app/model/search_model.dart';

class ApiServices {
  static final String baseUrl = "https://restaurant-api.dicoding.dev/";
  static final String baseImage =
      "https://restaurant-api.dicoding.dev/images/medium/";
  static final String apiKey = "12345";

  Future<ListRestaurantModel> fetchMovieList() async {
    var url = Uri.parse("$baseUrl/list");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return ListRestaurantModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to Load Data");
    }
  }

  Future<DetailRestaurantModel> fetchRestaurantDetail(String id) async {
    var url = Uri.parse(baseUrl + "detail/$id");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return DetailRestaurantModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to Load Data");
    }
  }

  Future<SearchModel> searchRestaurant(String query) async {
    var url = Uri.parse(baseUrl + "search?q=$query");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return SearchModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to Load Data");
    }
  }

  Future<ReviewModel> postReview(String id, String name, String review) async {
    var url = Uri.parse(baseUrl + "review");
    final response = await http.post(url, headers: <String, String>{
      "Content-Type": "application/x-www-form-urlencoded",
      "X-Auth-Token": apiKey
    }, body: {
      'id': id,
      'name': name,
      'review': review
    });

    if (response.statusCode == 200) {
      return ReviewModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed to post review');
    }
  }
}
