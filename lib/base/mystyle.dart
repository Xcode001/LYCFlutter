import 'package:flutter/material.dart';

class MyStyle {
  static const font20 = 20.0;
  static const font18 = 18.0;
  static const font16 = 16.0;
  static const font14 = 14.0;
  static const font12 = 12.0;

  static const double4 = 4.0;
  static const double8 = 8.0;
  static const double10 = 10.0;
  static const double12 = 12.0;
  static const double16 = 16.0;
  static const double19 = 19.0;
  static const double20 = 20.0;
  static const double24 = 24.0;
  static const double26 = 26.0;
  static const double32 = 32.0;
  static const double40 = 40.0;
  static const double48 = 48.0;
  static const double52 = 52.0;
  static const double64 = 64.0;

  static final Color colorPrimaryDark = Colors.grey[800];
  static final Color colorPrimary = Colors.grey[600];
  static final Color colorAccent = const Color(0xFFf8A531);
  static final Color colorWhite = Colors.white;
  static final Color colorBlack = Colors.black;
  static final Color colorGrey = Colors.grey[600];
  static final Color colorLightGrey = Colors.grey[300];
  static final Color colorGreen = const Color(0xFF17A554);
  static final Color layoutBackground = Colors.grey[100];
  static final Color doctorCategoryHeaderBackground = Colors.grey[300];
  static final Color colorDarkGrey = Colors.grey[850];
  static final Color defaultGrey = Colors.grey;
  static final Color colorRed = Colors.red[700];
  static final Color colorFB = const Color(0xFF3B5998);
  static final Color chatRespondBackground = Colors.orange[100];

  static final String blankSchedule = "_";

  static TextStyle headerStyle() {
    return new TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: font18,
    );
  }

  static TextStyle captionTextStyle() {
    return new TextStyle(color: colorBlack, fontSize: font16);
  }

  static TextStyle titleTextStyle() {
    return new TextStyle(fontSize: font14, color: MyStyle.colorDarkGrey);
  }

  static TextStyle appbarTitleStyle() {
    return new TextStyle(color: colorBlack, fontSize: font14);
  }

  static TextStyle buttonTextStyle() {
    return new TextStyle(
        color: colorWhite, fontSize: font14, fontWeight: FontWeight.bold);
  }

  static TextStyle listItemTextStyle() {
    return new TextStyle(color: MyStyle.colorBlack, fontSize: font14);
  }

  static TextStyle dateTimeTextStyle() {
    return new TextStyle(color: MyStyle.defaultGrey, fontSize: font12);
  }

  static TextStyle customTextStyle(Color txtcolor) {
    return new TextStyle(fontSize: font14, color: txtcolor);
  }

  static TextStyle myTextStyle(
      Color mColor, double mSize, FontWeight mFontWeight) {
    return new TextStyle(
        fontSize: mSize, color: mColor, fontWeight: mFontWeight);
  }

  static TextStyle itemTextStyle() {
    return new TextStyle(fontSize: font12, color: MyStyle.colorDarkGrey);
  }
}
