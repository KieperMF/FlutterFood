import 'package:flutter/material.dart';
import 'package:flutter_food/models/food_model.dart';
import 'package:flutter_food/services/food_service.dart';

class HomeStore with ChangeNotifier {
  HomeStore({required this.service});
  FoodService service;
  List<FoodModel> foods = [];
  List<FoodModel> hamburger = [];
  List<FoodModel> drinks = [];

  getFoods() async {
    List<FoodModel> news = await service.getFoods();
    foods.addAll(news);
    foodsByCategory();
    notifyListeners();
  }

  void foodsByCategory(){
    for (int i = 0; foods.length > i; i++) {
      if (foods[i].category == 'Hamburger') {
          hamburger.add(foods[i]);
      }
      if (foods[i].category == 'Drink') {
          drinks.add(foods[i]);
      }
    }
  }

  refreshMethod(){
    getFoods();
    for (int i = 0; foods.length > i; i++) {
      if (foods[i].category == 'Hamburger') {
        if (foods[i].id != hamburger[i].id) {
          hamburger.add(foods[i]);
        }
      }
      if (foods[i].category == 'Drink') {
        if (foods[i].id != drinks[i].id) {
          drinks.add(foods[i]);
        }
      }
    }
    notifyListeners();
  }
}
