import 'package:flutter/material.dart';

const bottomNavTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'Google Sans',
  fontSize: 12.0,
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(
    vertical: 7.5,
    horizontal: 15.0,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(
        8.0,
      ),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(
        0XFF505050,
      ),
      width: 2.5,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(
        8.0,
      ),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFF505050),
      width: 2.5,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(
        8.0,
      ),
    ),
  ),
);

const sTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(
    vertical: 7.5,
    horizontal: 15.0,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(
        8.0,
      ),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0XFFA8A8A8),
      width: 2.0,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(
        8.0,
      ),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFFA8A8A8),
      width: 2.0,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(
        8.0,
      ),
    ),
  ),
);

Color mainColor = Color(0XFFED0101);
var roundedRectangle = RoundedRectangleBorder(
  borderRadius: BorderRadiusDirectional.circular(12),
  side: BorderSide(width: 0.1, color: mainColor),
);

var roundedRectangle32 = RoundedRectangleBorder(
  borderRadius: BorderRadius.vertical(
    top: Radius.circular(16),
  ),
);

var titleStyle = TextStyle(
  fontSize: 22.5,
  fontWeight: FontWeight.bold,
  letterSpacing: 1,
  fontFamily: 'Google Sans Medium',
);

var subTitleStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  letterSpacing: 0.5,
  fontFamily: 'Google Sans Medium',
);
