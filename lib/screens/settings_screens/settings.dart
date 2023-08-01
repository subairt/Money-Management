import 'package:flutter/material.dart';
import 'package:money_management/screens/settings_screens/about.dart';
import 'package:money_management/screens/settings_screens/privacypolicy.dart';
import 'package:money_management/screens/settings_screens/settings_functions.dart';
import 'package:money_management/screens/settings_screens/termsandconditions.dart';
import 'package:money_management/widgets/app_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController limitchangecontroller = TextEditingController();

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenHeight = size.height;
    final double textSize = size.width * 0.05;
    return SafeArea(
      child: Scaffold(
        appBar: appbar('Settings', false),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  if (prefs.getString("limit") == null) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Please Set Limit in Home Page",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 17),
                        ),
                        backgroundColor: Colors.red,
                        //duration: Duration.th,
                      ),
                    );
                  } else {
                    // ignore: use_build_context_synchronously
                    SettingFunctions().editLimit(context);
                  }

                
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.warning,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Change Limit',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: textSize,
                          //19,
                          color: const Color.fromARGB(255, 11, 11, 11)),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const About()));
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      'About',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: textSize,
                          color: const Color.fromARGB(255, 11, 11, 11)),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              GestureDetector(
                onTap: () {
                  SettingFunctions().resetApp(context);
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.restore,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Reset',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: textSize,
                          color: const Color.fromARGB(255, 11, 11, 11)),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              GestureDetector(
                onTap: () {
                  Share.share(
                      'Hey! check out this new app......https://play.google.com/store/apps/details?id=in.brototype.spendee');
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.share,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Share',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: textSize,
                          color: const Color.fromARGB(255, 11, 11, 11)),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Terms()));
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.document_scanner_outlined,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Terms&Conditions',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: textSize,
                          color: const Color.fromARGB(255, 11, 11, 11)),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PrivacyPolicy()));
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.privacy_tip_outlined,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Privacy Policy',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: textSize,
                          color: const Color.fromARGB(255, 11, 11, 11)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}