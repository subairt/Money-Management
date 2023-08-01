import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/db/category_db.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/screens/category/category.dart';
import 'package:money_management/screens/home_screen.dart';
import 'package:money_management/screens/settings_screens/settings.dart';
import 'package:money_management/screens/transaction/add_transaction.dart';
import 'package:money_management/statitics/statitics_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int indexColor = 0;
  List screen = [
    const Home(),
    const Category(),
    const Statitics(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[indexColor],
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final categorydb = Hive.box<CategoryModel>(categoryDBName);
          if (categorydb.isNotEmpty) {
            // ignore: use_build_context_synchronously
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddTransaction()));
          } else {
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Please Add Category First !!!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17),
                ),
                duration: Duration(seconds: 3),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
         backgroundColor: const Color.fromRGBO(255, 67, 40, 0.88),
       
        child:const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.only(top: 7.5, bottom: 7.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    indexColor = 0;
                  });
                },
                child: Icon(
                  Icons.home,
                  color: indexColor == 0 ? Colors.amber : Colors.grey,
                ),
              ),

              GestureDetector(
                  onTap: () {
                    setState(() {
                      indexColor = 1;
                    });
                  },
                  child: Icon(
                    Icons.category,
                    size: 30,
                    color: indexColor == 1 ? Colors.amber : Colors.grey,
                  )),
              //const SizedBox(width: 20),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      indexColor = 2;
                    });
                  },
                  child: Icon(
                    Icons.insert_chart,
                    size: 30,
                    color: indexColor == 2 ? Colors.amber : Colors.grey,
                  )),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      indexColor = 3;
                    });
                  },
                  child: Icon(
                    Icons.settings,
                    size: 30,
                    color: indexColor == 3 ? Colors.amber : Colors.grey,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
