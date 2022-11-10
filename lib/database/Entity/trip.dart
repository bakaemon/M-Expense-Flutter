import 'package:floor/floor.dart';

@entity
class Trip {
  @PrimaryKey(autoGenerate: true)
  int? tripId;

  String tripName;
  String tripDestination;
  String startDate;
  int tripDate;
  double? tripBudget = 0.0;
  String? tripCurrency = '\$';
  bool? tripIsFinished = false;
  bool needAssessment;
  String? tripDescription = '';

  Trip(
      {this.tripId,
      required this.tripName,
      required this.tripDestination,
      required this.startDate,
      required this.tripDate,
      this.tripBudget,
      this.tripCurrency,
      required this.needAssessment,
      this.tripDescription});
}
