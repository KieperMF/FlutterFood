import 'package:flutter/material.dart';
import 'package:flutter_food/models/food_model.dart';
import 'package:flutter_food/services/cart_service.dart';

class FoodPageStore with ChangeNotifier {
  FoodPageStore({required this.service});

  CartService service;

  postFoodCart(FoodModel food) async {
    try {
      await service.addFoodToCart(food);
    } catch (e) {
      debugPrint('erro post on cart: $e');
    }
  }

  evaluateProduct(num avaliation, FoodModel food) {
    food.avaliationNumber = food.avaliationNumber! + 1;
    food.avaliationsPoints = food.avaliationsPoints! + avaliation;
    service.avaliation(food);
  }
}
