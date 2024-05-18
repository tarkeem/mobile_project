import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/restaurants.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RestaurantsMap extends StatefulWidget {
  RestaurantsMap({super.key, required this.wantedrestaurants});
  static const String routeName = "RestaurantsMap";
  List<Restaurant> wantedrestaurants;

  @override
  State<RestaurantsMap> createState() => _RestaurantsMapState();
}

class _RestaurantsMapState extends State<RestaurantsMap> {
  List<Marker> markers() {
    List<Marker> markers = [];
    for (int i = 0; i < widget.wantedrestaurants.length; i++) {
      Marker marker = Marker(
          point: LatLng(widget.wantedrestaurants[i].coordinates.latitude,
              widget.wantedrestaurants[i].coordinates.longitude),
          width: 60,
          height: 60,
          alignment: Alignment.centerLeft,
          child: const Icon(
            Icons.location_pin,
            size: 60,
            color: Colors.red,
          ));
      markers.add(marker);
    }
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(
          initialCenter: LatLng(0, 0),
          initialZoom: 11,
          interactionOptions:
              InteractionOptions(flags: ~InteractiveFlag.doubleTapZoom)),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        MarkerLayer(markers: markers())
      ],
    );
  }
}
