import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_food/models/food_model.dart';

class FoodService {
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firesStore = FirebaseFirestore.instance;

  postFood(FoodModel foodModel) async {
    String id = foodModel.id.toString();
    try {
      foodModel.foodImage =
          await _uploadFoodPic(File('${foodModel.foodImage}'), foodModel);
      final ref = firesStore.collection('foods').doc(id);
      await ref.set(foodModel.toMap());
    } catch (e) {
      debugPrint('erro posr food: $e');
    }
  }

  _uploadFoodPic(File foodImage, FoodModel food) async {
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('food_pic').child('${food.id}');
      UploadTask uploadTask = storageReference.putFile(foodImage);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint('erro upload Image: $e');
    }
  }

  getFoods() async {
    List<FoodModel> foods = [];
    FoodModel? food;
    final CollectionReference ref = firesStore.collection('foods');
    try {
      await ref.get().then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          final foodResp = docSnapshot.data() as Map;
          food = FoodModel.fromJson(foodResp);
          foods.add(food!);
        }
      });
      return foods;
    } catch (e) {
      debugPrint('erro get food $e');
    }
  }
}
