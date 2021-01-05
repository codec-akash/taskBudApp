import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Global {
  BuildContext _context;
  Color primary;
  Color accent;
  Gradient cardGradient;

  Global(_context) {
    this._context = _context;
    primary = Theme.of(_context).primaryColor;
    accent = Theme.of(_context).accentColor;

    cardGradient = LinearGradient(
      colors: [
        primary.withOpacity(0.5),
        accent.withOpacity(0.9),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0, 1],
    );
  }

  Gradient cardBackgroundGradient() {
    return cardGradient;
  }
}

BorderRadius textFieldBorderRadius = BorderRadius.circular(15.0);

BorderSide textFieldBorderSide = BorderSide(
  color: Colors.white,
  width: 2.0,
);

Gradient backgroundGradient = LinearGradient(
  colors: [
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

TextStyle scaffoldHeader = TextStyle(
  color: Colors.white,
);

TextStyle headerStyle = TextStyle(
  fontSize: 28.0,
  color: Colors.white,
  fontWeight: FontWeight.w700,
);
