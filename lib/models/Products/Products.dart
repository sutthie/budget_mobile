import 'package:flutter/material.dart';

class Products {
  final int pid;
  final String productname, description;
  final double rating, price;
  final List<String> images;
  final List<Color> colors;
  final bool discount, isActive;
  final String discountStr;

  Products({
    required this.pid,
    required this.productname,
    required this.description,
    required this.price,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    this.discount = false,
    this.isActive = true,
    this.discountStr = "",
  });

  // factory Products.fromJson(Map<String, dynamic> json) {
  //   return new Products(
  //     json["pid"],
  //     json["productname"],
  //     json["description"],
  //     json["price"],
  //     json["images"],
  //     json["colors"],
  //     json["rating"],
  //     json["discount"],
  //     json["isActive"],
  //     json["discountStr"],
  //   );
  // }
}
