import 'package:chat_app/screens/chat/chat_screen.dart';
import 'package:chat_app/widgets/custom_primary_button.dart';
import 'package:chat_app/widgets/custom_txt_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static String id = "/loginScreen";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final _auth = FirebaseAuth.instance;

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
                  "Login",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                CustomTxtField(
                  hintTxt: "Email",
                  borderColor: Colors.lightBlueAccent,
                  controller: emailController,
                ),
                CustomTxtField(
                  hintTxt: "Password",
                  borderColor: Colors.lightBlueAccent,
                  controller: passwordController,
                ),
                SizedBox(height: 4),
                CustomPrimaryButton(
                  title: "Login",
                  btnColor: Colors.lightBlueAccent,
                  txtColor: Colors.white,
                  fontSize: 18,
                  onTap: () async {
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      if (user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChatScreen()),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Invalied Credintional"),
                          backgroundColor: Colors.red,
                        ),
                      );
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
