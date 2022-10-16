
import 'package:floor/floor.dart';

@entity
class ExpenseType {
  @PrimaryKey(autoGenerate: true)
  int expenseTypeId = 0;
  String expenseTypeName = '';
}