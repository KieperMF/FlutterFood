import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UserService{
  FirebaseAuth auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  User? user;

  loginUser(String email, String password)async{
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    }catch(e){
      debugPrint('Erro login service: $e');
      return false;
    }
  }

  createUser(String email, String password, String name)async{ 
    try{
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      userCredential.user!.updateDisplayName(name);
      debugPrint('sucess create user service');
    }catch(e){
      debugPrint('Erro create user service: $e');
    }
  }

  uploadUserPhoto(String id, String imagePath)async{
    try{
      Reference ref = storage.ref().child('User_pic').child(id);
      await ref.putFile(File(imagePath));
      ref.getDownloadURL();
    }catch(e){
      debugPrint('error upload user photo: $e');
    }
  }

  getUSerPhoto(){
    storage.ref().getDownloadURL();
  }

  logout(){
    auth.signOut();
  }

  getUser(){
    return auth.currentUser;
  }
}