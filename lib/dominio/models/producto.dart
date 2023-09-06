import 'package:flutter/material.dart';

class Product {
  String name;
  String description;
  double quiantity = 0;
  bool state = true;
  String image;

  Product ({
      required this.name,
      required this.description,
      required this.image
      });
}