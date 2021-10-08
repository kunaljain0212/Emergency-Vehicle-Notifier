import 'package:flutter/widgets.dart';

class UserModel extends ChangeNotifier {
  final String uid;
  final String name;
  final String email;
  final String photoUrl;
  final String phoneNumber;
  final String address;
  final String role;
  final String? vehicleNumber;
  final String? hospitalName;
  final String? identityProof;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.phoneNumber,
    required this.address,
    required this.role,
    this.vehicleNumber,
    this.hospitalName,
    this.identityProof,
  });

  Map<String, dynamic> get getUser {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber,
      'address': address,
      'role': role,
      'vehicleNumber': vehicleNumber,
      'hospitalName': hospitalName,
      'identityProof': identityProof,
    };
  }
}
