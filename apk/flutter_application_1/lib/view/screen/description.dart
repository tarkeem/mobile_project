import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/ors.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class DirectionPage extends StatefulWidget {
  final double targetLatitude;
  final double targetLongitude;

  const DirectionPage({
    Key? key,
    required this.targetLatitude,
    required this.targetLongitude,
  }) : super(key: key);

  @override
  State<DirectionPage> createState() => _DirectionPageState();
}

class _DirectionPageState extends State<DirectionPage> {
  List listOfPoints = [];
  List<LatLng> points = [];
  List<Marker> markers = [];

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  getscoordinate() async {
    var response = await http.get(getRouteUrl(
        "${markers[0].point.latitude},${markers[0].point.longitude}",
        "${markers[1].point.latitude},${markers[1].point.longitude}"));
    setState(() {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        listOfPoints = data['features'][0]['geometry']['coordinates'];
        points = listOfPoints
            .map((e) => LatLng(e[0].toDouble(), e[1].toDouble()))
            .toList();
      }
    });
  }

  Future<void> makemarkes() async {
    Position position = await determinePosition();
    markers = [
      Marker(
        point: LatLng(position.latitude, position.longitude),
        width: 80,
        height: 80,
        child: const Icon(
          Icons.my_location_rounded,
          size: 45,
          color: Colors.blue,
        ),
      ),
      Marker(
        point: LatLng(widget.targetLatitude, widget.targetLongitude),
        width: 80,
        height: 80,
        child: const Icon(
          Icons.location_pin,
          size: 45,
          color: Colors.red,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      FlutterMap(
        options: MapOptions(
            initialCenter:
                LatLng(widget.targetLatitude, widget.targetLongitude),
            initialZoom: 11,
            interactionOptions: const InteractionOptions(
                flags: ~InteractiveFlag.doubleTapZoom)),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
          MarkerLayer(markers: markers),
          PolylineLayer(
            polylines: [
              Polyline(
                points: points,
                strokeWidth: 4.0,
                color: Colors.blue,
                strokeCap: StrokeCap.round,
                strokeJoin: StrokeJoin.round,
              ),
            ],
          )
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              await makemarkes();
              await getscoordinate();
            },
            child: const Icon(Icons.add),
          ),
        ],
      )
    ]);
  }
}
