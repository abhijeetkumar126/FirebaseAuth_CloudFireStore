import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseseries/email_auth/login.dart';
import 'package:firebaseseries/phone_auth/sign_in_with_phone.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emaiController = TextEditingController();

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SignInPhone(),
      ),
    );
  }

  void saveUser() {
    String name = nameController.text.trim();
    String email = emaiController.text.trim();

    nameController.clear();
    emaiController.clear();

    if (name != "" && email != "") {
      Map<String, dynamic> userData = {"name": name, "email": email};
      FirebaseFirestore.instance.collection("users").add(userData);
      log("user created!");
    } else {
      log("Please fill all the filds!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () {
              logout();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(hintText: "Name"),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emaiController,
                decoration: InputDecoration(hintText: "Email Address"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  saveUser();
                },
                child: Text("Save"),
              ),
              SizedBox(height: 20),
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("users").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> userMap =
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;
                            final id = snapshot.data!.docs[index].id;
                            return ListTile(
                              title: Text(userMap["name"]),
                              subtitle: Text(userMap["email"]),
                              trailing: IconButton(
                                onPressed: () {
                                  setState(() {
                                    deletById(id);
                                  });
                                },
                                icon: Icon(Icons.delete),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Text("No Data!");
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deletById(String id) async {
    await FirebaseFirestore.instance.collection("users").doc(id).delete();
    log(id);

    log("user id is deleted");
  }
}
