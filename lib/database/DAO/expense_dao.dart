import 'package:floor/floor.dart';

import '../Entity/expense.dart';

@dao
abstract class ExpenseDAO {
  @insert
  Future<void> insertOne(Expense expense);
  @update
  Future<void> updateOne(Expense expense);
  @Query('SELECT * FROM Expense')
  Future<List<Expense>> findAllExpenses();

  @Query('SELECT * FROM Expense WHERE expenseId = :expenseId')
  Future<Expense?> findExpenseById(int expenseId);

  @Query('DELETE FROM Expense WHERE expenseId = :expenseId')
  Future<void> deleteOne(int expenseId);

  @Query("SELECT COUNT(expenseId) FROM expense WHERE tripId = :tripId")
  Future<int?> getRowsCount(int tripId);
}
