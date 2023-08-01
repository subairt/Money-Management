import 'package:flutter/material.dart';
import 'package:money_management/main.dart';
import 'package:money_management/widgets/bottomnavigation.dart';
import 'package:money_management/widgets/buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _usernameController = TextEditingController();

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(50),
                  child: SizedBox(
                      height: 350,
                      width: 370,
                      child: Image.asset(
                        "assets/images/mngr3.png",
                        fit: BoxFit.fill,
                      )),
                ),
                const SizedBox(
                  height: 80,
                ),
                Form(
                  key: _formkey,
                  child: SizedBox(
                    width: screenWidth * .6,
                    height: screenHeight * .08,
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.01,
                              horizontal: screenHeight * 0.01),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: 'Username'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required Name';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * .09),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onTap: () {
                      if(_formkey.currentState!.validate()){
                        checkLogin(context);
                         Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BottomNavBar()),
                      );
                      }
                     
                    },
                    child: button(size.width * 0.3, size.height * 0.05, 'Login',
                        size.width * 0.05),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void checkLogin(BuildContext ctx)async{
    final username = _usernameController.text;

    // ignore: non_constant_identifier_names
    final SharedPref = await SharedPreferences.getInstance();
    await SharedPref.setBool(saveKeyName, true);
    await SharedPref.setString('username', username);
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      ctx, MaterialPageRoute(builder: (ctx1)=>const BottomNavBar()));
  }
}
