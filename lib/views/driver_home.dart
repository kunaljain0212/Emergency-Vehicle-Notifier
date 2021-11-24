import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency_notifier/common/constants.dart';
import 'package:emergency_notifier/models/auth_model.dart';
import 'package:emergency_notifier/services/emergency_service.dart';
import 'package:emergency_notifier/widgets/driver_home_card.dart';
import 'package:emergency_notifier/widgets/image_carousel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DriverHome extends StatefulWidget {
  const DriverHome({Key? key}) : super(key: key);

  @override
  _DriverHomeState createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  handleEmergency(AuthModel authModel, String id) async {
    await EmergencyService(uid: authModel.uid).acceptEmergency(id);
  }

  markHandledEmergency(AuthModel authModel, String id) async {
    await EmergencyService(uid: authModel.uid).markAsHandled(id);
  }

  @override
  Widget build(BuildContext context) {
    final AuthModel authModel = Provider.of<AuthModel>(context);
    return StreamBuilder<List<QueryDocumentSnapshot<Object?>>>(
      stream: EmergencyService(uid: authModel.uid).getAllEmergencies,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final emergencies = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: ListView.builder(
              itemCount: emergencies?.length,
              itemBuilder: (context, index) {
                final emergency = emergencies?[index];

                return DriverHomeCard(
                    emergency: emergency,
                    authModel: authModel,
                    handleEmergency: handleEmergency,
                    markHandledEmergency: markHandledEmergency);
              },
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
