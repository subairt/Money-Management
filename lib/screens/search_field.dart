import 'package:flutter/material.dart';
import 'package:money_management/db/transaction_db.dart';
import 'package:money_management/screens/transaction/transactionlist.dart';

class SearchField extends StatefulWidget {
   const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  TextEditingController searchQueryController = TextEditingController();
  bool isTyping =false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
        ),
        child: Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextField(
            controller: searchQueryController,
            onChanged: (query) {
              setState(() {
                  searchResult(query);
              isTyping =query.isNotEmpty;
              });
          
            },
            decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
                icon: const Icon(
                  Icons.search,
                ),
                suffixIcon:isTyping ?
                IconButton(
                  onPressed: () {
                    overViewListNotifier.value =
                        TransactionDB.instance.transactionListNotifier.value;
                    searchQueryController.clear();
                  },
                  icon: const Icon(Icons.close),
                )
                :null,
                ),
          ),
        ),
      ),
    );
  }

  searchResult(String query) {
    if (query.isEmpty || query == '') {
      debugPrint(query);
      overViewListNotifier.value =
          TransactionDB.instance.transactionListNotifier.value;
    } else {
      overViewListNotifier.value = overViewListNotifier.value
          .where((element) => element.category.categoryName
              .toLowerCase()
              .contains(query.trim().toLowerCase()))
          .toList();
    }
  }
}
