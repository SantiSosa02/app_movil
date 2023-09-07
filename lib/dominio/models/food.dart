import 'package:flutter/material.dart';

class Food {
  int id=UniqueKey().hashCode;
  String name;
  String description;
  int quantity;
  DateTime expDate;
  bool state = true;
  String image;

  Food(
      {required this.name,
      required this.description,
      required this.quantity,
      required this.expDate,
      required this.image});
}
