import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'package:responsivedashboard/ui/constants.dart';
import 'package:responsivedashboard/ui/Screens/Dashboard/mobile_scaffold.dart';
import 'package:responsivedashboard/ui/Screens/Data%20Display/model.dart';
import 'package:velocity_x/velocity_x.dart';

class AppTableScreen extends StatefulWidget {
  const AppTableScreen({Key? key}) : super(key: key);

  @override
  State<AppTableScreen> createState() => _AppTableScreenState();
}

class _AppTableScreenState extends State<AppTableScreen> {
  TextEditingController _searchController = TextEditingController();

  List<String> apps = [];
  final ref = FirebaseDatabase.instance.ref('/Dummy/Apps');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchfromdb();
  }

  void fetchfromdb() async {
    DatabaseEvent event = await FirebaseDatabase.instance
        .reference()
        .child('Dummy')
        .child('Apps')
        .orderByKey()
        .once();
    //then(DataSnapshot snapshot) {
    DataSnapshot snapshot = event.snapshot;
    Map<dynamic, dynamic>? appData = snapshot.value as Map<dynamic, dynamic>?;
    print("Firebase Data: ${snapshot.value}");

    if (appData != null) {
      List<String> tmpapps = [];
      appData.forEach(
        (key, value) {
          String appName = value;
          print(appName);
          tmpapps.add(appName);
        },
      );
      setState(() {
        apps = tmpapps;
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
        title: Text('Installed Apps',
            style: TextStyle(color: Vx.white),
            textScaler: TextScaler.linear(.70)),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Expanded(
        child: Container(
          color: defaultBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right: 16, bottom: 7.5),
            child: Column(
              children: [
                Expanded(
                  child: apps.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const RangeMaintainingScrollPhysics(),
                            itemCount: apps.length,
                            itemBuilder: (context, index) {
                              String app = apps[index];
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
                                          app,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[800]),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          // child: ListView.builder(
                          //   itemCount: apps.length,
                          //   itemBuilder: (context, index) {
                          //     String app = apps[index];
                          //     return ListTile(
                          //       title: Text(app),
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

abstract class _MyTableSearchDelegate
    extends SearchDelegate<Map<String, String>> {
  final List<Map<String, String>> _tableData;

  _MyTableSearchDelegate(this._tableData);

  @override
  @override
  Widget buildResult(BuildContext context, Map<String, String> result) {
    return Text(result['Name']!);
  }
}
