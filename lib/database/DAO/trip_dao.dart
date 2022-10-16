import 'package:floor/floor.dart';

import '../Entity/entity.dart';

@dao
abstract class TripDAO {
  
  @insert
  Future<void> insertOne(Trip trip);
  @update
  Future<void> updateOne(Trip trip);
  @Query('DELETE FROM Trip WHERE tripId = :tripId')
  Future<void> deleteOne(int tripId);
  @Query('SELECT * FROM Trip')
  Future<List<Trip>> findAllTrips();
  @Query('SELECT * FROM Trip WHERE tripId = :tripId')
  Future<Trip?> findTripById(int tripId);
  @Query('SELECT * FROM Trip WHERE tripName LIKE :tripName')
  Future<List<Trip>> findTripsLikeName(String tripName);
  @Query('SELECT COUNT(*) FROM Trip')
  Future<int?> countTrips();
}
