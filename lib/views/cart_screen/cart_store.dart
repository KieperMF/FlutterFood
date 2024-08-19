import 'package:flutter/material.dart';
import 'package:flutter_food/models/food_model.dart';
import 'package:flutter_food/services/cart_service.dart';

class CartStore with ChangeNotifier {
  CartStore({required this.service});

  CartService service;
  List<FoodModel> cartProducts = [];
  num? totalprice = 0;

  getCartProducts() async{
    cartProducts = await service.getCartFoods();
    getTotalPrice();
    notifyListeners();
  }

  getTotalPrice(){
    totalprice = 0;
    if(cartProducts.isNotEmpty){
      for(int i =0; cartProducts.length > i; i++){
      totalprice = totalprice! + cartProducts[i].price!;
    }
    }
    notifyListeners();
  }

  deleteFoodFromCart(FoodModel food, int index) {
    service.deleteFoodFromCart(food);
    refresh();
    debugPrint('${cartProducts.length}');
    getTotalPrice();
    notifyListeners();
  }

  refresh() async{
    cartProducts = await service.getCartFoods();
    getTotalPrice();
    notifyListeners();
  }
}
