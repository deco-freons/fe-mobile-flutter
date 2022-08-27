import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowLocation extends StatefulWidget {
  static const routeName = "/show-location";

  final double lat;
  final double long;
  final String address;

  const ShowLocation(
      {Key? key, required this.lat, required this.long, required this.address})
      : super(key: key);

  @override
  State<ShowLocation> createState() => _ShowLocationState();
}

class _ShowLocationState extends State<ShowLocation> {
  late CameraPosition initialCameraPos;
  final googleApiKey = dotenv.env['googleApiKey'];
  Set<Marker> markers = {};
  final Completer<GoogleMapController> _gmapcontroller = Completer();

  @override
  void initState() {
    super.initState();
    initialCameraPos =
        CameraPosition(target: LatLng(widget.lat, widget.long), zoom: 17);
    markers.add(
      Marker(
        markerId: const MarkerId("1"),
        position: LatLng(widget.lat, widget.long),
        infoWindow: InfoWindow(title: widget.address),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: initialCameraPos,
        markers: markers,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _gmapcontroller.complete(controller);
        },
      ),
    );
  }
}
