import 'package:flutter/material.dart';
import 'package:flutter_food/models/food_model.dart';
import 'package:flutter_food/services/food_service.dart';

class HomeStore with ChangeNotifier{
  HomeStore({required this.service});
  FoodService service;
  List<FoodModel> foods = [];
  List<FoodModel> hamburger = [];
  List<FoodModel> drinks = [];
  //List<FoodModel> foods = [];

  getFoods()async{
    foods = await service.getFoods();
    foodsByCategory();
    notifyListeners();
  }

  foodsByCategory(){
    for(int i = 0; foods.length > i; i++){
    if(foods[i].category == 'Hamburger'){
      hamburger.add(foods[i]);
    }
    if(foods[i].category == 'Drink'){
      drinks.add(foods[i]);
    }
    }
  }
}