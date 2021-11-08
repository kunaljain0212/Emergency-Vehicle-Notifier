import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency_notifier/models/user_model.dart';

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
    return UserModel(
      uid: uid,
      name: (doc.data() as dynamic)['name'] ?? '',
      email: (doc.data() as dynamic)['email'] ?? '',
      photoUrl: (doc.data() as dynamic)['photoUrl'] ?? '',
      role: (doc.data() as dynamic)['role'] ?? '',
      hospitalName: (doc.data() as dynamic)['hospitalName'] ?? '',
      vehicleNumber: (doc.data() as dynamic)['vehicleNumber'] ?? '',
    );
  }

  Stream<UserModel> get user {
    return _userCollection.doc(uid).snapshots().map(_userFromDocument);
  }
}
