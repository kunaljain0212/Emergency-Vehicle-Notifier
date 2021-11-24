import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class DirectionsService {
  final LatLng origin;
  final LatLng destination;
  final String placeIdOrigin;
  final String placeIdDestination;

  final String apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] as String;

  DirectionsService({
    required this.origin,
    required this.destination,
    required this.placeIdOrigin,
    required this.placeIdDestination,
  });

  Future<Map<String, dynamic>> getDirections() async {
    print('DIRECTIONS API: GET DIRECTIONS METHOD');
    final uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?destination=place_id:$placeIdDestination&origin=place_id:$placeIdOrigin&key=$apiKey');

    final response = await http.get(uri);
    final json = jsonDecode(response.body);

    final results = {
      'bounds_ne': json['routes'][0]['bounds']['northeast'],
      'bounds_sw': json['routes'][0]['bounds']['southwest'],
      'start_location': json['routes'][0]['legs'][0]['start_location'],
      'end_location': json['routes'][0]['legs'][0]['end_location'],
      'polyline': json['routes'][0]['overview_polyline']['points'],
      'polyline_decoded': PolylinePoints()
          .decodePolyline(json['routes'][0]['overview_polyline']['points']),
    };

    return results;
  }
}
