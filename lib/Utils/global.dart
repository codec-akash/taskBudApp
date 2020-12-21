import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BorderRadius textFieldBorderRadius = BorderRadius.circular(15.0);

BorderSide textFieldBorderSide = BorderSide(
  color: Colors.white,
  width: 2.0,
);

Gradient backgroundGradient = LinearGradient(
  colors: [
    // Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
    // Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
    Color.fromRGBO(130, 43, 224, 1).withOpacity(0.5),
    Color.fromRGBO(135, 212, 208, 1).withOpacity(0.9),
  ],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  stops: [0, 1],
);

TextStyle hintStyle = TextStyle(fontSize: 16.0);

TextStyle mainHeader = TextStyle(
  fontStyle: FontStyle.italic,
  fontSize: 32.0,
  fontWeight: FontWeight.bold,
);

TextStyle secondaryHeader = TextStyle(
  fontSize: 16.0,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);
