import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food/models/food_model.dart';
import 'package:flutter_food/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  FirebaseAuth auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  final fireStorage = FirebaseFirestore.instance;
  User? user;
  UserModel userModel = UserModel();

  loginUser(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      debugPrint('Erro login service: $e');
      return false;
    }
  }

  createUser(String email, String password, String name) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await userCredential.user!.updateDisplayName(name);
      await getUserUid();
      userModel.name = user!.displayName;
      userModel.email = user!.email;
      addUserToCollection();
      debugPrint('sucess create user service');
    } catch (e) {
      debugPrint('Erro create user service: $e');
    }
  }

  addFoodToCart(FoodModel foodCart) async {
    try {
      final ref =  fireStorage.collection('usercart-${auth.currentUser!.uid}').doc('${foodCart.id}');
      await ref.set(foodCart.toMap());
      debugPrint('food added to cart');
    } catch (e) {
      debugPrint('error add user to collection: $e');
    }
  }

  getCartFoods()async{
    try{
      FoodModel food = FoodModel();
      List<FoodModel> foods = [];
      final ref =  fireStorage.collection('usercart-${auth.currentUser!.uid}');
      await ref.get().then((querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          final foodResp = docSnapshot.data() as Map;
          food = FoodModel.fromJson(foodResp);
          foods.add(food);
        }
      });
    return foods;
    }catch(e){
      debugPrint('error get user all infos: $e');
    }
  }

  addUserToCollection() async {
    try {
      final ref =  fireStorage.collection('users').doc(user!.uid);
      await ref.set(userModel.toMap());
    } catch (e) {
      debugPrint('error add user to collection: $e');
    }
  }

  uploadUserPhoto(String id, String imagePath) async {
    try {
      Reference ref = storage.ref().child('User_pic').child(id);
      await ref.putFile(File(imagePath));
      userModel.userPic = await ref.getDownloadURL();
      addUserToCollection();
    } catch (e) {
      debugPrint('error upload user photo: $e');
    }
  }

  logout() {
    auth.signOut();
  }

  getUserUid() {
    user = auth.currentUser;
    return user;
  }

  getUserAllInfos()async{
    try{
      final response =  fireStorage.collection('users').doc(user!.uid);
      await response.get().then((DocumentSnapshot doc) {
      userModel = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    });
    return userModel;
    }catch(e){
      debugPrint('error get user all infos: $e');
    }
  }

  updateUserInfos(UserModel userUpdate)async{
    final ref = fireStorage.collection('users').doc(user!.uid);
    ref.update(userUpdate.toMap());
  }

  getLoactionInfosCep(String cep)async{
    try{
      final response = await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));
    final decode = jsonDecode(response.body) as Map;
    UserModel userModelCep = UserModel.fromJsonApiCep(decode);
    return userModelCep;
    }catch(e){
      debugPrint('error get cep: $e');
    }
  }
}
