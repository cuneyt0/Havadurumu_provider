import 'package:flutter/material.dart';


class MyTheme{
  MaterialColor _renk;
  late ThemeData _tema;



  ThemeData get tema => _tema;

  set tema(ThemeData value) {
    _tema = value;
  }

  MyTheme(this._renk,this._tema, );

  MaterialColor get renk => _renk;

  set renk(MaterialColor value) {
    _renk = value;
  }
}