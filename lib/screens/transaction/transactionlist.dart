import 'package:flutter/material.dart';
import 'package:money_management/db/transaction_db.dart';
import 'package:money_management/models/transactions/transaction_model.dart';
import 'package:money_management/screens/category/category.dart';
import 'package:money_management/screens/transaction/slidabletransaction.dart';

ValueNotifier<List<TransactionModel>> overViewListNotifier =
    ValueNotifier(TransactionDB.instance.transactionListNotifier.value);

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDB().getAllTransactions();
    return ValueListenableBuilder(
        valueListenable: overViewListNotifier,
        builder: (BuildContext context, newList, Widget? _) {
          return ValueListenableBuilder(
              valueListenable: showCategory,
              builder: (context, showCategorylist, child) {
                //here we building the list using displayList list
                var displayList = [];
                if (showCategory.value == 'income') {
                  //here i am creating an empty list for the transaction,
                  //so i can pick the income only through the where function

                  List<TransactionModel> incomeTransactionList = [];
                  //here i converting the element into list using toList function
                  incomeTransactionList = newList
                      .where((element) => element.finanace == 'income')
                      .toList();
                  //assigning the list into displayList which is the list i declared above
                  displayList = incomeTransactionList;
                } else if (showCategory.value == 'Expense') {
                  List<TransactionModel> expenseTransactionList = [];
                  expenseTransactionList = newList
                      .where((element) => element.finanace == 'expense')
                      .toList();
                  displayList = expenseTransactionList;
                } else {
                  displayList = newList;
                }
                return (displayList.isEmpty)
                    ? const SingleChildScrollView(
                        child: Center(
                        child: Text('No transaction added yet'),
                      ))
                    : ListView.separated(
                        padding: const EdgeInsets.all(5),
                        itemBuilder: (ctx, index) {
                          /* final int lastIndex = transactionDB.length - 1;
                          final int reversedIndex = lastIndex - index; */

                          //final value = newList[reversedIndex];
                          final transaction = displayList[index];
                          return SlidableTransaction(transaction: transaction);
                        },
                        separatorBuilder: (ctx, index) {
                          return const Divider(
                            height: 3,
                            // thickness: 5,
                          );
                        },
                        itemCount: displayList.length);
              });
        });
  }
}
