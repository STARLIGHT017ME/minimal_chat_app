import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //get current user
  User? getcurrentuser() {
    return auth.currentUser;
  }

  //sign in with email and password

  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    try {
      //user sign in
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      //save user info if doesn't already exist
      firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // signout or logout
  Future<void> signout() async {
    return await auth.signOut();
  }

  // sign up with email and password
  Future<UserCredential?> signUpWithEmailPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //save user info in a seperate document

      firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });
      return userCredential;
    } on FirebaseAuth catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog.adaptive(
          title: Text(e.toString()),
        ),
      );
      return null;
    }
  }
}
