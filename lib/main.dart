import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseseries/phone_auth/home.dart';
import 'package:firebaseseries/phone_auth/sign_in_with_phone.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // This code show the users data which is save in firebase.

  // QuerySnapshot snapshot =
  //     await FirebaseFirestore.instance.collection("users").get();

  // for (var doc in snapshot.docs) {
  //   log(doc.data().toString());
  // }

  // This code add the data into firebase

  // Map<String, dynamic> newUserData = {
  //   "name": "Rohit",
  //   "email": "rohit12@gmail.com"
  // };
  // await _firestore.collection("users").add(newUserData);
  // log("new User Saved");

  // This code set the data as you want to name the document

  // Map<String, dynamic> newUserData = {
  //   "name": "Ram",
  //   "email": "ramu12@gmail.com"
  // };
  // await _firestore.collection("users").doc("ram_id").set(newUserData);
  // log("document name changed");

  // This code update the user name and email

  // Map<String, dynamic> newUserData = {
  //   "name": "Ram",
  //   "email": "ramu12@gmail.com"
  // };
  // await _firestore
  //     .collection("users")
  //     .doc("ram_id")
  //     .update({"email": "ram12@gmail.com"});
  // log("email will updated");

  //This code delet the user document

  // await _firestore.collection("users").doc("ram_id").delete();
  // log("user deleted");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: (FirebaseAuth.instance.currentUser != null)
          ? HomePage()
          : SignInPhone(),
    );
  }
}
