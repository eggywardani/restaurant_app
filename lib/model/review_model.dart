import 'package:restaurant_app/model/restaurant_detail.dart';

class ReviewModel {
  bool? error;
  String? message;
  late List<CustomerReviews> customerReviews;

  ReviewModel({this.error, this.message, required this.customerReviews});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['customerReviews'] != null) {
      customerReviews = [];
      json['customerReviews'].forEach((v) {
        customerReviews.add(new CustomerReviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    data['customerReviews'] =
        this.customerReviews.map((v) => v.toJson()).toList();

    return data;
  }
}
