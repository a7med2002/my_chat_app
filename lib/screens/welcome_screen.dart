import 'package:chat_app/screens/Auth/login_screen.dart';
import 'package:chat_app/screens/Auth/signup_screen.dart';
import 'package:chat_app/widgets/custom_primary_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  static String id = "welcomeScreen";
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              Image.asset("assets/images/chat.png", width: 100, height: 100),
              Text(
                "Let's Chat",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              CustomPrimaryButton(
                title: "Login",
                btnColor: Colors.lightBlueAccent,
                txtColor: Colors.white,
                fontSize: 18,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                ),
              ),
              CustomPrimaryButton(
                title: "Signup",
                btnColor: Colors.greenAccent,
                txtColor: Colors.white,
                fontSize: 18,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
