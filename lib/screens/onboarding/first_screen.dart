import 'package:flutter/material.dart';
import 'package:money_management/screens/onboarding/second_screen.dart';
import 'package:money_management/widgets/buttons.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.5, // use percentage of screen height
                width: size.width * 0.9, // use percentage of screen width
                child: Padding(
                  padding: EdgeInsets.only(left: size.width * 0.07),
                  //EdgeInsets.all(size.width * 0.05), // use percentage of screen width
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/firstgif.gif'),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Text(
                "Let's \n Manage\n  money with us",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: size.width * 0.1, // use percentage of screen width
                  color: const Color.fromARGB(255, 218, 148, 19),
                  shadows: const <Shadow>[
                    Shadow(
                      offset: Offset(1, 1),
                      color: Color.fromARGB(255, 218, 148, 19),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.1,
                    left: size.width * 0.07), // use percentage of screen height
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SecondScreen()),
                    );
                  },
                  child: button(
                      size.width * 0.3,
                      size.height * 0.05,
                      'Get Started',
                      size.width *
                          0.05), // use percentage of screen width and height
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
