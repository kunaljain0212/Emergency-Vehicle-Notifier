import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeocodeService {
  final String apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] as String;

  //fetch address using lat and lng
  Future<String> fetchAddress(LatLng latlng) async {
    print('GEOCODING API: FETCH ADDRESS USING LAT LNG');
    final uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${latlng.latitude},${latlng.longitude}&key=$apiKey');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        return result['results'][0]['formatted_address'];
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return '';
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
