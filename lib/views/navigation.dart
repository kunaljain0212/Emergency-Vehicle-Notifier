import 'dart:async';
// import 'dart:io';

import 'package:emergency_notifier/common/constants.dart';
import 'package:emergency_notifier/services/directions_service.dart';
import 'package:emergency_notifier/services/location_service.dart';
import 'package:emergency_notifier/widgets/address_input.dart';
import 'package:emergency_notifier/widgets/address_search_bar.dart';
import 'package:emergency_notifier/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  Completer<GoogleMapController> mapsController = Completer();

  Set<Marker> markers = <Marker>{};
  Set<Polyline> polylines = <Polyline>{};

  LatLng? _origin;
  LatLng? _destination;
  String? _placeIdOrigin;
  String? _placeIdDestination;

  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<LocationService>(context, listen: false).initialization();
  }

  void _setMarker(LatLng point, String markerId, String info) {
    setState(() {
      markers.add(
        Marker(
          markerId: MarkerId(markerId),
          position: point,
          infoWindow: InfoWindow(
            title: info,
          ),
        ),
      );
    });
  }

  void _setPolyline(List<PointLatLng> points) async {
    final String polylineIdVal = const Uuid().v4();

    polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 4,
        color: primaryColor,
        points: points
            .map(
              (point) => LatLng(point.latitude, point.longitude),
            )
            .toList(),
      ),
    );
  }

  void _animateCamera(LatLng point) async {
    final GoogleMapController controller = await mapsController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: point,
          zoom: 20,
          tilt: 80,
          bearing: 30,
        ),
      ),
    );
  }

  Future<void> _goToPlace(
    Map<String, dynamic> boundsNe,
    Map<String, dynamic> boundsSw,
  ) async {
    final GoogleMapController controller = await mapsController.future;
    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
          northeast: LatLng(boundsNe['lat'], boundsNe['lng']),
        ),
        25,
      ),
    );
  }

  _fetchLocation(TextEditingController txcontroller, bool isOrigin) async {
    final sessionToken = const Uuid().v4();

    final Map<String, dynamic>? result = await showSearch(
      context: context,
      delegate: AddressSearch(
        sessionToken,
      ),
    );
    if (result != null) {
      setState(
        () {
          txcontroller.text = result['placeData'].description;
          if (isOrigin) {
            _origin = LatLng(result['latlng']['lat'], result['latlng']['lng']);
            _placeIdOrigin = result['placeData'].placeId;
          } else {
            _destination =
                LatLng(result['latlng']['lat'], result['latlng']['lng']);
            _placeIdDestination = result['placeData'].placeId;
          }
          _setMarker(
            LatLng(
              result['latlng']['lat'],
              result['latlng']['lng'],
            ),
            sessionToken,
            isOrigin ? 'Origin' : 'Destination',
          );
          _animateCamera(
            LatLng(
              result['latlng']['lat'],
              result['latlng']['lng'],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 2,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Row(
            children: [
              Column(
                children: [
                  AddressInput(
                    icon: Icons.gps_fixed,
                    controller: _originController,
                    hint: 'Enter your start location',
                    onTap: () => _fetchLocation(_originController, true),
                    isEnabled: true,
                  ),
                  AddressInput(
                    icon: Icons.place_sharp,
                    controller: _destinationController,
                    hint: 'Enter your end location',
                    onTap: () => _fetchLocation(_destinationController, false),
                    isEnabled: true,
                  ),
                ],
              ),
              IconButton(
                onPressed: () async {
                  final directions = await DirectionsService(
                    destination: _destination!,
                    origin: _origin!,
                    placeIdDestination: _placeIdDestination!,
                    placeIdOrigin: _placeIdOrigin!,
                  ).getDirections();

                  _goToPlace(
                    directions['bounds_ne'],
                    directions['bounds_sw'],
                  );

                  _setPolyline(directions['polyline_decoded']);
                },
                icon: const Icon(Icons.directions),
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
      body: googleMapsUI(),
    );
  }

  Widget googleMapsUI() {
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
            markers: markers,
            polylines: polylines,
            initialCameraPosition: CameraPosition(
              target: model.locationPosition!,
              zoom: 20,
              tilt: 80,
              bearing: 30,
            ),
            onMapCreated: (GoogleMapController controller) {
              mapsController.complete(controller);
            },
          );
        }
      },
    );
  }
}
