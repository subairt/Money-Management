import 'package:flutter/material.dart';
import 'package:money_management/db/income_expence.dart';
import 'package:money_management/widgets/limit.dart';
import 'package:money_management/widgets/rowaccess.dart';

class HomeHead extends StatefulWidget {
  const HomeHead({super.key});

  @override
  State<HomeHead> createState() => _HomeHeadState();
}

class _HomeHeadState extends State<HomeHead> {

  TextStyle textStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 19,
      color: Color.fromARGB(255, 15, 14, 14));

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final  screenwidth = size.width;
    final  screenheight = size.height;
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: screenheight * 0.3,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(199, 12, 12, 0.88),
                    Color.fromRGBO(255, 67, 40, 0.88),
                    Color.fromRGBO(247, 89, 10, 0.878)
                  ]),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(208),
                      bottomRight: Radius.circular(0))),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(17),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Hello there',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 19,
                                  color: Color.fromARGB(255, 224, 223, 223)),
                            ),
                            SizedBox(
                              width: screenwidth * 0.6,
                            ),
                            GestureDetector(
                              onTap: () async {
                                Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                        builder: (context) => const Limit()));
                              },
                              child: const Icon(
                                Icons.add_box,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Welcome Back!',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 19,
                              color: Color.fromARGB(255, 224, 223, 223)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: screenheight * 0.15),
            child: Container(
              height: 170,
              width: 320,
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 173, 172, 172),
                  offset: Offset(0, 6),
                  blurRadius: 18,
                  spreadRadius: 6,
                ),
              ], color: Colors.white, borderRadius: BorderRadius.circular(24)),
              // ignore: prefer_const_constructors
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Total Balance',
                      style: textStyle,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text('₹${IncomeAndExpence().total()}',
                        style: textStyle),
                  ),
                  const SizedBox(height: 25),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Rowaccess(
                          text: 'Income',
                          backgroundcolor: Colors.green,
                          icon: Icon(Icons.arrow_upward),
                        ),
                        Rowaccess(
                            text: 'Expense',
                            backgroundcolor: Colors.red,
                            icon: Icon(Icons.arrow_downward)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 55),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹${IncomeAndExpence().income()}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 19,
                              color: Colors.green),
                        ),
                        Text(
                          '₹${IncomeAndExpence().expense()}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 19,
                              color: Colors.red),
                        ),

                        // Rowaccess2(textcolor: Colors.green, text: '₹${IncomeAndExpence().income()}',),
                        // Rowaccess2(textcolor: Colors.red, text: '₹${IncomeAndExpence().expense()}',),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
