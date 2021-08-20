import 'package:flutter/material.dart';

InputDecoration buildInputDecoration(String label, String hint) {
  return InputDecoration(
    contentPadding: EdgeInsetsDirectional.only(top: 5, bottom: 5),
    fillColor: Colors.white,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.teal,
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
    alignLabelWithHint: true,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    labelText: label,
    labelStyle: TextStyle(
        //height: 0.5,
        ),
    hintText: hint,
    hintStyle: TextStyle(
      color: Colors.grey.shade400,
      fontStyle: FontStyle.italic,
    ),
  );
}
