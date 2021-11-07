import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency_notifier/models/user_model.dart';
import 'package:emergency_notifier/views/signup_login_view.dart';

class UserService {
  final String uid;
  UserService({required this.uid});

  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUser(String name, String email, String? photoUrl,
      String role, String? hospitalName, String? vehicleNumber) async {
    return await _userCollection.doc(uid).set({
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'role': role,
      'hospitalName': hospitalName,
      'vehicleNumber': vehicleNumber,
    });
  }

  //get user from document
  UserModel _userFromDocument(DocumentSnapshot doc) {
    Map<String, String> data = doc.data() as Map<String, String>;
    return UserModel(
      uid: uid,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      role: data['role'] ?? '',
      hospitalName: data['hospitalName'] ?? '',
      vehicleNumber: data['vehicleNumber'] ?? '',
    );
  }

  Stream<UserModel> get user {
    return _userCollection.doc(uid).snapshots().map(_userFromDocument);
  }
}
