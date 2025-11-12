import 'package:flutter/material.dart';

class CustomTxtField extends StatelessWidget {
  final String hintTxt;
  final Color borderColor;
  final TextEditingController controller;
  final bool? isPassword;
  final TextInputType? keyboardType;
  const CustomTxtField({
    super.key,
    required this.hintTxt,
    required this.borderColor,
    required this.controller,
    this.isPassword,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ?? false,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(14),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(14),
        ),
        hintText: hintTxt,
      ),
    );
  }
}
