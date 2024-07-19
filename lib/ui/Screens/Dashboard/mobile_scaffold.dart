// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsivedashboard/ui/Screens/Data%20Display/model.dart';
import 'package:responsivedashboard/ui/constants.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DBMobileScaffold extends StatefulWidget {
  final userid = FirebaseAuth.instance.currentUser!;
  DBMobileScaffold({Key? key}) : super(key: key);

  @override
  State<DBMobileScaffold> createState() => _DBMobileScaffoldState();
}

class _DBMobileScaffoldState extends State<DBMobileScaffold> {
  final user = FirebaseAuth.instance.currentUser!;

  FirebaseFirestore db = FirebaseFirestore.instance;

  String mobileid = "", batteryp = "", wifistatus = "", datastatus = "";
  bool wifi = true, mobiledata = true;

  @override
  void initState() {
    super.initState();

    final mobid = db.collection("info").doc('Mobile ID');
    final batteryP = db.collection("info").doc('battery');
    final wifiStatus = db.collection("info").doc('mobile data');
    final dataStatus = db.collection("info").doc('wifi');
    _subscribeToMobileIdChanges(mobid, batteryP, wifiStatus, dataStatus);
  }

  void _subscribeToMobileIdChanges(DocumentReference d1, d2, d3, d4) {
    List<DocumentReference> dr = [d1, d2, d3, d4];
    for (final mobid in dr) {
      mobid.snapshots().listen((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          final data = snapshot.data() as Map<String, dynamic>;
          final mobId Id = mobId.fromJson(data);
          if (snapshot.id == "Mobile ID") {
            setState(() {
              mobileid = Id.id.toString();
              print(mobileid);
            });
          } else if (snapshot.id == "battery") {
            setState(() {
              batteryp = Id.id.toString();
              print(batteryp);
            });
          } else if (snapshot.id == "mobile data") {
            setState(() {
              datastatus = Id.id.toString();
              if (datastatus == "ON") {
                mobiledata = true;
              } else if (datastatus == "OFF") {
                mobiledata = false;
              }
              print(datastatus);
            });
          } else if (snapshot.id == "wifi") {
            setState(() {
              wifistatus = Id.id.toString();
              if (wifistatus == "ON") {
                wifi = true;
              } else if (wifistatus == "OFF") {
                wifi = false;
              }
              print(wifistatus);
            });
          }
        } else {
          print("No data found");
        }
      });
    }
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, '/newlogin');
  }

  @override
  Widget build(BuildContext context) {
    void onTileTap(int index) {
      // Handle tap logic based on the index
      switch (index) {
        case 0:
          Navigator.pushNamed(context, '/smstable');
          break;
        case 1:
          Navigator.pushNamed(context, '/callstable');
          break;
        case 2:
          Navigator.pushNamed(context, '/contactstable');
          break;
        case 3:
          Navigator.pushNamed(context, '/locationtable');
          break;
        case 4:
          Navigator.pushNamed(context, '/livelocationtable');
          break;
        case 5:
          Navigator.pushNamed(context, '/apptable');
          break;
        case 6:
          Navigator.pushNamed(context, '/watable');
          break;
        case 7:
          Navigator.pushNamed(context, '/msngrtable');
          break;
        case 8:
          Navigator.pushNamed(context, '/igtable');
          break;
        case 9:
          Navigator.pushNamed(context, '/sctable');
          break;
        case 10:
          Navigator.pushNamed(context, '/video');
          break;
        default:
        // Handle other cases
      }
    }

    final tileimages = [
      const Icon(Icons.sms),
      const Icon(Icons.phone),
      const Icon(Icons.contact_page_rounded),
      const Icon(Icons.location_on),
      const Icon(Icons.location_on),
      const Icon(Icons.apps),
      const Icon(FontAwesomeIcons.whatsapp),
      const Icon(FontAwesomeIcons.facebookMessenger),
      const Icon(FontAwesomeIcons.instagram),
      const Icon(Icons.snapchat),
      const Icon(Icons.live_tv_rounded),
      const Icon(Icons.file_copy_rounded)
    ];

    final titles = [
      'SMS',
      'CALLS',
      'CONTACTS',
      'LOCATION HISTORY',
      'LIVE LOCATION',
      'APPS',
      'WHATSAPP',
      'MESSENGER',
      'INSTAGRAM',
      'SNAPCHAT',
      'LIVE VEIWING',
      'FILE EXPLORER'
    ];
    return Scaffold(
      //drawer: myAppDrawer,
      drawer: MyDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
            color: Vx.white,
          )
        ],
        title:
            const Text(' T R A C K I F Y ', style: TextStyle(color: Vx.white)),
        centerTitle: true,
        surfaceTintColor: kPrimaryColor,
        backgroundColor: kPrimaryColor,
      ),
      body: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: kPrimaryColor,
        body: Column(
          children: [
            //User Information box
            Container(
              height: 200,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                shape: BoxShape.rectangle,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(7.5),
                          child: Row(children: [
                            Text(
                              "${user.email}",
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic),
                            ),
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(7.5),
                          child: Row(children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "Device ID: ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontStyle: FontStyle.normal),
                                  ),
                                  TextSpan(
                                    text: mobileid,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontStyle: FontStyle.normal),
                                  )
                                ],
                              ),
                            )
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(7.5),
                          child: Row(children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "Battery: ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontStyle: FontStyle.normal),
                                  ),
                                  TextSpan(
                                    text: "$batteryp%",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontStyle: FontStyle.normal),
                                  )
                                ],
                              ),
                            )
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(7.5),
                          child: Row(children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7.50),
                              child: Column(
                                children: [
                                  Icon(wifi ? Icons.wifi : Icons.wifi_off)
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7.50),
                              child: Column(
                                children: [
                                  Icon(mobiledata
                                      ? Icons.signal_cellular_4_bar
                                      : Icons.signal_cellular_0_bar)
                                ],
                              ),
                            )
                          ]),
                        ),
                      ],
                    ),
                  ),
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 17.5),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.20,
                          child: Icon(
                            FontAwesomeIcons.mobile,
                            size: MediaQuery.of(context).size.width * 0.25,
                            color: Colors.black,
                          )),
                    ),
                  ]),
                ],
              ),
            ),

            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(35)),
                child: Container(
                  color: Colors.grey[100],
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 12.5, left: 5.0, right: 5.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const RangeMaintainingScrollPhysics(),
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 12.5, left: 5, right: 5),
                          child: Card(
                            color: const Color.fromARGB(255, 190, 201, 231),
                            surfaceTintColor:
                                const Color.fromARGB(255, 190, 201, 231),
                            child: SizedBox(
                              height: 90,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: ListTile(
                                  enabled: true,
                                  onTap: () {
                                    onTileTap(index);
                                  },
                                  trailing: tileimages[index],
                                  title: Text(
                                    titles[index],
                                    textAlign: TextAlign.start,
                                    style: TextStyle(color: Colors.grey[800]),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
