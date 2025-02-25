import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier{

  // singin
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> singInWithEmailAndPassword(String email,String password) async {
    try{
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      },SetOptions(merge: true));
      return userCredential;
    } on FirebaseException catch(e){
      throw Exception(e.code);
    }
  }
  // signout
  Future<void> signOut() async{
  return await FirebaseAuth.instance.signOut();
  }
  // create new user
  Future<UserCredential> signUpWithEmailAndPassword(String email,String password) async {
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });
      return userCredential;
    } on FirebaseException catch (e){
      throw Exception(e.code);
    }

  }
}