import 'package:flutter/material.dart';

class CategoryDisplay extends StatefulWidget {
  const CategoryDisplay({super.key});

  @override
  State<CategoryDisplay> createState() => _CategoryDisplayState();
}

class _CategoryDisplayState extends State<CategoryDisplay> {
  final List<String> _categoryItems = ['health', 'expense', 'salary'];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _categoryItems.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(_categoryItems[index]),
          onTap: () {},
        );
      },
    );
  }
}
