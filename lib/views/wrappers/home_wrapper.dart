import 'package:flutter/material.dart';
import 'package:emergency_notifier/views/news.dart';
import 'package:emergency_notifier/views/profile.dart';
import 'package:emergency_notifier/widgets/bottom_nav.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

enum BottomIcons { home, account }

class _HomeViewState extends State<HomeView> {
  // final AuthService _auth = AuthService();

  BottomIcons bottomIcons = BottomIcons.home;

  // body: Center(
  //   child: ElevatedButton(
  //       onPressed: () {
  //         _auth.signOut();
  //       },
  //       child: const Text('Logout')),
  // ),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          bottomIcons == BottomIcons.home ? const NewsView() : Container(),
          bottomIcons == BottomIcons.account
              ? const ProfileView()
              : Container(),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              // color: Colors.white,

              padding: const EdgeInsets.only(left: 40, right: 40, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  BottomBar(
                    onPressed: () {
                      setState(() {
                        bottomIcons = BottomIcons.home;
                      });
                    },
                    bottomIcons: bottomIcons == BottomIcons.home ? true : false,
                    icons: Icons.home,
                    text: "Home",
                  ),
                  BottomBar(
                    onPressed: () {
                      setState(() {
                        bottomIcons = BottomIcons.account;
                      });
                    },
                    bottomIcons:
                        bottomIcons == BottomIcons.account ? true : false,
                    icons: Icons.person,
                    text: "Profile",
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
