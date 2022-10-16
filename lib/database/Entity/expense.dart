import 'package:floor/floor.dart';

import 'entity.dart';

@Entity(
  foreignKeys: [
    ForeignKey(
      childColumns: ['tripId'],
      parentColumns: ['tripId'],
      entity: Trip,
    ),
    ForeignKey(
      childColumns: ['expenseTypeId'],
      parentColumns: ['expenseTypeId'],
      entity: ExpenseType,
    ),
]) 
class Expense {
  @PrimaryKey(autoGenerate: true)
  final int expenseId;
  final int expenseTypeId;
  final double expenseAmount;
  final String expenseDate;
  final String expenseCurrency = '\$';
  final String expenseDescription = '';
  final int tripId;
  
  Expense(this.expenseId, this.expenseTypeId, this.expenseAmount, this.expenseDate, this.tripId);
}