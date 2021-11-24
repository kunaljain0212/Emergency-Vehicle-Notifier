import 'package:emergency_notifier/models/auth_model.dart';
import 'package:emergency_notifier/models/user_model.dart';
import 'package:emergency_notifier/services/user_service.dart';
import 'package:emergency_notifier/views/driver_home.dart';
import 'package:emergency_notifier/views/navigation.dart';
import 'package:flutter/material.dart';
import 'package:emergency_notifier/views/home.dart';
import 'package:emergency_notifier/views/settings.dart';
import 'package:emergency_notifier/widgets/bottom_nav.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

enum BottomIcons { home, settings, navigation }

class _HomeViewState extends State<HomeView> {
  // final AuthService _auth = AuthService();

  BottomIcons bottomIcons = BottomIcons.home;

  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthModel>(context);
    return Scaffold(
      body: StreamBuilder<UserModel>(
        stream: UserService(uid: authModel.uid).user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userModel = snapshot.data;
            return Stack(
              children: <Widget>[
                bottomIcons == BottomIcons.home
                    ? userModel?.role == 'user'
                        ? const Home()
                        : const DriverHome()
                    : Container(),
                bottomIcons == BottomIcons.settings
                    ? const Settings()
                    : Container(),
                bottomIcons == BottomIcons.navigation
                    ? const Navigation()
                    : Container(),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(
                        left: 40, right: 40, bottom: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        BottomBar(
                          onPressed: () {
                            setState(() {
                              bottomIcons = BottomIcons.navigation;
                            });
                          },
                          bottomIcons: bottomIcons == BottomIcons.navigation
                              ? true
                              : false,
                          icons: Icons.navigation,
                          text: "Navigation",
                        ),
                        BottomBar(
                          onPressed: () {
                            setState(() {
                              bottomIcons = BottomIcons.home;
                            });
                          },
                          bottomIcons:
                              bottomIcons == BottomIcons.home ? true : false,
                          icons: Icons.home,
                          text: "Home",
                        ),
                        BottomBar(
                          onPressed: () {
                            setState(() {
                              bottomIcons = BottomIcons.settings;
                            });
                          },
                          bottomIcons: bottomIcons == BottomIcons.settings
                              ? true
                              : false,
                          icons: Icons.settings,
                          text: "Settings",
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
