import 'dart:async';
// import 'dart:io';

import 'package:emergency_notifier/services/location_service.dart';
import 'package:emergency_notifier/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  // LatLng sourceLatlng = const LatLng(26.233221, 78.207407);
  // LatLng destinationLatlng = const LatLng(26.2333, 78.2073);

  // final Completer<GoogleMapController> _controller = Completer();

  // Set<Marker> markers = {};
  // List<LatLng> polylineCoordinates = [];
  // late PolylinePoints polylinePoints;

  // late StreamSubscription<LocationData> locationSubscription;

  // late LocationData currentLocation;
  // late LocationData destinationLocation;
  // late Location location;

  @override
  void initState() {
    super.initState();
    Provider.of<LocationService>(context, listen: false).initialization();
    // location = Location();
    // polylinePoints = PolylinePoints();

    // location.onLocationChanged.listen((cLocation) {
    //   currentLocation = cLocation;
    // });
  }

  // void setInitalLocation() async {
  //   currentLocation = await location.getLocation();
  //   sourceLatlng = LatLng(
  //       currentLocation.latitude ?? 0.0, currentLocation.longitude ?? 0.0);
  //   destinationLatlng =
  //       LatLng(destinationLatlng.latitude, destinationLatlng.longitude);
  // }

  // void showLocationPins() {
  //   markers.add(Marker(
  //     markerId: const MarkerId('currentPosition'),
  //     position: LatLng(
  //         currentLocation.latitude ?? 0.0, currentLocation.longitude ?? 0.0),
  //     icon: BitmapDescriptor.defaultMarker,
  //     infoWindow: const InfoWindow(
  //       title: 'Source',
  //       snippet: 'This is the source location',
  //     ),
  //   ));
  // }

  // void updatePinsOnMap() async {
  //   CameraPosition cameraPosition = CameraPosition(
  //     target: LatLng(
  //         currentLocation.latitude ?? 0.0, currentLocation.longitude ?? 0.0),
  //     zoom: 20,
  //     tilt: 80,
  //     bearing: 30,
  //   );

  // final GoogleMapController controller = await _controller.future;

  // controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

  //   setState(() {
  //     markers.clear();
  //     markers.add(Marker(
  //       markerId: const MarkerId('currentPosition'),
  //       position: LatLng(
  //           currentLocation.latitude ?? 0.0, currentLocation.longitude ?? 0.0),
  //       icon: BitmapDescriptor.defaultMarker,
  //       infoWindow: const InfoWindow(
  //         title: 'Source',
  //         snippet: 'This is the source location',
  //       ),
  //     ));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // CameraPosition initalCameraPosition =
    //     CameraPosition(target: sourceLatlng, zoom: 20, tilt: 80, bearing: 30);
    return Scaffold(
      body: googleMapUI(),
    );
  }

  Widget googleMapUI() {
    return Consumer<LocationService>(builder: (context, model, child) {
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
          initialCameraPosition: CameraPosition(
            target: model.locationPosition!,
            zoom: 20,
            tilt: 80,
            bearing: 30,
          ),
          // markers: markers,
          onMapCreated: (GoogleMapController controller) {
            // _controller.complete(controller);
            // setInitalLocation();
            // showLocationPins();
            // updatePinsOnMap();
          },
        );
      }
    });
  }
}
