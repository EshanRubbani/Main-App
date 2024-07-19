import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsivedashboard/ui/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Install extends StatelessWidget {
  const Install({Key? key}) : super(key: key); // Added const

  @override
  Widget build(BuildContext context) {
    const String url =
        "https://drive.google.com/file/d/1ht6AspJvo6a8Fnz15XsN_BjJv0dCr1f8/view?usp=drive_link";

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Align content to the top
        children: [
          Padding(
            // Added padding for better spacing
            padding: const EdgeInsets.only(top: 160.0),
            child: Image.asset("assets/install.gif"),
          ),
          Expanded(
            // Take up available space for column content
            child: Column(
              // Center instructions
              children: [
                const Text(
                  // const for unchanging text
                  "Install and Configure Private App",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: primaryColor),
                ),
                const SizedBox(
                  height: 60,
                ),
                Text(
                  "Download and Install the Private App \n Launch App and Login \n Provide Necessary Permissions \n and you are good to go.",
                  style: TextStyle(fontSize: 19.00),
                  textAlign: TextAlign.center, // Center the text
                ),
                const SizedBox(
                  height: 30,
                ),
                Spacer(),
                Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 15, left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _openExternalLink(url);
                            },
                            child: Text("Download App"),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(primaryColor),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/dashboard');
                            },
                            child: Text("Done!"),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(primaryColor),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openExternalLink(String url) async {
    // Made function async
    final encodedUrl = Uri.encodeFull(url);
    final uri = Uri.parse(encodedUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // Handle the error if the link cannot be launched
      print('Could not launch $uri');
    }
  }
}
