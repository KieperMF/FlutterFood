import 'package:flutter/material.dart';
import 'package:flutter_food/models/food_model.dart';
import 'package:flutter_food/services/cart_service.dart';

class CartStore with ChangeNotifier {
  CartStore({required this.service});

  CartService service;
  List<FoodModel> cartProducts = [];

  getCartProducts() async{
    cartProducts = await service.getCartFoods();
    notifyListeners();
  }

  deleteFoodFromCart(FoodModel food, int index) {
    service.deleteFoodFromCart(food);
    cartProducts.remove(cartProducts[index]);
    notifyListeners();
  }

  refresh() async{
    cartProducts = await service.getCartFoods();
    notifyListeners();
  }
}
