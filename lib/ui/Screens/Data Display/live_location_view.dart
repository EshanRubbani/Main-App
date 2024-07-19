// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsivedashboard/ui/constants.dart';
import 'package:velocity_x/velocity_x.dart';
import 'model.dart';
import 'package:latlong2/latlong.dart';

class LiveLocationTableScreen extends StatefulWidget {
  ValueNotifier<int> counter = ValueNotifier<int>(0);

  LiveLocationTableScreen({Key? key}) : super(key: key);

  @override
  State<LiveLocationTableScreen> createState() =>
      _LiveLocationTableScreenState(counter);
}

class _LiveLocationTableScreenState extends State<LiveLocationTableScreen> {
  final ValueNotifier<int> counter;
  _LiveLocationTableScreenState(this.counter);

  List<loc> locations = []; // Initialize empty locations list
  FirebaseFirestore db = FirebaseFirestore.instance;

  String name = "", longitude = "", latitude = "";

  void incrementCounter() {
    counter.value++;
  }

  @override
  void initState() {
    super.initState();
    final location = db.collection("location").doc('user1');
    _subscribeToLocationChanges(location);
  }

  void _subscribeToLocationChanges(DocumentReference d1) {
    d1.snapshots().listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        final liveLoc location = liveLoc.fromJson(data);
        setState(() {
          name = location.name.toString();
          longitude = location.longitude.toString();
          latitude = location.latitude.toString();
          counter.value++;
        });
      } else {
        print("No data found");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(longitude);
    print(latitude);

    double long = 0.0;
    double lat = 0.0;

    if (longitude.isNotEmpty && latitude.isNotEmpty) {
      try {
        long = double.parse(longitude);
        lat = double.parse(latitude);
      } on FormatException {
        print("Error parsing coordinates");
        // Perhaps display an error message to the user
      }
    }
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/dashboard')),
        ],
        title: const Text('Live Location',
            style: TextStyle(color: Vx.white),
            textScaler: TextScaler.linear(.70)),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: counter,
        builder: (context, value, child) {
          return FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(33.7518038, 72.7442559),
              initialZoom: 7,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(lat, long),
                    width: 80,
                    height: 80,
                    child: const Icon(
                      FontAwesomeIcons.mapMarkerAlt,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
