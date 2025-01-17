import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:responsivedashboard/ui/Screens/Welcome/welcome_screen.dart';
import 'package:responsivedashboard/ui/Screens/Dashboard/mobile_scaffold.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user logged in
          if (snapshot.hasData) {
            return DBMobileScaffold();
          }
          //user not logged in
          else {
            return WelcomeScreen();
          }
        },
      ),
    );
  }
}
