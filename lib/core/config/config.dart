import 'package:flutter/material.dart';

class Config {
  static const whiteClr = Colors.white;
  static Color greyClr = Colors.grey.shade400;

  static Color grey2Clr = Colors.grey.shade600;



  static const violetClr = Color.fromARGB(255, 67, 129, 180);


static LinearGradient get primaryToSecondaryGradient {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
       Color.fromARGB(255, 67, 129, 180),
      Color.fromARGB(255, 59, 116, 162),
       Colors.white,
        Colors.white
      ],
      stops: [0.0, 0.5, 0.5, 1.0],
    );
  }


  static const orangeAccent =  Color.fromRGBO(255, 245, 238, 1);

  static const redAccentLigthClr = Color.fromARGB(255, 250, 139, 139);

  static const __baseUrl = 'http://10.0.2.2:3030/api/';

  static const loginUrl = "${__baseUrl}user/login";
  static const registerUrl = "${__baseUrl}user/register";

  static const eventUrl = "${__baseUrl}event";

  static const regUrl = "${__baseUrl}register";
}
