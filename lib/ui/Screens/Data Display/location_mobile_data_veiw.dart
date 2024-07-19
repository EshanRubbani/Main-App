// ignore_for_file: avoid_print

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:responsivedashboard/ui/constants.dart';
import 'package:responsivedashboard/ui/Screens/Data%20Display/maps.dart';
import 'package:velocity_x/velocity_x.dart';
import 'model.dart';

class LocationTableScreen extends StatefulWidget {
  const LocationTableScreen({Key? key}) : super(key: key);

  @override
  State<LocationTableScreen> createState() => _LocationTableScreenState();
}

class _LocationTableScreenState extends State<LocationTableScreen> {
  final ref = FirebaseDatabase.instance.ref('/Dummy/Location');

  List<loc> locations = []; // Initialize empty locations list

  @override
  void initState() {
    super.initState();
    fetchfromdb();
  }

  void fetchfromdb() async {
    DatabaseEvent event = await ref.once();
    DataSnapshot snapshot = event.snapshot;

    Map<dynamic, dynamic>? locationData =
        snapshot.value as Map<dynamic, dynamic>?;

    if (locationData != null) {
      List<loc> tmplocations = [];
      locationData.forEach(
        (key, value) async {
          loc location = loc.fromJson(value);
          tmplocations.add(location);
        },
      );
      setState(() {
        locations = tmplocations;
      });
    } else {
      print("No data found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/dashboard')),
        ],
        title: const Text('Location History',
            style: TextStyle(color: Vx.white),
            textScaler: TextScaler.linear(.70)),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Expanded(
        child: Container(
          color: defaultBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 16),
            child: Column(
              children: [
                Expanded(
                  child: locations.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const RangeMaintainingScrollPhysics(),
                            itemCount: locations.length,
                            itemBuilder: (context, index) {
                              loc location = locations[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 12.5, left: 5, right: 5),
                                child: Card(
                                  color:
                                      const Color.fromARGB(255, 190, 201, 231),
                                  child: SizedBox(
                                    height: 90,
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: ListTile(
                                        onTap: () {
                                          String long, lat;
                                          long = location.longitude;
                                          lat = location.latitude;
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => maps(
                                                      long: long,
                                                      lat: lat,
                                                    )),
                                          );
                                        },
                                        enabled: true,
                                        title: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                location.date ??
                                                    'No DateTime Information',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontStyle: FontStyle.italic,
                                                    color: Colors.grey[800]),
                                              ),
                                            ],
                                          ),
                                        ),
                                        subtitle: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0),
                                              child: Row(
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        const TextSpan(
                                                          text: "Longitude: ",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.black,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal),
                                                        ),
                                                        TextSpan(
                                                          text: location
                                                              .longitude,
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        const TextSpan(
                                                          text: "Latitude: ",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.black,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              location.latitude,
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          // child: ListView.builder(
                          //   itemCount: locations.length,
                          //   itemBuilder: (context, index) {
                          //     loc location = locations[index];
                          //     return ListTile(
                          //       title: Column(
                          //         children: [
                          //           Text(location.date ?? "No Date"),
                          //           Text('Longitude: ${location.longitude}'),
                          //           Text('Latitude: ${location.latitude}')
                          //         ],
                          //       ),
                          //     );
                          //   },
                          // ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
