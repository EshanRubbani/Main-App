// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

const kPrimaryColor = Color.fromARGB(255, 156, 173, 206); //Color(0xFF1565C0);
const kPrimaryLightColor = Colors.grey; //Color(0xFFF1E6FF);
const kPrimaryMediumColor = Color(0xFF1976D2);
const primaryColor = Color.fromRGBO(115, 87, 164, 1);
const double defaultPadding = 16.0;

var defaultBackgroundColor = Colors.grey[25];

var myAppBar = AppBar(
  iconTheme: IconThemeData(color: Vx.white),
  backgroundColor: kPrimaryColor,
  surfaceTintColor: Colors.transparent,
  title:
      Text('T R A C K I F Y', style: TextStyle(color: defaultBackgroundColor)),
  centerTitle: true,
);
var drawerTextColor = TextStyle(
  color: Colors.grey[600],
);
var tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void navigateToPage(BuildContext context, String pageName) {
    Navigator.pop(context); // Close the drawer
    Navigator.pushNamed(context, pageName); // Navigate to the desired page
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * .90,
      shadowColor: Colors.white,
      surfaceTintColor: Colors.white,
      backgroundColor: kPrimaryLightColor,
      elevation: 16.0,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.favorite,
                  size: 60,
                  color: kPrimaryColor,
                ),
              ),
              Padding(
                padding: tilePadding,
                child: ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/dashboard');
                  },
                  leading: Icon(Icons.home),
                  title: Text(
                    'D A S H B O A R D',
                    style: drawerTextColor,
                  ),
                ),
              ),
              Padding(
                padding: tilePadding,
                child: ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/smstable');
                  },
                  leading: Icon(Icons.sms),
                  title: Text(
                    'S M S',
                    style: drawerTextColor,
                  ),
                ),
              ),
              Padding(
                padding: tilePadding,
                child: ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/callstable');
                  },
                  leading: Icon(Icons.phone),
                  title: Text(
                    'C A L L S',
                    style: drawerTextColor,
                  ),
                ),
              ),
              Padding(
                padding: tilePadding,
                child: ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/contactstable');
                  },
                  leading: Icon(Icons.contact_page_rounded),
                  title: Text(
                    'C O N T A C T S',
                    style: drawerTextColor,
                  ),
                ),
              ),
              Padding(
                padding: tilePadding,
                child: ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/locationtable');
                  },
                  leading: Icon(Icons.location_on),
                  title: Text(
                    'L O C A T I O N   H I S T O R Y',
                    style: drawerTextColor,
                  ),
                ),
              ),
              Padding(
                padding: tilePadding,
                child: ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/locationtable');
                  },
                  leading: Icon(Icons.location_on),
                  title: Text(
                    'L I V E   L O C A T I O N',
                    style: drawerTextColor,
                  ),
                ),
              ),
              Padding(
                padding: tilePadding,
                child: ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/apptable');
                  },
                  leading: Icon(Icons.apps),
                  title: Text(
                    'A P P S',
                    style: drawerTextColor,
                  ),
                ),
              ),
              Padding(
                padding: tilePadding,
                child: ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/watable');
                  },
                  leading: Icon(FontAwesomeIcons.whatsapp),
                  title: Text(
                    'W H A T S A P P',
                    style: drawerTextColor,
                  ),
                ),
              ),
              Padding(
                padding: tilePadding,
                child: ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/msngrtable');
                  },
                  leading: Icon(FontAwesomeIcons.facebookMessenger),
                  title: Text(
                    'M E S S E N G E R',
                    style: drawerTextColor,
                  ),
                ),
              ),
              Padding(
                padding: tilePadding,
                child: ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/igtable');
                  },
                  leading: Icon(FontAwesomeIcons.instagram),
                  title: Text(
                    'I N S T A G R A M',
                    style: drawerTextColor,
                  ),
                ),
              ),
              Padding(
                padding: tilePadding,
                child: ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/sctable');
                  },
                  leading: Icon(FontAwesomeIcons.snapchat),
                  title: Text(
                    'S N A P C H A T',
                    style: drawerTextColor,
                  ),
                ),
              ),
              Padding(
                padding: tilePadding,
                child: ListTile(
                  onTap: () {},
                  leading: Icon(Icons.live_tv_rounded),
                  title: Text(
                    'L I V E  V E I W I N G',
                    style: drawerTextColor,
                  ),
                ),
              ),
              Padding(
                padding: tilePadding,
                child: ListTile(
                  onTap: () {},
                  leading: Icon(Icons.file_copy_rounded),
                  title: Text(
                    'F I L E  E X P L O R E R',
                    style: drawerTextColor,
                  ),
                ),
              ),
              Padding(
                padding: tilePadding,
                child: ListTile(
                  onTap: () {},
                  leading: Icon(Icons.settings),
                  title: Text(
                    'S E T T I N G S',
                    style: drawerTextColor,
                  ),
                ),
              ),
              Padding(
                padding: tilePadding,
                child: ListTile(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushNamed(context, '/newlogin');
                  },
                  leading: Icon(Icons.login_outlined),
                  title: Text(
                    'L O G O U T',
                    style: drawerTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
