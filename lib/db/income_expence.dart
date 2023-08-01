import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management/db/category_db.dart';
import 'package:money_management/db/transaction_db.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/models/transactions/transaction_model.dart';

int totals = 0;

final transactionDB = Hive.box<TransactionModel>(transactionDBName);
final categoryDB = Hive.box<CategoryModel>(categoryDBName);
ValueNotifier expenseTotal = ValueNotifier(0.0);
ValueNotifier incomeTotal = ValueNotifier(0.0);

class IncomeAndExpence {
  int total() {
    var history2 = transactionDB.values.toList();
    List a = [0,0];
    for (int i = 0; i < history2.length; i++) {
      a.add(history2[i].finanace == 'income'
          ? int.parse(history2[i].amount)
          : int.parse(history2[i].amount) * -1);
    }
    totals = a.reduce((value, element) => value + element);
    return totals;
  }

  int income() {
    var history2 = transactionDB.values.toList();
    List a = [0,0];
    for (int i = 0; i < history2.length; i++) {
      a.add(
          history2[i].finanace == 'income'? int.parse(history2[i].amount):0);
    }
    totals = a.reduce((value, element) => value + element);
    return totals;
  }

  int expense() {
    var history2 = transactionDB.values.toList();
    List a = [0,0 ];
    for (int i = 0; i < history2.length; i++) {
      a.add(
          history2[i].finanace == 'income' ? 0 : int.parse(history2[i].amount));
    }
    totals = a.reduce((value, element) => value + element);
    return totals;
  }
}
