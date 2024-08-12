import 'package:flutter/material.dart';
import 'package:flutter_food/models/food_model.dart';
import 'package:flutter_food/services/food_service.dart';

FoodModel? selectedFood;

class HomeStore with ChangeNotifier {
  HomeStore({required this.service});
  FoodService service;
  List<FoodModel> allFoods = [];
  List<FoodModel> hamburger = [];
  List<FoodModel> drinks = [];
  List<FoodModel> bestRated = [];

  getFoods() async {
    List<FoodModel> news = await service.getFoods();
    allFoods.addAll(news);
    foodsByCategory();
    getBestRated();
    notifyListeners();
  }

  void foodsByCategory() {
    for (int i = 0; allFoods.length > i; i++) {
      if (allFoods[i].category == 'Hamburger') {
        hamburger.add(allFoods[i]);
      }
      if (allFoods[i].category == 'Drink') {
        drinks.add(allFoods[i]);
      }
    }
  }

  getBestRated() {
    for (int i = 0; allFoods.length > i; i++) {
      if (allFoods[i].category == 'Hamburger') {
        if(allFoods[i].avaliation != null){
          if (allFoods[i].avaliation! >= 4.0) {
          bestRated.add(allFoods[i]);
        }
        }
        
      }
    }
  }

  refreshMethod() async {
    List<FoodModel> food = await service.getFoods();
    for (int i = 0; food.length > i; i++) {
      if (food[i].category == 'Hamburger') {
        if (food[i].id != hamburger[i].id) {
          hamburger.add(allFoods[i]);
        }
      }
      if (food[i].category == 'Drink') {
        if (food[i].id != drinks[i].id) {
          drinks.add(allFoods[i]);
        }
      }
    }
    notifyListeners();
  }
}
