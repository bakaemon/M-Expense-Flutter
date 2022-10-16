import 'dart:async';

import 'package:floor/floor.dart';
import 'package:m_expense/database/DAO/trip_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'Entity/entity.dart';

part 'database.g.dart'; 

@Database(version: 1, entities: [Trip])
abstract class AppDatabase extends FloorDatabase {
  TripDAO get tripDao;
}