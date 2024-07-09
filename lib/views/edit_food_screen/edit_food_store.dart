import 'package:flutter/material.dart';
import 'package:flutter_food/models/food_model.dart';
import 'package:flutter_food/services/food_service.dart';

class EditFoodStore with ChangeNotifier{
  FoodService service;
  List<FoodModel> foods = [];
  List<bool> visibility = [];
  List<String> categories = ['Fast Food', 'Snack', 'Drink'];

  EditFoodStore({
    required this.service
  });

  getFoods()async{
    foods = await service.getFoods();
    notifyListeners();
  }

  toggleVisibility(int index){
    visibility[index] = !visibility[index];
    notifyListeners();
  }
}