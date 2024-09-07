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

  updateFood(String name, String desc, String categ, String price, int index)async{
    num priceParsed = price.isNotEmpty ? num.parse(price) : 0;
    foods[index].name = name != '' ? name :  foods[index].name;
    foods[index].description = desc != '' ? desc : foods[index].description;
    foods[index].category = categ != '' ? categ : foods[index].category;
    foods[index].price = priceParsed > 0.0 ? priceParsed : foods[index].price;
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