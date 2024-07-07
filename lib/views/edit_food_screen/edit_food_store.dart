import 'package:flutter/material.dart';
import 'package:flutter_food/models/food_model.dart';
import 'package:flutter_food/services/food_service.dart';

class EditFoodStore with ChangeNotifier{
  FoodService service;
  List<FoodModel> foods = [];

  EditFoodStore({
    required this.service
  });
}