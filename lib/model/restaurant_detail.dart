import 'package:restaurant_app/api/api_services.dart';

class DetailRestaurantModel {
  bool? error;
  String? message;
  Restaurant? restaurant;

  DetailRestaurantModel(
      {required this.error, required this.message, required this.restaurant});

  DetailRestaurantModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    restaurant = new Restaurant.fromJson(json['restaurant']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;

    data['restaurant'] = this.restaurant!.toJson();

    return data;
  }
}

class Restaurant {
  String? id;
  String? name;
  String? description;
  String? city;
  String? address;
  String? pictureId;
  late List<Categories> categories;
  Menus? menus;
  double? rating;
  late List<CustomerReviews> customerReviews;

  Restaurant(
      {required this.id,
      required this.name,
      required this.description,
      required this.city,
      required this.address,
      required this.pictureId,
      required this.categories,
      required this.menus,
      required this.rating,
      required this.customerReviews});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    city = json['city'];
    address = json['address'];
    pictureId = ApiServices.baseImage + json['pictureId'];
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    menus = new Menus.fromJson(json['menus']);
    rating = json['rating'].toDouble();
    if (json['customerReviews'] != null) {
      customerReviews = [];
      json['customerReviews'].forEach((v) {
        customerReviews.add(new CustomerReviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['city'] = this.city;
    data['address'] = this.address;
    data['pictureId'] = this.pictureId;

    data['categories'] = this.categories.map((v) => v.toJson()).toList();

    data['menus'] = this.menus!.toJson();

    data['rating'] = this.rating;

    data['customerReviews'] =
        this.customerReviews.map((v) => v.toJson()).toList();

    return data;
  }
}

class Categories {
  String? name;

  Categories({this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class Menus {
  late List<Food> foods;
  late List<Drink> drinks;

  Menus({required this.foods, required this.drinks});

  Menus.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      foods = [];
      json['foods'].forEach((v) {
        foods.add(new Food.fromJson(v));
      });
    }
    if (json['drinks'] != null) {
      drinks = [];
      json['drinks'].forEach((v) {
        drinks.add(new Drink.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['foods'] = this.foods.map((v) => v.toJson()).toList();

    data['drinks'] = this.drinks.map((v) => v.toJson()).toList();

    return data;
  }
}

class CustomerReviews {
  String? name;
  String? review;
  String? date;

  CustomerReviews({this.name, this.review, this.date});

  CustomerReviews.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    review = json['review'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['review'] = this.review;
    data['date'] = this.date;
    return data;
  }
}

class Drink {
  Drink({
    required this.name,
  });

  String? name;

  factory Drink.fromJson(Map<String, dynamic> json) => Drink(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Food {
  Food({
    required this.name,
  });

  String? name;

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
