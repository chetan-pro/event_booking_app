import 'package:flutter/material.dart';

class RegistrationTextInput extends StatelessWidget {
  RegistrationTextInput(
      {this.controller,
      this.hintText,
      required this.obscureText,
      this.prefixIcon});

  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return '*field is required';
          } else {
            return null;
          }
        },
        obscureText: obscureText,
        maxLines: 1,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.end,
        controller: controller,
        style: TextStyle(fontSize: 15),
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 0, color: Color.fromRGBO(216, 216, 216, 1))),
          contentPadding:
              EdgeInsets.only(left: 10, right: prefixIcon != null ? 0 : 10),
          hintText: hintText,
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}
