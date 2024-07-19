import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:responsivedashboard/ui/constants.dart';
import 'package:responsivedashboard/ui/Screens/Data%20Display/model.dart';
import 'package:velocity_x/velocity_x.dart';

class MyWATableScreen extends StatefulWidget {
  const MyWATableScreen({Key? key}) : super(key: key);

  @override
  State<MyWATableScreen> createState() => _MyWATableScreenState();
}

class _MyWATableScreenState extends State<MyWATableScreen> {
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
        .child('Whatsapp')
        .once();
    DataSnapshot snapshot = event.snapshot;
    Map<dynamic, dynamic>? smsData = snapshot.value as Map<dynamic, dynamic>?;

    if (smsData != null) {
      List<msg> msgs = [];

      smsData.forEach(
        (key, value) async {
          msg message = msg.fromJson(value);
          msgs.add(message);
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
      drawer: MyDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/dashboard');
              }),
        ],
        title: const Text(
          'Whatsapp Notification History',
          style: TextStyle(color: Vx.white),
          textScaler: TextScaler.linear(.70),
        ),
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

                          // child: ListView.builder(
                          //   itemCount: messages.length,
                          //   itemBuilder: (context, index) {
                          //     msg message = messages[index];
                          //     return ListTile(
                          //       title: Column(
                          //         children: [
                          //           Text(message.title),
                          //           Text(message.content ?? 'No Content'),
                          //           Text(message.date)
                          //         ],
                          //       ),
                          //     );
                          //   },
                          // ),
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
