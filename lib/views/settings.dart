import 'dart:io';

import 'package:emergency_notifier/models/auth_model.dart';
import 'package:emergency_notifier/models/user_model.dart';
import 'package:emergency_notifier/services/firebase_storage.dart';
import 'package:emergency_notifier/services/user_service.dart';
import 'package:emergency_notifier/widgets/profile.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:emergency_notifier/services/auth_service.dart';
import 'package:emergency_notifier/widgets/loading.dart';
import 'package:nanoid/non_secure.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthService _auth = AuthService();
  final Storage _storage = Storage();

  bool _isLoading = false;
  bool _isEditing = false;

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _signOut() {
    setState(() {
      _isLoading = !_isLoading;
    });
    _auth.signOut();
  }

  void _uploadProfilePicture() async {
    final selectedImage = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (selectedImage == null) {
      return;
    }

    final path = selectedImage.files.single.path;
    final name = nanoid();

    final url = await _storage.uploadProfilePicture(name, File(path!));
  }

  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthModel>(context);
    return _isLoading
        ? const Loading()
        : StreamBuilder<UserModel>(
            stream: UserService(uid: authModel.uid).user,
            builder: (context, snapshot) {
              UserModel? userData = snapshot.data;

              if (snapshot.hasData) {
                return Scaffold(
                  body: ProfileView(
                      _isEditing,
                      _isLoading,
                      _uploadProfilePicture,
                      _toggleEditing,
                      _signOut,
                      userData),
                );
              } else {
                return const Loading();
              }
            },
          );
  }
}
