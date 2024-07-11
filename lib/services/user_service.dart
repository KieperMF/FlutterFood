import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserService{
  FirebaseAuth auth = FirebaseAuth.instance;
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
      debugPrint('$email');
      debugPrint('$password');
      debugPrint('$name');
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      userCredential.user!.updateDisplayName(name);
      debugPrint('sucess create user service');
      
    }catch(e){
      debugPrint('Erro create user service: $e');
    }
  }

  logout(){
    auth.signOut();
  }

  getUser(){
    return auth.currentUser;
  }
}