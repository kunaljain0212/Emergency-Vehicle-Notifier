import 'package:flutter/material.dart';
import 'package:emergency_notifier/common/constants.dart';

class BottomBar extends StatefulWidget {
  final Function onPressed;
  final bool bottomIcons;
  final String text;
  final IconData icons;
  const BottomBar(
      {Key? key,
      required this.onPressed,
      required this.bottomIcons,
      required this.icons,
      required this.text})
      : super(key: key);
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => widget.onPressed(),
        child: widget.bottomIcons == true
            ? Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? primaryTextColorDarkTheme
                      : primaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 8),
                child: Row(
                  children: <Widget>[
                    Icon(
                      widget.icons,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? backgroundColorDarkTheme
                          : Colors.white,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      widget.text,
                      style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? backgroundColorDarkTheme
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ],
                ),
              )
            : Icon(widget.icons));
  }
}
