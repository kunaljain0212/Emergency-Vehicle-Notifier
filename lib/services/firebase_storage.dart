import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class Storage {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //Uploading Profile Image to storage bucket
  Future<String> uploadProfilePicture(String path, File image) async {
    Reference ref = _storage.ref('/profileImages').child(path);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(
      () {
        debugPrint('Uploaded');
      },
    );
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

  ///Uploading Raise Emergency Images to storage bucket
  Future<String> uploadEmergencyImage(String path, File image) async {
    Reference ref = _storage.ref('/emergencyImages').child(path);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(
      () {
        debugPrint('Uploaded');
      },
    );
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }
}
