import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management/db/income_expence.dart';
import 'package:money_management/db/transaction_db.dart';
import 'package:money_management/models/transactions/transaction_model.dart';
import 'package:money_management/screens/transaction/transactionlist.dart';
import 'package:money_management/screens/transaction/transactions.dart';
import 'package:money_management/widgets/home_head.dart';
import 'package:money_management/widgets/uppercase.dart';

//enum SearchItems { categories, date, description }

final List<String> day = ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var displayList = [];

  @override
  void initState() {
    overViewListNotifier.value =
        TransactionDB.instance.transactionListNotifier.value;
    super.initState();
    TransactionDB().transactionListNotifier;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final Size size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: TransactionDB.instance.transactionListNotifier,
            //transactionDB.listenable(),
            builder: (context, value, index) {
              return Column(
                children: [
                  //HomeHead(),
                  SizedBox(
                      height: screenHeight * .44,
                      width: screenWidth,
                      child: HomeHead(
                        key: UniqueKey(),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Recent Transactions',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: Color.fromARGB(255, 15, 14, 14))),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Transactions()));
                          },
                          child: const Text('See all',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: Color.fromARGB(255, 15, 14, 14))),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white24,
                      height: 300,
                      child: ValueListenableBuilder(
                          valueListenable:
                              TransactionDB.instance.transactionListNotifier,
                          builder: (BuildContext ctx,
                              List<TransactionModel> newList, Widget? _) {
                            return (newList.isEmpty)
                                ? const Center(
                                    child: Text('No transactions added yet'),
                                  )
                                : ListView.separated(
                                    padding: const EdgeInsets.all(5),
                                    itemBuilder: (ctx, index) {
                                      final int lastIndex =
                                          transactionDB.length - 1;
                                      final int reversedIndex =
                                          lastIndex - index;

                                      final value = newList[reversedIndex];
                                      return Card(
                                        color: const Color.fromARGB(
                                            255, 248, 246, 246),
                                        elevation: 0,
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 244, 240, 228),
                                            radius: 50,
                                            child: Image.asset(
                                              'assets/images/${value.category.categoryImage}.png',
                                              height: 20,
                                              width: 20,
                                            ),
                                          ),

                                          title: Text('₹ ${value.amount}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 17,
                                                  color:
                                                      value.finanace == 'income'
                                                          ? Colors.green
                                                          : Colors.red)),
                                          subtitle: Text(value
                                              .category.categoryName
                                              .capitalize()),
                                          trailing: Text(
                                            parseDateTime(value.dateTime),
                                          ),
                                          //
                                        ),
                                      );
                                    },
                                    separatorBuilder: (ctx, index) {
                                      return const Divider(
                                        height: 4,
                                        thickness: 2,
                                      );
                                    },
                                    itemCount:
                                        newList.length > 3 ? 3 : newList.length,
                                  );
                          }),
                    ),
                  )
                ],
              );
            }),
      )),
    );
  }
}

String parseDateTime(DateTime date) {
  final dateFormatted = DateFormat.MMMMd().format(date);

  final splitedDate = dateFormatted.split(' ');

  return "${splitedDate.last}  ${splitedDate.first} ";
}