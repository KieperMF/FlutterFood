import 'package:flutter/material.dart';
import 'package:flutter_food/models/food_model.dart';
import 'package:flutter_food/services/user_service.dart';

class CartStore with ChangeNotifier{
  CartStore({required this.service});

  UserService service;
  List<FoodModel> cartProducts = [];

  getCartProducts()async{
      cartProducts = await service.getCartFoods();
      notifyListeners();
  }
}