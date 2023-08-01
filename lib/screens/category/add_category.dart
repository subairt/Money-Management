import 'package:flutter/material.dart';
import 'package:money_management/db/category_db.dart';
import 'package:money_management/db/income_expence.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/widgets/bottomnavigation.dart';
import 'package:money_management/widgets/buttons.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  DateTime date = DateTime.now();
  String? selectedCategoryImage;
  final _formkey = GlobalKey<FormState>();
  final _nameOfCategory = TextEditingController();

  final List<String> _item = ['food', 'transportation', 'health', 'education',];

  @override
  void initState() {
    super.initState();

    _nameOfCategory.addListener(() {
      setState(() {});
    });
  }

  Widget devider = const SizedBox(
    height: 50,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
          child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          backgroundContainer(context),
          SingleChildScrollView(child: Container(child: mainContainer()))
        ],
      )),
    );
  }

  Container mainContainer() {
    return Container(
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(255, 150, 149, 149),
          spreadRadius: 1,
          blurRadius: 10,
          offset: Offset(10, 14),
        ),
      ], borderRadius: BorderRadius.circular(20), color: Colors.white),
      height: 550,
      width: 340,
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            devider,
            name(),
            devider,
            image(),
            devider,
            const Spacer(),
            GestureDetector(
              onTap: () {
                if (_formkey.currentState!.validate()) {
                  addCategory();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const BottomNavBar()));
                }
              },
              child: button(120, 50, 'Save', 18),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Padding image() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
          width: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2, color: Colors.grey)),
          child: DropdownButtonFormField<String>(
            value: selectedCategoryImage,
            items: _item
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Row(
                        children: [
                          // ignore: sized_box_for_whitespace
                          Container(
                            width: 40,
                            child: Image.asset(
                              'assets/images/$e.png',
                              height: 30,
                              width: 30,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ))
                .toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Select Image';
              } else {
                return null;
              }
            },
            hint: const Text(
              'Images',
              style: TextStyle(color: Colors.grey),
            ),
            dropdownColor: Colors.white,
            isExpanded: true,
            onChanged: ((value) {
              setState(() {
                selectedCategoryImage = value!;
              });
            }),
          ),
        ));
  }

  Padding name() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: 300,
        child: TextFormField(
          controller: _nameOfCategory,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter Category Name';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'Enter Category Name',
            labelStyle: const TextStyle(fontSize: 17, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 2, color: Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 2, color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(width: 2, color: Colors.green)),
          ),
        ),
      ),
    );
  }

  Column backgroundContainer(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(199, 12, 12, 0.88),
                Color.fromRGBO(255, 67, 40, 0.88),
                Color.fromRGBO(255, 152, 100, 0.88)
              ]),
              //color: Colors.amber,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(208),
                  bottomRight: Radius.circular(0))),
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
                        )),
                    const SizedBox(
                      width: 80,
                    ),
                    const Text(
                      'Add Category',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  addCategory() {
    var category = CategoryModel(
      categoryName: _nameOfCategory.text,
      categoryImage: selectedCategoryImage!,
      categoryid: DateTime.now().microsecondsSinceEpoch.toString(),
    );
    CategoryDB().insertCategory(category);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Category Added Successfully',
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.amber,
      ),
    );
    categoryDB.add(category);
  }
}
