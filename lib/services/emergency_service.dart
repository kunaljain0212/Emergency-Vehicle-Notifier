import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency_notifier/services/geocode_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class EmergencyService {
  final String uid;
  EmergencyService({required this.uid});

  final CollectionReference _emergencyCollection =
      FirebaseFirestore.instance.collection('emergencies');
  //raise emergency
  Future<DocumentReference> addEmergency(
    String description,
    List<String> images,
    double severity,
    String status,
  ) async {
    final location = await Location().getLocation();
    final address = await GeocodeService().fetchAddress(
      LatLng(location.latitude ?? 0.0, location.longitude ?? 0.0),
    );
    return await _emergencyCollection.add(
      {
        'description': description,
        'images': images,
        'location':
            GeoPoint(location.latitude ?? 0.0, location.longitude ?? 0.0),
        'address': address,
        'createdBy': uid,
        'handledBy': '',
        'severity': severity,
        'status': status,
        'timestamp': FieldValue.serverTimestamp(),
      },
    );
  }

  //accept emergency
  Future<void> acceptEmergency(String emergencyId) async {
    final emergency = await _emergencyCollection.doc(emergencyId).get();
    if (emergency.exists) {
      await _emergencyCollection.doc(emergencyId).update(
        {
          'status': 'accepted',
          'handledBy': uid,
        },
      );
    }
  }

  //mark as handled
  Future<void> markAsHandled(String emergencyId) async {
    final emergency = await _emergencyCollection.doc(emergencyId).get();
    if (emergency.exists) {
      await _emergencyCollection.doc(emergencyId).update(
        {
          'status': 'handled',
        },
      );
    }
  }

  //get all emergencies
  Stream<List<QueryDocumentSnapshot<Object?>>> get getAllEmergencies {
    return _emergencyCollection
        .snapshots()
        .map((emergencies) => emergencies.docs);
  }

  //get emergency list of a user
  Stream<List<QueryDocumentSnapshot<Object?>>> get getUserEmergencies {
    return _emergencyCollection
        .where('createdBy', isEqualTo: uid)
        .snapshots()
        .map((event) => event.docs);
  }
}
