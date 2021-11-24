import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency_notifier/common/constants.dart';
import 'package:emergency_notifier/models/auth_model.dart';
import 'package:emergency_notifier/services/emergency_service.dart';
import 'package:emergency_notifier/services/firebase_storage.dart';
import 'package:emergency_notifier/services/location_service.dart';
import 'package:emergency_notifier/widgets/image_carousel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:nanoid/non_secure.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Storage _storage = Storage();

  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  double _currentSliderValue = 0;
  List<String> _files = [];
  bool _isLoading = false;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Provider.of<LocationService>(context, listen: false).initialization();
  }

  Future<void> _uploadEmergencyImage() async {
    setState(() {
      _isLoading = true;
    });
    List<String> uploadedFiles = [];

    final FilePickerResult? selectedImages =
        await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (selectedImages == null) {
      return;
    }
    if (selectedImages.files.length > 3) {
      return;
    }
    for (var file in selectedImages.files) {
      final path = file.path;
      final name = nanoid();
      final url = await _storage.uploadEmergencyImage(
        name,
        File(path!),
      );
      uploadedFiles.add(url);
    }

    setState(
      () {
        _files = uploadedFiles;
        _isLoading = false;
      },
    );
  }

  Future<void> _raiseEmergency(String uid) async {
    await EmergencyService(uid: uid).addEmergency(
      descriptionController.text,
      _files,
      _currentSliderValue,
      'pending',
    );
    setState(
      () {
        _files = [];
        _currentSliderValue = 0;
        descriptionController.text = '';
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthModel>(context);
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          Expanded(
            child: Form(
              child: ListView(
                key: formKey,
                children: [
                  TextFormField(
                    controller: locationController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: 'Current Location',
                      hintText: 'Current Location',
                      enabled: false,
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  TextFormField(
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      hintText: 'Enter a short description',
                      labelText: 'Description',
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Text(
                    'Mark the severity of emergency',
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                  Slider(
                    value: _currentSliderValue,
                    min: 0,
                    max: 5,
                    divisions: 5,
                    label: _currentSliderValue.round().toString(),
                    activeColor: primaryColor,
                    inactiveColor: primaryColor.withOpacity(0.3),
                    onChanged: (double value) {
                      setState(
                        () {
                          _currentSliderValue = value;
                        },
                      );
                    },
                  ),
                  const SizedBox(height: defaultPadding),
                  ImageCarousel(
                    isLoading: _isLoading,
                    imageList: _files,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        await _uploadEmergencyImage();
                      },
                      child: const Text('Add Images'),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        await _raiseEmergency(authModel.uid);
                      },
                      child: const Text('Raise Emergency'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
