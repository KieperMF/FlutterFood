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
  List<FoodModel> meals = [];
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
      num avaliation = allFoods[i].avaliationsPoints! / allFoods[i].avaliationNumber!;
      allFoods[i].avaliation = double.parse(avaliation.toStringAsFixed(1));
      if (allFoods[i].category == 'Hamburger') {
        hamburger.add(allFoods[i]);
      }
      if (allFoods[i].category == 'Drink') {
        drinks.add(allFoods[i]);
      }
      if (allFoods[i].category == 'Meal') {
        meals.add(allFoods[i]);
      }
    }
  }

  getBestRated() {
    for (int i = 0; allFoods.length > i; i++) {
      if (allFoods[i].category == 'Hamburger' ||
          allFoods[i].category == 'Meal') {
        if (allFoods[i].avaliationNumber != null) {
          num avaliation = allFoods[i].avaliationsPoints! / allFoods[i].avaliationNumber!;
          if (avaliation >= 4.0) {
            bestRated.add(allFoods[i]);
          }
        }
      }
    }
    for(int i = 0; bestRated.length > i; i++){
      num avaliation = bestRated[i].avaliationsPoints! / bestRated[i].avaliationNumber!;
      bestRated[i].avaliation = double.parse(avaliation.toStringAsFixed(1));
    }
  }

  refreshMethod() async {
    hamburger.clear();
    drinks.clear();
    meals.clear();
    allFoods.clear();
    allFoods = await service.getFoods();
    foodsByCategory();
    getBestRated();
    notifyListeners();
  }
}
