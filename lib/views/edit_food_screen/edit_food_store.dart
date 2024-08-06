import 'package:flutter/material.dart';
import 'package:flutter_food/models/food_model.dart';
import 'package:flutter_food/services/food_service.dart';

class EditFoodStore with ChangeNotifier{
  FoodService service;
  List<FoodModel> foods = [];
  List<bool> visibility = [];
  List<String> categories = ['Hamburger', 'Meal', 'Drink'];

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

  updateFood(String name, String desc, String categ, double price, int index)async{
    foods[index].name = name != '' ? name :  foods[index].name;
    foods[index].description = desc != '' ? desc : foods[index].description;
    foods[index].category = categ != '' ? categ : foods[index].category;
    foods[index].price = price > 0.0 ? price : foods[index].price;
    service.updateFood(foods[index]);
    notifyListeners();
  }

  deleteFood(FoodModel food)async{
    try{
      service.deleteFood(food);
      await getFoods();
      debugPrint('deleted food store');
      notifyListeners();
    }catch(e){
      debugPrint('error delete food store: $e');
    }
  }
}