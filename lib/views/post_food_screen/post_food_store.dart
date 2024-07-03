import 'package:flutter/material.dart';
import 'package:flutter_food/models/food_model.dart';
import 'package:flutter_food/services/food_service.dart';

class PostFoodStore with ChangeNotifier{
  FoodService service;
  FoodModel food = FoodModel();

  PostFoodStore({
    required this.service
  });

  postFood(FoodModel foodSelec){
    foodSelec.id = getLength();
    service.postFood(foodSelec);
  }

  getLength()async{
    List<FoodModel> list = await service.getFoods();
    debugPrint('${list.length + 1}');
    food.id = list.length + 1;
    return food.id;
  }

  getFoodImage(String path){
    food.foodImage = path;
    notifyListeners();
  }
}