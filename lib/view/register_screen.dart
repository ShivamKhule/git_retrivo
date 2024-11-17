import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_snackbar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  bool _showPassword = true;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Register",
            style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _emailTextEditingController,
              style: const TextStyle(color: Colors.white, fontSize: 20),
              decoration: const InputDecoration(
                hintText: "Enter your email",
                hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _passwordTextEditingController,
              style: const TextStyle(color: Colors.white, fontSize: 20),
              obscureText: _showPassword,
              decoration: InputDecoration(
                hintText: "Enter your password",
                border: const OutlineInputBorder(),
                hintStyle: const TextStyle(color: Colors.white, fontSize: 20),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _showPassword = !_showPassword;
                    setState(() {});
                  },
                  child: Icon(
                    _showPassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              if (_emailTextEditingController.text.trim().isNotEmpty && _passwordTextEditingController.text.trim().isNotEmpty) {
                try {
                  UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: _emailTextEditingController.text, password: _passwordTextEditingController.text,);
                  log("USER CREDIENTIALS : $userCredential");
                  CustomSnackbar.showCustomSnackbar(message: "User Register Successfully.", context: context);
                  Navigator.of(context).pop();
                }on FirebaseAuthException catch (error) {
                  print(error.code);
                  print("${error.message}");
                  CustomSnackbar.showCustomSnackbar(message: error.message!, context: context);
                }
              }else{
                CustomSnackbar.showCustomSnackbar(message: "Please enter valid Fields.", context: context);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
              child: const Text(
                "Register User",
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
