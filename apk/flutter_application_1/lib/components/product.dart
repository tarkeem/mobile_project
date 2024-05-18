// To parse this JSON data, do
//
//     final Product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
    String id;
    String name;
    int price;
    String restaurant;
    int v;

    Product({
        required this.id,
        required this.name,
        required this.price,
        required this.restaurant,
        required this.v,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        restaurant: json["restaurant"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "price": price,
        "restaurant": restaurant,
        "__v": v,
    };
}
