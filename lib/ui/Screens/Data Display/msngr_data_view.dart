// ignore_for_file: use_super_parameters

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:responsivedashboard/ui/constants.dart';
import 'package:responsivedashboard/ui/Screens/Data%20Display/model.dart';
import 'package:velocity_x/velocity_x.dart';

class MyMSNGRTableScreen extends StatefulWidget {
  const MyMSNGRTableScreen({Key? key}) : super(key: key);

  @override
  State<MyMSNGRTableScreen> createState() => _MyMSNGRTableScreenState();
}

class _MyMSNGRTableScreenState extends State<MyMSNGRTableScreen> {
  List<msg> messages = [];

  final ref = FirebaseDatabase.instance.ref('/Dummy/SMS');

  @override
  void initState() {
    super.initState();
    fetchfromdb();
  }

  void fetchfromdb() async {
    DatabaseEvent event = await FirebaseDatabase.instance
        .ref()
        .child('Dummy')
        .child('Messenger')
        .once();
    //then(DataSnapshot snapshot) {
    DataSnapshot snapshot = event.snapshot;
    Map<dynamic, dynamic>? smsData = snapshot.value as Map<dynamic, dynamic>?;
    print("Firebase Data: ${snapshot.value}");

    if (smsData != null) {
      List<msg> msgs = [];
      String? previousContent;

      smsData.forEach(
        (key, value) async {
          msg message = msg.fromJson(value);

          if (previousContent == null || previousContent != message.content) {
            msgs.add(message);
            previousContent = message.content; // Update previous content
          }
          await Future.delayed(const Duration(milliseconds: 50));
          //msgs.add(message);
        },
      );
      setState(() {
        messages = msgs;
      });
    } else {
      print("No data found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/dashboard');
              }),
        ],
        title: const Text('Messenger Notification History',
            style: TextStyle(color: Vx.white),
            textScaler: TextScaler.linear(.70)),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Expanded(
        child: Container(
          color: defaultBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 16),
            child: Column(
              children: [
                Expanded(
                  child: messages.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const RangeMaintainingScrollPhysics(),
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              msg message = messages[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 12.5, left: 5, right: 5),
                                child: Card(
                                  color:
                                      const Color.fromARGB(255, 190, 201, 231),
                                  child: SizedBox(
                                    height: 90,
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: ListTile(
                                        enabled: true,
                                        title: Text(
                                          message.title,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[800]),
                                        ),
                                        subtitle: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  message.content ??
                                                      'No Content',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.grey[800]),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  message.date,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Colors.grey[800]),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
