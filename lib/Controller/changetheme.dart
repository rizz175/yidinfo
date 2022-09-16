import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeTheme extends ChangeNotifier
{

 late ThemeData selectedata;

 ThemeData light=ThemeData.light().copyWith(
   primaryColor:Colors.orangeAccent,
      focusColor:Colors.orangeAccent,



  elevatedButtonTheme: ElevatedButtonThemeData(
 style: ElevatedButton.styleFrom(
  primary:Colors.orangeAccent,// Button color
  onPrimary: Colors.white, // Text color
 ),
 ),
 );
 ThemeData dark=ThemeData.dark().copyWith(
     primaryColor:Colors.orangeAccent,
     focusColor:Colors.orangeAccent,
  elevatedButtonTheme: ElevatedButtonThemeData(
   style: ElevatedButton.styleFrom(
    primary:Colors.orangeAccent,// Button color
    onPrimary: Colors.white, // Text color
   ),
  ),
 );



 ChangeTheme(int mode)
 {
   selectedata=mode==0?dark:light;


 }
 gettheme()
 {
 return selectedata;



 }
 settheme(ThemeData themeD) {
print(themeD);
   selectedata = themeD;
   notifyListeners();
 }
}