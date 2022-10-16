import 'package:floor/floor.dart';

@entity
class Trip {
  @PrimaryKey(autoGenerate: true)
  int? tripId;

  String tripName;
  String startDate;
  int tripDate;
  double? tripBudget = 0.0;
  String? tripCurrency = '\$';
  bool? tripIsFinished = false;
  bool needAssessment;
  String? tripDescription = '';

  Trip({this.tripId,
    required this.tripName,
      required this.startDate,
      required this.tripDate,
      this.tripBudget,
      this.tripCurrency,
      required this.needAssessment,
      this.tripDescription
      });
    String get getTripName => tripName;
    String get getStartDate => startDate;
    int get getTripDate => tripDate;
    double? get getTripBudget => tripBudget;
    String? get getTripCurrency => tripCurrency;
    bool? get getTripIsFinished => tripIsFinished;
    bool get getNeedAssessment => needAssessment;
    String? get getTripDescription => tripDescription;
    int? get getTripId => tripId;
    set setTripName(String tripName) => this.tripName = tripName;
    set setStartDate(String startDate) => this.startDate = startDate;
    set setTripDate(int tripDate) => this.tripDate = tripDate;
    set setTripBudget(double? tripBudget) => this.tripBudget = tripBudget;
    set setTripCurrency(String? tripCurrency) => this.tripCurrency = tripCurrency;
    set setTripIsFinished(bool? tripIsFinished) => this.tripIsFinished = tripIsFinished;
    set setNeedAssessment(bool needAssessment) => this.needAssessment = needAssessment;
    
}

