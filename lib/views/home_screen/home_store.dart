import 'package:flutter/material.dart';
import 'package:flutter_food/models/food_model.dart';
import 'package:flutter_food/services/food_service.dart';

class HomeStore with ChangeNotifier{
  HomeStore({required this.service});
  FoodService service;
  List<FoodModel> foods = [];

  getFoods()async{
    foods = await service.getFoods();
    notifyListeners();
  }
}