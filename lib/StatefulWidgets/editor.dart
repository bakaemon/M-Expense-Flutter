import 'package:flutter/material.dart';
import 'package:m_expense/database/Entity/entity.dart';
import 'package:m_expense/database/database.dart';
import 'package:m_expense/utils/currency.dart';

import '../utils/widgets.dart';
import 'tripPageState.dart';

class Editor extends StatefulWidget {
  int tripId;
  String title = "Add new trip";
  AppDatabase database;
  Editor({Key? key, required this.tripId, required this.database})
      : super(key: key) {
    if (tripId > 0) {
      title = "Edit trip";
    }
  }

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  var formKey = GlobalKey<FormState>();
  var tripNameController = TextEditingController();
  var tripBudgetController = TextEditingController();
  var startDateController = TextEditingController();
  var endDateController = TextEditingController();
  var tripDescriptionController = TextEditingController();
  String currency = "\$";
  bool isRiskAssessment = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: getActions(),
        ),
        body: SingleChildScrollView(
          child: createForm(),
        ));
  }

  @override
  void initState() {
    super.initState();

    if (widget.tripId > 0) {
      widget.database.tripDao.findTripById(widget.tripId).then((trip) {
        setState(() {
          if (trip != null) {
            tripNameController.text = trip.tripName;
            tripBudgetController.text = trip.tripBudget.toString();
            currency = trip.tripCurrency!;
            startDateController.text = trip.startDate;
            endDateController.text = DateTime.parse(trip.getStartDate)
                .add(Duration(days: trip.tripDate))
                .toString()
                .split(" ")[0];
            tripDescriptionController.text = trip.tripDescription ?? "";
            isRiskAssessment = trip.needAssessment;
          }
        });
      });
    }
  }

  Widget createForm() {
    return Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            WidgetTools.createTextField(
              tripNameController,
              "Trip Name",
              hintText: "Enter trip name",
              errorText: "Trip name is required",
            ),
            WidgetTools.createTextField(tripBudgetController, "Budget",
                inputType: TextInputType.number, hintText: "Enter budget"),
            WidgetTools.createDropDownMap(
                "Choose currency",
                Currency.currencySymbol,
                onChanged: (selected) => {setState(() => { currency = selected! })},
                defaultValue: currency),
            WidgetTools.createDatePickerField(
                "Start Date", startDateController, context,
                errorText: "Start date is required",
                initialDate: DateTime.now()),
            WidgetTools.createDatePickerField(
              "End Date",
              endDateController,
              context,
              initialDate: DateTime.now().add(const Duration(days: 7)),
              errorText: "End date is required",
            ),
            WidgetTools.createSwitch(
                label: "Risk Assessment",
                value: isRiskAssessment,
                onChanged: (value) =>
                    {setState(() => isRiskAssessment = value)}),
            WidgetTools.createTextField(
                tripDescriptionController, "Description",
                hintText: "Enter description"),
            widget.tripId == 0
                ? WidgetTools.createButton(
                    label: "Add",
                    onPress: () => submit(createBook),
                    formKey: formKey)
                : WidgetTools.createButton(
                    label: "Save",
                    onPress: () => submit(editBook),
                    formKey: formKey)
          ],
        ));
  }

  void submit(Future<bool> Function() callback) async {
    if (await callback()) {
      // Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => TripListPage(db: widget.database)),
          (route) => false);
    }
  }

  Future<bool> createBook() async {
    try {
      var tripName = tripNameController.text;
      var tripBudget = double.parse(tripBudgetController.text);
      var tripCurrency = currency;
      var startDate = startDateController.text;
      var endDate = endDateController.text;
      // date diff between start and end date
      int tripDate =
          DateTime.parse(endDate).difference(DateTime.parse(startDate)).inDays;
      var tripDescription = tripDescriptionController.text.isEmpty
          ? ""
          : tripDescriptionController.text;
      await widget.database.tripDao
          .insertOne(Trip(
              tripName: tripName,
              tripBudget: tripBudget,
              tripCurrency: tripCurrency,
              startDate: startDate,
              tripDate: tripDate,
              tripDescription: tripDescription,
              needAssessment: isRiskAssessment))
          .then((value) =>
              WidgetTools.showSnackBar(context, "Trip added successfully"));

      return true;
    } on Exception catch (e, s) {
      WidgetTools.showAlertDialog(context, "Error", e.toString());
      return false;
    }
  }

  Future<bool> editBook() async {
    try {
      await widget.database.tripDao
          .findTripById(widget.tripId)
          .then((value) => {
                if (value == null) throw Exception("Trip not found"),
                value.tripName = tripNameController.text,
                value.tripBudget = double.parse(tripBudgetController.text),
                value.tripCurrency = currency,
                value.startDate = startDateController.text,
                value.tripDate = DateTime.parse(endDateController.text)
                    .difference(DateTime.parse(startDateController.text))
                    .inDays,
                value.tripDescription = tripDescriptionController.text,
                value.needAssessment = isRiskAssessment,
                widget.database.tripDao.updateOne(value).then((value) => {
                      WidgetTools.showSnackBar(context, "Trip updated"),
                    })
              });
      return true;
    } on Exception catch (e, s) {
      WidgetTools.showAlertDialog(context, "Error", s.toString());
      return false;
    }
  }

  void deleteTrip() {
    widget.database.tripDao.deleteOne(widget.tripId).then((value) => {
          WidgetTools.showSnackBar(context, "Trip deleted"),
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => TripListPage(db: widget.database)),
              (route) => false)
        });
  }

  List<Widget> getActions() {
    List<Widget> actions = [];
    if (widget.tripId > 0) {
      actions.add(IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => {
          WidgetTools.showConfirmDialog(
              context, "Confirm deletion?", "Are you sure to delete this trip?",
              onOk: () => deleteTrip())
        },
      ));
    }
    return actions;
  }
}
