import 'package:flutter/material.dart';
import 'package:m_expense/StatefulWidgets/editor.dart';
import 'package:m_expense/database/database.dart';
import 'package:m_expense/database/database_helper.dart';

import '../database/Entity/entity.dart';

class TripListPage extends StatefulWidget {
  late AppDatabase db;
  TripListPage({Key? key, required this.db}) : super(key: key);

  @override
  State<TripListPage> createState() => _TripListPageState();
}

class _TripListPageState extends State<TripListPage> {
  late Future<int?> fututeTripCount;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Trip List'),
          actions: getActions(),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Editor(tripId: 0, database: widget.db),
                    ),
                  ).then((value) => setState(() {}))
                }),
                // a future builder allow to take snipnet of data that
                // is waited from future
        body: FutureBuilder<List<Trip>>(
            future: widget.db.tripDao.findAllTrips(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isNotEmpty) {
                  return buildList(context, snapshot.data!);
                } else {
                  return const Center(child: Text("No trip available"));
                }
              } else if (snapshot.hasError) {
                return const Center(child: Text("Something went wrong!"));
              } else {
                // loading screen
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
  // this is method to build the list view as shown
  Widget buildList(BuildContext context, List<Trip> data) {
    List<ListTile> listTiles = data
        .map((Trip trip) => ListTile(
              title: Text(trip.tripName),
              subtitle: Text(trip.startDate),
              trailing: Text(trip.tripCurrency! + trip.tripBudget.toString()),
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Editor(tripId: trip.tripId!, database: widget.db),
                    ))
              },
            ))
        .toList();
    return ListView.separated(
        itemBuilder: (context, index) => listTiles[index],
        separatorBuilder: (context, index) => const Divider(),
        itemCount: listTiles.length);
  }

  List<Widget> getActions() {
    return [
      // IconButton(
      //     icon: const Icon(Icons.add),
      //     onPressed: () => {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => Editor(tripId: 0, database: widget.db),
      //             ),
      //           ).then((value) => setState(() {}))
      //         })
    ];
  }
}
