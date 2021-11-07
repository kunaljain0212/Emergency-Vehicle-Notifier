class UserModel {
  final String uid;
  final String name;
  final String email;
  final String photoUrl;
  final String role;
  final String? hospitalName;
  final String? vehicleNumber;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.role,
    this.hospitalName,
    this.vehicleNumber,
  });
}
