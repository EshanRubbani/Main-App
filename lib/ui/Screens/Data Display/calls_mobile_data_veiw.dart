import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:responsivedashboard/ui/constants.dart';
import 'package:responsivedashboard/ui/Screens/Dashboard/mobile_scaffold.dart';
import 'package:responsivedashboard/ui/Screens/Data%20Display/model.dart';
import 'package:velocity_x/velocity_x.dart';

class MyTableScreen extends StatefulWidget {
  const MyTableScreen({Key? key}) : super(key: key);

  @override
  State<MyTableScreen> createState() => _MyTableScreenState();
}

class _MyTableScreenState extends State<MyTableScreen> {
  TextEditingController _searchController = TextEditingController();

  List<msg> calls = [];
  final ref = FirebaseDatabase.instance.ref('/Dummy/Calls');

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
        .child('Calls')
        .once();
    //then(DataSnapshot snapshot) {
    DataSnapshot snapshot = event.snapshot;
    Map<dynamic, dynamic>? callData = snapshot.value as Map<dynamic, dynamic>?;
    print("Firebase Data: ${snapshot.value}");

    if (callData != null) {
      List<msg> tmpcalls = [];
      callData.forEach(
        (key, value) {
          msg call = msg.fromJson(value);
          tmpcalls.add(call);
        },
      );
      setState(() {
        calls = tmpcalls;
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
        title: Text('Calls History',
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
                  child: calls.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const RangeMaintainingScrollPhysics(),
                            itemCount: calls.length,
                            itemBuilder: (context, index) {
                              msg call = calls[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 12.5, left: 5, right: 5),
                                child: Card(
                                  color:
                                      const Color.fromARGB(255, 190, 201, 231),
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
                                        title: Text(
                                          call.title,
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
                                                  call.content ?? 'No Content',
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
                                                  call.date,
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
