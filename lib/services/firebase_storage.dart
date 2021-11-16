import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadProfilePicture(String path, File image) async {
    Reference ref = _storage.ref('/profileImages').child(path);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {
      print('Uploaded');
    });
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }
}
