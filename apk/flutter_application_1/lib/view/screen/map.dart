import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class mapWid extends StatefulWidget {
  static const String route = 'map_controller_animated';


  mapWid({Key? key,required this.lat,required this.long}) : super(key: key);
  double lat;
  double long;

  @override
  mapWidState createState() {
    return mapWidState();
  }
}

class mapWidState extends State<mapWid>{


  late final MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
  final myLocation = LatLng(26.820553, 30.802498);
  final storeLocation = LatLng(widget.lat,widget.long);


    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
      
            Container(
              child: Expanded(
                child: FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                      center: LatLng(51.5, -0.09),
                      zoom: 5,
                      maxZoom: 40,
                      minZoom: 3),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    ),
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: [
                            myLocation,
                            storeLocation,
                          ],
                          strokeWidth: 2,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                    ),
                   
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
