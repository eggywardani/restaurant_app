import 'package:flutter/material.dart';
import 'package:restaurant_app/api/api_services.dart';
import 'package:restaurant_app/data/state.dart';
import 'package:restaurant_app/model/restaurant_detail.dart';

class DetailProvider extends ChangeNotifier {
  final ApiServices apiServices;

  ResultState? _state;
  String _message = '';
  DetailRestaurantModel? _detailResult;

  ResultState? get state => _state;
  String get message => _message;
  DetailRestaurantModel? get detailResult => _detailResult;

  DetailProvider({
    required this.apiServices,
    String? id,
  }) {
    getDetailRestaurant(id ?? "");
  }

  void getDetailRestaurant(String id) {
    _state = ResultState.Loading;
    notifyListeners();

    Future<dynamic> result;
    result = _getDetailRestaurant(id);

    result.then((value) {
      _detailResult = value;
    });
  }

  void update(List<CustomerReviews> reviews) {
    _detailResult?.restaurant?.customerReviews = reviews;
  }

  Future<dynamic> _getDetailRestaurant(String id) async {
    print('Ini di detail restaurant ' + id);
    try {
      final detailResponses = await apiServices.fetchRestaurantDetail(id);
      _state = ResultState.Loading;
      if (detailResponses.message!.contains("not found")) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return detailResponses;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
