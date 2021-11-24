import 'package:google_maps_flutter/google_maps_flutter.dart';

enum EmergencyStatus {
  accepted,
  pending,
  handled,
}

class EmergencyModel {
  final String createdBy;
  final String? handledBy;
  final LatLng location;
  final String description;
  final double severity;
  final List<String> images;
  final EmergencyStatus status;
  final DateTime timestamp;

  EmergencyModel({
    required this.createdBy,
    this.handledBy,
    required this.location,
    required this.description,
    required this.severity,
    required this.images,
    required this.status,
    required this.timestamp,
  });
}
