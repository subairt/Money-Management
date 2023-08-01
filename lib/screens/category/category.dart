import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management/db/transaction_db.dart';
import 'package:money_management/screens/category/add_category.dart';
import 'package:money_management/screens/category/category_list.dart';
import 'package:money_management/screens/home_screen.dart';
import 'package:money_management/screens/transaction/transactionlist.dart';
import 'package:money_management/widgets/buttons.dart';

ValueNotifier showCategory = ValueNotifier('All');

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  ValueNotifier showCategory = ValueNotifier('All');
  TextEditingController amountC = TextEditingController();

  @override
  void initState() {
    overViewListNotifier.value =
        TransactionDB.instance.transactionListNotifier.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(247, 22, 22, 0.878),
                  Color.fromRGBO(255, 67, 40, 0.88),
                  Color.fromRGBO(255, 152, 100, 0.88),
                ]),
              ),
            ),
            title: const Center(
              child: Text('Category'),
            ),
            automaticallyImplyLeading: false,
          ),
          body: Column(
            children: [
              const Expanded(
                child: CategoryList(),
              ),
              SingleChildScrollView(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddCategory()),
                    );
                  },
                  child: button(120, 50, 'Add', 18),
                ),
              ),
              const SizedBox(
                height: 100,
              )
            ],
          )),
    );
  }
}

popoutfuction(BuildContext context) {
  return Navigator.of(context).pop();
}

String parseDate(DateTime date) {
  return '${day[date.weekday - 1]}-${date.year} ${DateFormat.MMMd().format(date)}';
}