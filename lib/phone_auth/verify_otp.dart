import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseseries/phone_auth/home.dart';
import 'package:flutter/material.dart';

class VerifyOtp extends StatefulWidget {
  final String verificationId;
  const VerifyOtp({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  TextEditingController otpController = TextEditingController();

  void verifyOtp() async {
    String otp = otpController.text.trim();

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: otp);

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    } on FirebaseAuthException catch (ex) {
      log(ex.code.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify OTP"),
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          TextField(
            maxLength: 6,
            controller: otpController,
            decoration:
                InputDecoration(labelText: "6-digit OTP", counterText: ""),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              verifyOtp();
            },
            child: Text("Verify"),
          ),
        ],
      ),
    );
  }
}
