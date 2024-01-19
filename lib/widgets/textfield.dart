import 'package:flutter/material.dart';

Widget buildTextFieldWithIcon({
  required TextEditingController controller,
  required String hintText,
  TextInputType? keyboardType,
}) {
  return Container(
    height: 50,
    decoration: BoxDecoration(),
    child: TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
    ),
  );
}
