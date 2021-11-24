import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency_notifier/common/constants.dart';
import 'package:emergency_notifier/models/auth_model.dart';
import 'package:emergency_notifier/services/emergency_service.dart';
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

                return Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      children: [
                        Text(
                          '${(emergency?.data() as dynamic)['address']}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        const SizedBox(height: defaultPadding / 2),
                        Chip(
                          label: Text(
                            'Severity: ${(emergency?.data() as dynamic)['severity']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          backgroundColor: primaryColor,
                          elevation: 0,
                          shadowColor: Colors.grey[60],
                          padding: const EdgeInsets.all(defaultPadding / 2),
                        ),
                        const SizedBox(height: defaultPadding / 2),
                        Text(
                          '${(emergency?.data() as dynamic)['description']}',
                          style: Theme.of(context).textTheme.caption,
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: defaultPadding),
                        ImageCarousel(
                          imageList: (emergency?.data() as dynamic)['images'],
                        ),
                        const SizedBox(height: defaultPadding),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: (emergency?.data()
                                        as dynamic)['handledBy'] !=
                                    authModel.uid
                                ? () {
                                    handleEmergency(authModel, emergency!.id);
                                  }
                                : (emergency?.data() as dynamic)['status'] ==
                                        'handled'
                                    ? null
                                    : () {
                                        markHandledEmergency(
                                            authModel, emergency!.id);
                                      },
                            child: (emergency?.data()
                                        as dynamic)['handledBy'] ==
                                    authModel.uid
                                ? (emergency?.data() as dynamic)['status'] ==
                                        'handled'
                                    ? const Text('Handled')
                                    : const Text('Mark as Handled')
                                : const Text('Accept Emergency'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
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
