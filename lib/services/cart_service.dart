import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food/models/food_model.dart';

class CartService {
  FirebaseAuth auth = FirebaseAuth.instance;
  final fireStorage = FirebaseFirestore.instance;

  addFoodToCart(FoodModel foodCart) async {
    try {
      final ref = fireStorage
          .collection(
              'usercart-${auth.currentUser!.displayName}-${auth.currentUser!.uid}')
          .doc('${foodCart.id}');
      await ref.set(foodCart.toMap());
      debugPrint('food added to cart');
    } catch (e) {
      debugPrint('error add user to collection: $e');
    }
  }

  deleteFoodFromCart(FoodModel foodCart) async {
    try {
      final ref = fireStorage
          .collection(
              'usercart-${auth.currentUser!.displayName}-${auth.currentUser!.uid}')
          .doc('${foodCart.id}');
      await ref.delete();
      debugPrint('sucess on delete food');
    } catch (e) {
      debugPrint('error on delete food from cart: $e');
    }
  }

  getCartFoods() async {
    try {
      FoodModel food = FoodModel();
      List<FoodModel> foods = [];
      final ref = fireStorage.collection(
          'usercart-${auth.currentUser!.displayName}-${auth.currentUser!.uid}');
      await ref.get().then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          final foodResp = docSnapshot.data() as Map;
          food = FoodModel.fromJson(foodResp);
          foods.add(food);
        }
      });
      return foods;
    } catch (e) {
      debugPrint('error get user all infos: $e');
    }
  }

  buyCartProducts(List<FoodModel> cartProducts) {
    final ref = fireStorage.collection(
        'usercart-${auth.currentUser!.displayName}-${auth.currentUser!.uid}');
    for (int i = 0; i < cartProducts.length; i++) {
      ref.doc(cartProducts[i].id).delete();
    }
  }

  avaliation(FoodModel food) {
    try {
      final ref = fireStorage.collection('foods').doc(food.id);
      ref.update(food.toMap());
    } catch (e) {
      debugPrint('error on avaliate: $e');
    }
  }
}
