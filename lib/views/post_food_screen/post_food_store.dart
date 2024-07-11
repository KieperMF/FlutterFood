import 'package:flutter/material.dart';
import 'package:flutter_food/models/food_model.dart';
import 'package:flutter_food/services/food_service.dart';

class PostFoodStore with ChangeNotifier{
  FoodService service;
  FoodModel food = FoodModel();
  List<double> avaliations = [0, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5];
  List<String> categories = ['Fast Food', 'Snack', 'Drink'];
  bool postVerif = false;

  PostFoodStore({
    required this.service
  });

  void postFood()async{
    try{
      await getLength();
      service.postFood(food);
      postVerif =  true;
      notifyListeners();
    }catch(e){
      debugPrint('error post food: $e');
      postVerif = false;
    }
  }

  Future<void> getLength()async{
    List<FoodModel> list = await service.getFoods();
    food.id = list.length + 1;
  }

  void getFoodImage(String path){
    food.foodImage = path;
    notifyListeners();
  }
}