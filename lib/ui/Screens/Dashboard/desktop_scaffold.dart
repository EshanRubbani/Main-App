import 'package:flutter/material.dart';

import 'package:responsivedashboard/ui/constants.dart';
import 'package:responsivedashboard/ui/components/my_textfield.dart';
import 'package:responsivedashboard/ui/components/my_buttom.dart';

class DBDesktopScaffold extends StatefulWidget {
  const DBDesktopScaffold({Key? key}) : super(key: key);

  @override
  State<DBDesktopScaffold> createState() => _DBDesktopScaffoldState();
}

class _DBDesktopScaffoldState extends State<DBDesktopScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: myAppBar,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // open drawer
            MyDrawer(),

            // first half of page
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  // first 4 boxes in grid
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: GridView.builder(
                          itemCount: 12,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5),
                          itemBuilder: (context, index) {
                            return;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
