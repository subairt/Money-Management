 import 'package:flutter/material.dart';

class Rowaccess extends StatelessWidget {
  const Rowaccess({super.key,required this.text,required this.backgroundcolor, required this.icon});
  
final String text;
final Color backgroundcolor;
final Icon icon;
  @override
  Widget build(BuildContext context) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
             CircleAvatar(
              radius: 13,
              backgroundColor: backgroundcolor,
              child:  Icon(
                icon.icon,
                color: Colors.white,
                size: 19,
              ),
            ),
            const SizedBox(
              width: 7,
            ),
            Text(text,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color.fromARGB(255, 15, 14, 14))),
          ],
        ),
      ],
    );
  }
}
class Rowaccess2 extends StatelessWidget {
  const Rowaccess2({super.key,required this.textcolor, required this.text});
final Color textcolor;
final String text ;

  @override
  Widget build(BuildContext context) {
    return Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 19, color: textcolor),
        );
  }
}