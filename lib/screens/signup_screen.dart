import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_wall_app/components/kbutton.dart';
import 'package:social_wall_app/components/ktext_field.dart';
import 'package:social_wall_app/helper/error_message.dart';
//import 'package:social_wall_app/screens/login_page.dart';

class SignupScreen extends StatefulWidget {
  final void Function()? onTap;
  SignupScreen({super.key, required this.onTap});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController userName = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();

  void _register() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    if (password.text != confirmPassword.text) {
      Navigator.of(context).pop();
      displayMessage("Password doesn't match", context);
    } else {
      try {
        UserCredential signUp = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text, password: password.text);
        storeCredentials(signUp);
        showSuccessSnackbar("User created successfully", context);
        Navigator.of(context).pop();
      } on FirebaseAuthException catch (e) {
        Navigator.of(context).pop();
        displayMessage(e.code, context);
      }
    }
  }

  Future<void> storeCredentials(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("user")
          .doc(userCredential.user!.email)
          .set({'email': email.text, 'username': userName.text});
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.group, size: 80, color: theme.inversePrimary),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "T H O U G H T S",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              KTextField(
                  controller: userName, hint: "Username", obscureText: false),
              const SizedBox(
                height: 20,
              ),
              KTextField(controller: email, hint: "Email", obscureText: false),
              const SizedBox(
                height: 20,
              ),
              KTextField(
                  controller: password, hint: "Password", obscureText: true),
              const SizedBox(
                height: 20,
              ),
              KTextField(
                  controller: confirmPassword,
                  hint: "Confirm Password",
                  obscureText: true),
              // const SizedBox(
              //   height: 15,
              // ),
              // const Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Text(
              //       "Forget Password?",
              //       style: TextStyle(
              //           decoration: TextDecoration.underline,
              //           fontSize: 14,
              //           fontWeight: FontWeight.w600),
              //     ),
              //   ],
              // ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                text: "Sign Up",
                color: theme.primary,
                onPressed: _register,
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(fontSize: 15, color: theme.inversePrimary),
                  ),
                  InkWell(
                    onTap: widget.onTap,
                    child: Text(
                      "Login Here",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: theme.inversePrimary),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
