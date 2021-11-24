import 'dart:async';

import 'package:emergency_notifier/services/location_service.dart';
import 'package:emergency_notifier/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class CustomGoogleMaps extends StatefulWidget {
  final Set<Marker> markers;
  final Set<Polyline> polylines;
  final Completer<GoogleMapController> mapsController;
  const CustomGoogleMaps(
      {Key? key,
      required this.markers,
      required this.polylines,
      required this.mapsController})
      : super(key: key);

  @override
  _CustomGoogleMapsState createState() => _CustomGoogleMapsState();
}

class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LocationService>(
      builder: (context, model, child) {
        if (model.locationPosition == null) {
          return const Center(
            child: Loading(),
          );
        } else {
          return GoogleMap(
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            compassEnabled: false,
            buildingsEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: widget.markers,
            polylines: widget.polylines,
            initialCameraPosition: CameraPosition(
              target: model.locationPosition!,
              zoom: 20,
              tilt: 80,
              bearing: 30,
            ),
            onMapCreated: (GoogleMapController controller) {
              widget.mapsController.complete(controller);
            },
          );
        }
      },
    );
  }
}
