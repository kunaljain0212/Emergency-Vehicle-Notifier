import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

// For storing our result
class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final String sessionToken;

  PlaceApiProvider(this.sessionToken);

  final String apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] as String;
  Future<List<Suggestion>> fetchSuggestions(String input) async {
    debugPrint('PLACES API: GET AUTOCOMPLETE SUGGESTIONS');
    final uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=geocode&key=$apiKey&sessiontoken=$sessionToken');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  //fetch lat and lng using placeId
  Future<Map<String, double>> fetchLatLng(String placeId) async {
    debugPrint('PLACES API: GET PLACE DETAILS USING PLACE ID');
    final uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=$apiKey');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        return {
          'lat': result['result']['geometry']['location']['lat'],
          'lng': result['result']['geometry']['location']['lng']
        };
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return {};
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
