import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationService extends ChangeNotifier {
  late Location _location;
  Location get location => _location;

  LatLng? _locationPosition;
  LatLng? get locationPosition => _locationPosition;

  bool isLocationServiceEnabled = true;

  LocationService() {
    _location = Location();
  }

  initialization() async {
    await getUserLocation();
  }

  getUserLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged.listen((LocationData cLocation) {
      _locationPosition =
          LatLng(cLocation.latitude ?? 0.0, cLocation.longitude ?? 0.0);
      print(_locationPosition);
      notifyListeners();
    });
  }
}
