import 'package:flutter/material.dart';

button(
  double width,
  double height,
  String text,
  double fontsize,
) {
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      gradient: const LinearGradient(colors: [
        Color.fromRGBO(247, 22, 22, 0.878),
        Color.fromRGBO(255, 67, 40, 0.88),
        Color.fromRGBO(236, 84, 7, 0.878),
      ]),
    ),
    width: width,
    height: height,
    child: Text(
      text,
      style: TextStyle(
        fontSize: fontsize,
        fontWeight: FontWeight.w500,
        color: const Color.fromARGB(255, 236, 235, 235),
      ),
    ),
  );
}