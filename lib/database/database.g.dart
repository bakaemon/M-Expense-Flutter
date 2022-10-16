// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TripDAO? _tripDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Trip` (`tripId` INTEGER PRIMARY KEY AUTOINCREMENT, `tripName` TEXT NOT NULL, `startDate` TEXT NOT NULL, `tripDate` INTEGER NOT NULL, `tripBudget` REAL, `tripCurrency` TEXT, `tripIsFinished` INTEGER, `needAssessment` INTEGER NOT NULL, `tripDescription` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TripDAO get tripDao {
    return _tripDaoInstance ??= _$TripDAO(database, changeListener);
  }
}

class _$TripDAO extends TripDAO {
  _$TripDAO(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _tripInsertionAdapter = InsertionAdapter(
            database,
            'Trip',
            (Trip item) => <String, Object?>{
                  'tripId': item.tripId,
                  'tripName': item.tripName,
                  'startDate': item.startDate,
                  'tripDate': item.tripDate,
                  'tripBudget': item.tripBudget,
                  'tripCurrency': item.tripCurrency,
                  'tripIsFinished': item.tripIsFinished == null
                      ? null
                      : (item.tripIsFinished! ? 1 : 0),
                  'needAssessment': item.needAssessment ? 1 : 0,
                  'tripDescription': item.tripDescription
                }),
        _tripUpdateAdapter = UpdateAdapter(
            database,
            'Trip',
            ['tripId'],
            (Trip item) => <String, Object?>{
                  'tripId': item.tripId,
                  'tripName': item.tripName,
                  'startDate': item.startDate,
                  'tripDate': item.tripDate,
                  'tripBudget': item.tripBudget,
                  'tripCurrency': item.tripCurrency,
                  'tripIsFinished': item.tripIsFinished == null
                      ? null
                      : (item.tripIsFinished! ? 1 : 0),
                  'needAssessment': item.needAssessment ? 1 : 0,
                  'tripDescription': item.tripDescription
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Trip> _tripInsertionAdapter;

  final UpdateAdapter<Trip> _tripUpdateAdapter;

  @override
  Future<void> deleteOne(int tripId) async {
    await _queryAdapter.queryNoReturn('DELETE FROM Trip WHERE tripId = ?1',
        arguments: [tripId]);
  }

  @override
  Future<List<Trip>> findAllTrips() async {
    return _queryAdapter.queryList('SELECT * FROM Trip',
        mapper: (Map<String, Object?> row) => Trip(
            tripId: row['tripId'] as int?,
            tripName: row['tripName'] as String,
            startDate: row['startDate'] as String,
            tripDate: row['tripDate'] as int,
            tripBudget: row['tripBudget'] as double?,
            tripCurrency: row['tripCurrency'] as String?,
            needAssessment: (row['needAssessment'] as int) != 0,
            tripDescription: row['tripDescription'] as String?));
  }

  @override
  Future<Trip?> findTripById(int tripId) async {
    return _queryAdapter.query('SELECT * FROM Trip WHERE tripId = ?1',
        mapper: (Map<String, Object?> row) => Trip(
            tripId: row['tripId'] as int?,
            tripName: row['tripName'] as String,
            startDate: row['startDate'] as String,
            tripDate: row['tripDate'] as int,
            tripBudget: row['tripBudget'] as double?,
            tripCurrency: row['tripCurrency'] as String?,
            needAssessment: (row['needAssessment'] as int) != 0,
            tripDescription: row['tripDescription'] as String?),
        arguments: [tripId]);
  }

  @override
  Future<List<Trip>> findTripsLikeName(String tripName) async {
    return _queryAdapter.queryList('SELECT * FROM Trip WHERE tripName LIKE ?1',
        mapper: (Map<String, Object?> row) => Trip(
            tripId: row['tripId'] as int?,
            tripName: row['tripName'] as String,
            startDate: row['startDate'] as String,
            tripDate: row['tripDate'] as int,
            tripBudget: row['tripBudget'] as double?,
            tripCurrency: row['tripCurrency'] as String?,
            needAssessment: (row['needAssessment'] as int) != 0,
            tripDescription: row['tripDescription'] as String?),
        arguments: [tripName]);
  }

  @override
  Future<int?> countTrips() async {
    await _queryAdapter.queryNoReturn('SELECT COUNT(*) FROM Trip');
  }

  @override
  Future<void> insertOne(Trip trip) async {
    await _tripInsertionAdapter.insert(trip, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateOne(Trip trip) async {
    await _tripUpdateAdapter.update(trip, OnConflictStrategy.abort);
  }
}
