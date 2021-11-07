import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:emergency_notifier/common/constants.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitChasingDots(
          color: Theme.of(context).brightness == Brightness.dark
              ? primaryTextColorDarkTheme
              : primaryColor,
          size: 50.0,
        ),
      ),
    );
  }
}
