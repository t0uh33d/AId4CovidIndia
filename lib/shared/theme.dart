import 'package:flutter/material.dart';

var otpinputDecoration = InputDecoration(
    // fillColor: Colors.transparent,
    // filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 2.0)));
final kHintTextStyle = TextStyle(
  color: Colors.white54,
  // fontFamily: 'OpenSans',
);
const textDecorationa = InputDecoration(
    fillColor: Colors.transparent,
    filled: true,
    hintStyle: TextStyle(color: Colors.white),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 1.0)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2.0)));
final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  // fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
