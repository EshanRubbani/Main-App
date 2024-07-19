import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:responsivedashboard/ui/constants.dart';
import 'package:responsivedashboard/ui/Screens/Data%20Display/model.dart';
import 'package:velocity_x/velocity_x.dart';

class MyContactsTableScreen extends StatefulWidget {
  const MyContactsTableScreen({Key? key}) : super(key: key);

  @override
  State<MyContactsTableScreen> createState() => _MyContactsTableScreenState();
}

class _MyContactsTableScreenState extends State<MyContactsTableScreen> {
  TextEditingController _searchController = TextEditingController();

  List<Contact> contacts = [];

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
        .child('Contacts')
        .once();
    //then(DataSnapshot snapshot) {
    DataSnapshot snapshot = event.snapshot;
    Map<dynamic, dynamic>? cntctData = snapshot.value as Map<dynamic, dynamic>?;
    print("Firebase Data: ${snapshot.value}");

    if (cntctData != null) {
      List<Contact> cntcts = [];
      String? previousContent;

      cntctData.forEach(
        (key, value) async {
          Contact contact = Contact.fromJson(value);

          cntcts.add(contact);
        },
      );
      setState(() {
        contacts = cntcts;
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
        title: Text('Contacts',
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
                  child: contacts.isEmpty
                      ? Center(
                          child: const CircularProgressIndicator(),
                        )
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const RangeMaintainingScrollPhysics(),
                            itemCount: contacts.length,
                            itemBuilder: (context, index) {
                              Contact contact = contacts[index];
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
                                          contact.name ?? 'Unknown Number',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[800]),
                                        ),
                                        subtitle: Text(
                                          contact.phNo,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey[800]),
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
