// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:responsivedashboard/ui/constants.dart';
import 'package:velocity_x/velocity_x.dart';

class maps extends StatefulWidget {
  const maps({super.key, required this.long, required this.lat});

  final String long, lat;

  @override
  State<maps> createState() => _mapsState();
}

class _mapsState extends State<maps> {
  @override
  Widget build(BuildContext context) {
    double longitude, latitude;
    longitude = double.parse(widget.long);
    latitude = double.parse(widget.lat);
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
      body: FlutterMap(
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
                point: LatLng(latitude, longitude),
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
      ),
    );
  }
}
