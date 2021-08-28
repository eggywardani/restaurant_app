import 'package:flutter/material.dart';
import 'package:restaurant_app/api/api_services.dart';
import 'package:restaurant_app/data/state.dart';
import 'package:restaurant_app/model/review_model.dart';

class PostReviewProvider extends ChangeNotifier {
  final ApiServices apiServices;
  ResultState? _state;
  String _message = '';
  ReviewModel? _result;

  ResultState? get state => _state;
  String get message => _message;
  ReviewModel? get result => _result;

  PostReviewProvider(
      {required this.apiServices, String? id, String? name, String? review}) {
    postReviewRestaurant("$id", "$name", "$review");
  }

  Future<dynamic> postReviewRestaurant(
      String id, String name, String review) async {
    try {
      final response = await apiServices.postReview(id, name, review);
      _state = ResultState.Loading;
      if (response.message!.contains('success')) {
        _state = ResultState.HasData;
        notifyListeners();
        return response;
      } else {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
