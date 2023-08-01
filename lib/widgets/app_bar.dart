import 'package:flutter/material.dart';

appbar(String text, bool value, [IconData? icon]) {
  return AppBar(
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(247, 22, 22, 0.878),
          Color.fromRGBO(255, 67, 40, 0.88),
          Color.fromRGBO(255, 152, 100, 0.88),
        ]),
      ),
    ),
    //backgroundColor: Colors.amber,
    title: Center(child: Text(text)),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Icon(icon),
      ),
    ],

    automaticallyImplyLeading: value,
  );
}