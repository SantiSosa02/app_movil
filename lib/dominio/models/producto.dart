import 'package:flutter/material.dart';

class Product {
  String name;
  String description;
  double quiantity;
  bool state = true;
  String image;
  DateTime expirationDate;

  Product({
    required this.name,
    required this.description,
    required this.quiantity,
    required this.image,
    DateTime? expirationDate,
  }) : expirationDate =
            expirationDate ?? DateTime.now().add(Duration(days: 30));
}
