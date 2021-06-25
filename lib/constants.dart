import 'package:flutter/material.dart';

AppBar appBar(String title) {
  return AppBar(
    title: Text(title),
  );
}

TextField inputTextField(String hint) {
  return TextField(
    decoration: InputDecoration(
      hintText: hint,
      contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 40.0),
      hintStyle: TextStyle(color: Colors.grey),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(width: 1.0, color: Colors.lightBlue)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(width: 2.0, color: Colors.lightBlue)),
    ),
    onSubmitted: (value) {},
    style: TextStyle(color: Colors.black),
  );
}

MaterialButton actionButtons(
    String title, var function, Color color, double width) {
  return MaterialButton(
    child: Text(
      title,
      style: TextStyle(color: Colors.white),
    ),
    elevation: 10.0,
    height: 45.0,
    minWidth: width,
    onPressed: function,
    color: color,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
  );
}

SizedBox sizedBox(double height) {
  return SizedBox(
    height: height,
  );
}
