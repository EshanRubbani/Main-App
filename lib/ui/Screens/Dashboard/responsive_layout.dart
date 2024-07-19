import 'package:flutter/material.dart';

class DBResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget desktopBody;

  DBResponsiveLayout({
    required this.mobileBody,
    required this.desktopBody,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 500) {
          print("in mobile");
          return mobileBody;
        } else {
          print("in desktop");
          return desktopBody;
        }
      },
    );
  }
}
