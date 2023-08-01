

import 'package:flutter/material.dart';
import 'package:money_management/db/income_expence.dart';
import 'package:money_management/db/transaction_db.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/models/transactions/transaction_model.dart';
import 'package:money_management/widgets/bottomnavigation.dart';
import 'package:money_management/widgets/buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  DateTime date = DateTime.now();
  String? selectedFinanace;

  CategoryModel? selectedCategoryModel;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();

  FocusNode ex = FocusNode();
  final TextEditingController amountController = TextEditingController();
  FocusNode amount = FocusNode();

  final List<String> _itemindex = ['income', 'expense'];
  void initstate() {
    super.initState();
    IncomeAndExpence().income();
  }

  final Widget devider = const SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            backgroundContainer(context),
            SingleChildScrollView(
              child: mainContainer(),
            ),
          ],
        ),
      ),
    );
  }

  Container mainContainer() {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 150, 149, 149),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(10, 14),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: size.height * 0.7,
      width: size.width * 0.9,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            devider,
            name(),
            devider,
            description(),
            devider,
            transactionAmount(),
            devider,
            finanace(),
            devider,
            dateTime(),
            // const SizedBox(height: 50),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  addTransaction();
                }
              },
              child: button(size.width * 0.30, size.height * 0.06, 'Save', 18),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Container dateTime() {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: Colors.grey),
      ),
      width: 300,
      child: TextButton(
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(const Duration(days:30 )),
              lastDate: DateTime.now());
          if (newDate == null) {
            return;
          } else {
            setState(() {
              date = newDate;
            });
          }
        },
        child: Text(
          'Date:${date.year}/${date.month}/${date.day}',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Padding finanace() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Colors.grey,
          ),
        ),
        child: DropdownButtonFormField<String>(
          value: selectedFinanace,
          onChanged: ((value) {
            setState(() {
              selectedFinanace = value!;
            });
          }),
          items: _itemindex
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/$e.png',
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(width: 10), 
                      Text(
                        e,
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
          hint: const Text(
            'Select',
            style: TextStyle(color: Colors.grey),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Select finanace';
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }

  Padding transactionAmount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: 300,
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Select Amount';
            } else if (value.contains(',')) {
              return 'Please remove special character';
            } else if (value.contains('.')) {
              return 'Please remove special character';
            } else if (value.contains(' ')) {
              return 'Please Enter a valid number';
            } else {
              return null;
            }
          },
          keyboardType: TextInputType.number,
          focusNode: amount,
          controller: amountController,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'Amount',
            labelStyle: const TextStyle(fontSize: 17, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 2, color: Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 2, color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(width: 2, color: Colors.green),
            ),
          ),
        ),
      ),
    );
  }

  Padding description() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: 300,
        child: TextField(
          focusNode: ex,
          controller: descriptionController,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'Description',
            labelStyle: const TextStyle(fontSize: 17, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 2, color: Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 2, color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(width: 2, color: Colors.green),
            ),
          ),
        ),
      ),
    );
  }

  Padding name() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Colors.grey,
          ),
        ),
        child: DropdownButtonFormField<String>(
          items: dropdownitems(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Select Name';
            } else {
              return null;
            }
          },
          onChanged: (value) {
            setState(() {
              // selectedCategoryModel = value;
            });
          },
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> dropdownitems() {
    var boxitems = categoryDB.values.map(
      (item) => DropdownMenuItem<String>(
        value: item.categoryName,
        child: Row(
          children: [
            Image.asset(
              'assets/images/${item.categoryImage}.png',
              width: 25,
              height: 25,
            ),
            const SizedBox(
              width: 7,
            ),
            Text(
              item.categoryName,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
            ),
          ],
        ),
        onTap: () {
          selectedCategoryModel = item;
        },
      ),
    );
    return boxitems.toList();
  }

  Future addTransaction() async {
    if (selectedCategoryModel == null) {
      return;
    }
    final model = TransactionModel(
        description: descriptionController.text,
        amount: amountController.text,
        finanace: selectedFinanace!,
        dateTime: date,
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        category: selectedCategoryModel!);
    TransactionDB().insertTransaction(model);
    Navigator.of(context).pop();
    TransactionDB.instance.getAllTransactions();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Transaction Added Successfully',
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.amber,
      ),
    );
    limitCheck(selectedFinanace!);
  }

  limitCheck(String finanace) async {
    if (finanace == 'expense') {
      final sharedPref = await SharedPreferences.getInstance();
      var limitvariable = sharedPref.getString('limit');

      int expense1 = IncomeAndExpence().expense();
      // ignore: use_build_context_synchronously
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const BottomNavBar()));
      double limit = double.parse(limitvariable!);
      double expenses = expense1.toDouble();
      double eightyPercentOfLimit = limit * 0.8;

      if (expenses >= eightyPercentOfLimit && expenses < limit) {
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Expense has crossed \n 80% of the limit',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              );
            });
      }
      if(expenses >=limit){
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
           builder: (context){
            return const AlertDialog(
              title: Center(
                child: Text('Expense has crossed \n the limit',
                style: TextStyle(color: Colors.red),
                ),
              ),
            );
           });
      }
    }
  }
}

Column backgroundContainer(BuildContext context) {
  return Column(
    children: [
      Container(
        width: double.infinity,
        height: 240,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(199, 12, 12, 0.88),
              Color.fromRGBO(255, 67, 40, 0.88),
              Color.fromRGBO(255, 152, 100, 0.88),
            ],
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(208),
            bottomRight: Radius.circular(0),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 80),
                  const Text(
                    'Add Transaction',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
