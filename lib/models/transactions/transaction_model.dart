import 'package:hive/hive.dart';
import 'package:money_management/models/category/category_model.dart';
part 'transaction_model.g.dart';
@HiveType(typeId: 1)
class TransactionModel extends HiveObject {
  @HiveField(0)
  CategoryModel category;
  @HiveField(1)
  String description;
  @HiveField(2)
  String amount;
  @HiveField(3)
  String finanace;
  @HiveField(4)
  DateTime dateTime;
  @HiveField(5)
  String id;

  TransactionModel(
      {required this.description,
      required this.amount,
      required this.finanace,
      required this.dateTime,
      required this.id,
      required this.category});

  get datetime => null;

    

}
