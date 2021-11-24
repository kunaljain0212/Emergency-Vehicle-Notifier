import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency_notifier/common/constants.dart';
import 'package:emergency_notifier/models/auth_model.dart';
import 'package:emergency_notifier/widgets/image_carousel.dart';
import 'package:flutter/material.dart';

class DriverHomeCard extends StatefulWidget {
  final QueryDocumentSnapshot<Object?>? emergency;
  final AuthModel authModel;
  final Function handleEmergency;
  final Function markHandledEmergency;
  const DriverHomeCard(
      {Key? key,
      required this.emergency,
      required this.authModel,
      required this.handleEmergency,
      required this.markHandledEmergency})
      : super(key: key);

  @override
  _DriverHomeCardState createState() => _DriverHomeCardState();
}

class _DriverHomeCardState extends State<DriverHomeCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Text(
              '${(widget.emergency?.data() as dynamic)['address']}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: defaultPadding / 2),
            Chip(
              label: Text(
                'Severity: ${(widget.emergency?.data() as dynamic)['severity']}',
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
              '${(widget.emergency?.data() as dynamic)['description']}',
              style: Theme.of(context).textTheme.caption,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: defaultPadding),
            ImageCarousel(
              imageList: (widget.emergency?.data() as dynamic)['images'],
            ),
            const SizedBox(height: defaultPadding),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (widget.emergency?.data() as dynamic)['handledBy'] !=
                        widget.authModel.uid
                    ? () {
                        widget.handleEmergency(
                            widget.authModel, widget.emergency!.id);
                      }
                    : (widget.emergency?.data() as dynamic)['status'] ==
                            'handled'
                        ? null
                        : () {
                            widget.markHandledEmergency(
                                widget.authModel, widget.emergency!.id);
                          },
                child: (widget.emergency?.data() as dynamic)['handledBy'] ==
                        widget.authModel.uid
                    ? (widget.emergency?.data() as dynamic)['status'] ==
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
  }
}
