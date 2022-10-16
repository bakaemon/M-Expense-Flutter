import 'package:flutter/material.dart';
import 'package:m_expense/StatefulWidgets/tripPageState.dart';
import 'package:m_expense/database/database.dart';

import 'database/database_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(
    database: await DatabaseHelper().build(),
  ));
}

class MyApp extends StatelessWidget {
  AppDatabase database;

  MyApp({super.key, required this.database});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TripListPage(db: database,));
  }
}
