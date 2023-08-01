import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/widgets/uppercase.dart';

import '../../db/category_db.dart';

class SlidableCategory extends StatelessWidget {
  const SlidableCategory({Key? key, required this.category}) : super(key: key);

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        // SlidableAction(
        //   onPressed: ((context) {}),
        //   icon: Icons.edit,
        //   foregroundColor: const Color(0xFF2E49FB),
        // ),
        SlidableAction(
  onPressed: ((context) {
    showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          content:  const Text('Do you want to Delete?'),
          actions: [
            TextButton(
              onPressed: () async {
                await CategoryDB().deleteCategory(category.categoryid);
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'NO',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      }),
    );
  }),
  icon: Icons.delete,
  foregroundColor: Colors.red,
),

      ]),
      child: Card(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 244, 240, 228),
            radius: 50,
            child: Image.asset(
              'assets/images/${category.categoryImage}.png',
              height: 30,
              width: 20,
            ),
          ),
          title: Text(category.categoryName.capitalize()),
        ),
      ),
    );
  }
}
