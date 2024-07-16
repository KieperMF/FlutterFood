import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food/models/user_model.dart';

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
      await getUser();
      addUserToCollection();
      debugPrint('sucess create user service');
    } catch (e) {
      debugPrint('Erro create user service: $e');
    }
  }

  addUserToCollection() async {
    try {
      userModel.name = user!.displayName;
      userModel.email = user!.email;
      debugPrint(userModel.name);
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

  getUSerPhoto() async {
    userModel.userPic = await storage.ref().getDownloadURL();
  }

  logout() {
    auth.signOut();
  }

  getUser() {
   user = auth.currentUser;
   getUserAllInfos();
    return user;
  }

  getUserAllInfos(){
    final response = fireStorage.collection('users').doc(user!.uid);
    response.get().then((DocumentSnapshot doc) {
      userModel = UserModel.fromJson(doc.data() as Map<String, dynamic>);
    });
  }
}
