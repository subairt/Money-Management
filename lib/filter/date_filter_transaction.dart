import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:money_management/db/transaction_db.dart';

import '../models/transactions/transaction_model.dart';

ValueNotifier<List<TransactionModel>> overViewListNotifier =
    ValueNotifier(TransactionDB.instance.transactionListNotifier.value);

class DateFilterTransaction extends StatefulWidget {
  const DateFilterTransaction({
    Key? key,
  }) : super(key: key);

  @override
  State<DateFilterTransaction> createState() => _DateFilterTransactionState();
}

class _DateFilterTransactionState extends State<DateFilterTransaction> {
  DateTime? startDate, endDate;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: const Icon(
        Icons.calendar_view_day_rounded,
      ),
      itemBuilder: (ctx) => [
        PopupMenuItem(
          value: 1,
          child: const Text(
            "All",
          ),
          onTap: () {
            overViewListNotifier.value =
                TransactionDB.instance.transactionListNotifier.value;
          },
        ),
        PopupMenuItem(
          value: 2,
          child: const Text(
            "Today",
          ),
          onTap: () {
            overViewListNotifier.value =
                TransactionDB.instance.transactionListNotifier.value;
            overViewListNotifier.value = overViewListNotifier.value
                .where((element) =>
                    element.datetime != null &&
                    element.datetime.day == DateTime.now().day &&
                    element.datetime.month == DateTime.now().month &&
                    element.datetime.year == DateTime.now().year)
                .toList();
          },
        ),
        PopupMenuItem(
            value: 2,
            child: const Text(
              "Yesterday",
            ),
            onTap: () {
              overViewListNotifier.value =
                  TransactionDB.instance.transactionListNotifier.value;
              overViewListNotifier.value = overViewListNotifier.value
                  .where((element) =>
                       element.datetime != null &&
                      element.datetime.day == DateTime.now().day - 1 &&
                      element.datetime.month == DateTime.now().month &&
                      element.datetime.year == DateTime.now().year)
                  .toList();
            }),
        PopupMenuItem(
            value: 2,
            child: const Text(
              "Month",
            ),
            onTap: () {
              overViewListNotifier.value =
                  TransactionDB.instance.transactionListNotifier.value;
              overViewListNotifier.value = overViewListNotifier.value
                  .where((element) =>
                     element.datetime != null &&
                      element.datetime.month == DateTime.now().month &&
                      element.datetime.year == DateTime.now().year)
                  .toList();
            }),
        PopupMenuItem(
          value: 5,
          child: const Text("Date Range"),
          onTap: () {
            showCustomDateRangePicker(
              context,
              dismissible: true,
              minimumDate: DateTime(2010),
              maximumDate: DateTime(DateTime.now().year + 500),
              endDate: endDate,
              startDate: startDate,
              onApplyClick: (start, end) {
                setState(() {
                  startDate = start;
                  endDate = end;
                });

                overViewListNotifier.value =
                    TransactionDB.instance.transactionListNotifier.value;
                overViewListNotifier.value = overViewListNotifier.value
                    .where((element) =>
                        element.datetime.isAfter(startDate!) &&
                        element.datetime
                            .isBefore(endDate!.add(const Duration(days: 1))))
                    .toList();
              },
              onCancelClick: () {
                setState(() {
                  endDate = null;
                  startDate = null;
                });
              },
              backgroundColor: Colors.white,
              primaryColor: const Color.fromARGB(255, 244, 98, 54),
            );
          },
        ),
      ],
    );
  }
}
