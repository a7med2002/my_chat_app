import 'package:chat_app/screens/chat/chat_screen.dart';
import 'package:chat_app/widgets/custom_primary_button.dart';
import 'package:chat_app/widgets/custom_txt_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  static String id = "/signupScreen";
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 24,
              children: [
                Image.asset("assets/images/chat.png", width: 100, height: 100),
                Text(
                  "Signup",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                CustomTxtField(
                  hintTxt: "Email",
                  borderColor: Colors.greenAccent,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                CustomTxtField(
                  hintTxt: "Password",
                  borderColor: Colors.greenAccent,
                  controller: passwordController,
                  isPassword: true,
                ),
                SizedBox(height: 4),
                CustomPrimaryButton(
                  title: "SignUp",
                  btnColor: Colors.greenAccent,
                  txtColor: Colors.white,
                  fontSize: 18,
                  onTap: () async {
                    try {
                      final newUser = await _auth
                          .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                      Navigator.pushNamed(context, ChatScreen.id);
                    } catch (error) {
                      print(error.toString());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
