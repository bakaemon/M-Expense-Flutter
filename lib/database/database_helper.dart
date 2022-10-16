import 'package:m_expense/database/database.dart';

class DatabaseHelper {
  final String databaseName = 'm_expense.db';
  Future<AppDatabase> build() async => await $FloorAppDatabase.databaseBuilder(databaseName).build();

}
