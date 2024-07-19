import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:responsivedashboard/ui/Screens/Stream/call.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
        child: ElevatedButton(
          onPressed: () async {
            try {
              await FirebaseFirestore.instance
                  .collection('call')
                  .doc('value')
                  .set({'id': true}, SetOptions(merge: true));
            } catch (e) {
              print(e);
            }

            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CallPage(callID: "1")));
          },
          child: Text("Join Call"),
        ),
      ),
    );
  }
}
