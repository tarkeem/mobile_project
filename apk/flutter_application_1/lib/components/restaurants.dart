// To parse this JSON data, do
//
//     final Restaurant = restaurantFromJson(jsonString);

import 'dart:convert';

Restaurant restaurantFromJson(String str) {
  var res = Restaurant.fromJson(json.decode(str));
  return res;
}

String restaurantToJson(Restaurant data) => json.encode(data.toJson());

class Coordinates {
  final double latitude;
  final double longitude;

  Coordinates(this.latitude, this.longitude);

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('coordinates')) {
      if (json['coordinates'] is List<dynamic> &&
          json['coordinates'].length == 2 &&
          json['coordinates'][0] is double &&
          json['coordinates'][1] is double) {
        List<dynamic> coordinates = json['coordinates'];
        return Coordinates(coordinates[0], coordinates[1]);
      } else if (json['coordinates'] is Map<String, dynamic> &&
          json['coordinates'].containsKey('coordinates') &&
          json['coordinates']['coordinates'] is List<dynamic> &&
          json['coordinates']['coordinates'].length == 2 &&
          json['coordinates']['coordinates'][0] is double &&
          json['coordinates']['coordinates'][1] is double) {
        List<dynamic> coordinates = json['coordinates']['coordinates'];
        return Coordinates(coordinates[0], coordinates[1]);
      } else {
        // Handle empty coordinates case here
        return Coordinates(-1000000,
            -1000000); // Or create a default Coordinates object with null values
      }
    } else {
      throw Exception('Missing coordinates field in JSON');
    }
  }
}

class Restaurant {
  Coordinates coordinates;
  String id;
  String name;
  String address;
  List<String> products;
  int v;

  Restaurant({
    required this.coordinates,
    required this.id,
    required this.name,
    required this.address,
    required this.products,
    required this.v,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        coordinates: Coordinates.fromJson(json["coordinates"]),
        id: json["_id"],
        name: json["name"],
        address: json["address"],
        products: List<String>.from(json["products"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": coordinates,
        "_id": id,
        "name": name,
        "address": address,
        "products": products,
        "__v": v,
      };
}
