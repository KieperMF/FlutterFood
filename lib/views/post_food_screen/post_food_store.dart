import 'package:flutter/material.dart';
import 'package:flutter_food/models/food_model.dart';
import 'package:flutter_food/services/food_service.dart';

class PostFoodStore with ChangeNotifier{
  FoodService service;
  FoodModel food = FoodModel();
  List<double> avaliations = [0, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5];
  List<String> categories = ['Fast Food', 'Snack', 'Drink'];

  PostFoodStore({
    required this.service
  });

  postFood(FoodModel foodSelec)async{
    await getLength();
    service.postFood(foodSelec);
  }

  getLength()async{
    List<FoodModel> list = await service.getFoods();
    debugPrint('${list.length + 1}');
    food.id = list.length + 1;
  }

  getFoodImage(String path){
    food.foodImage = path;
    notifyListeners();
  }
}