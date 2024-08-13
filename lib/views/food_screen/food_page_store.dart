import 'package:flutter/material.dart';
import 'package:flutter_food/models/food_model.dart';
import 'package:flutter_food/services/user_service.dart';

class FoodPageStore with ChangeNotifier{
  FoodPageStore({required this.service});

  UserService service;

  postFoodCart(FoodModel food)async{
    try{
      await service.addFoodToCart(food);
    }catch(e){
      debugPrint('erro post on cart: $e');
    }
  }
}