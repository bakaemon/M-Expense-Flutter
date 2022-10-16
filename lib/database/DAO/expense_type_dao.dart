import 'package:floor/floor.dart';
import 'package:m_expense/database/Entity/expense_type.dart';



@dao
abstract class ExpenseTypeDao{
  @insert
  Future<void> insertOne(ExpenseType expenseType);

  @update
  Future<void> updateOne(ExpenseType expenseType);

  @Query("SELECT * FROM expense_type")
  Future<List<ExpenseType>> getAllExpenseTypes();
  @Query("SELECT * FROM expense_type WHERE expenseTypeId = :expenseTypeId")
  Future<ExpenseType?> getExpenseTypeById(int expenseTypeId);

}