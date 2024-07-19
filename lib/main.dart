// ignore_for_file: unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:responsivedashboard/firebase_options.dart';
import 'package:responsivedashboard/ui/Screens/Welcome/welcome_screen.dart';
import 'package:responsivedashboard/ui/constants.dart';
import 'package:responsivedashboard/ui/Screens/Data%20Display/live_location_view.dart';
import 'package:responsivedashboard/ui/Screens/Data%20Display/sc_data_view.dart';
import 'package:responsivedashboard/ui/Screens/Login/login_screen.dart';
import 'package:responsivedashboard/ui/Screens/Dashboard/desktop_scaffold.dart';
import 'package:responsivedashboard/ui/Screens/Dashboard/mobile_scaffold.dart';
import 'package:responsivedashboard/ui/Screens/Dashboard/responsive_layout.dart';
import 'package:responsivedashboard/ui/Screens/Stream/home.dart';
import 'package:responsivedashboard/ui/components/auth_page.dart';
import 'package:responsivedashboard/ui/Screens/Data%20Display/calls_mobile_data_veiw.dart';
import 'package:responsivedashboard/ui/Screens/Data%20Display/sms_mobile_data_veiw.dart';
import 'package:responsivedashboard/ui/Screens/Data%20Display/apps_data_view.dart';
import 'package:responsivedashboard/ui/Screens/Data%20Display/wa_data_view.dart';
import 'package:responsivedashboard/ui/Screens/Data%20Display/msngr_data_view.dart';
import 'package:responsivedashboard/ui/Screens/Data%20Display/ig_data_view.dart';
import 'package:responsivedashboard/ui/Screens/Data%20Display/contacts_data_view.dart';
import 'package:responsivedashboard/ui/install.dart';
import 'package:responsivedashboard/ui/onboarding/onboarding_veiw.dart';
import 'ui/Screens/Data Display/location_mobile_data_veiw.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool("onboarding") ?? false;
  runApp(const MyApp(onboarding: false));
}

class MyApp extends StatelessWidget {
  final bool onboarding;
  const MyApp({super.key, this.onboarding = false});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            actionsIconTheme: IconThemeData(color: Colors.blue),
            elevation: 0,
          ),
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              foregroundColor: Colors.white,
              backgroundColor: kPrimaryColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: kPrimaryLightColor,
            iconColor: kPrimaryColor,
            prefixIconColor: kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
      home: onboarding ? const AuthPage() : const OnboardingView(),
      routes: {
        '/dashboard': (context) => DBResponsiveLayout(
            mobileBody: DBMobileScaffold(),
            desktopBody: const DBDesktopScaffold()),
        '/smstable': (context) => const MySMSTableScreen(),
        '/callstable': (context) => const MyTableScreen(),
        '/locationtable': (context) => const LocationTableScreen(),
        '/livelocationtable': (context) => LiveLocationTableScreen(),
        '/apptable': (context) => const AppTableScreen(),
        '/newlogin': (context) => const LoginScreen(),
        '/watable': (context) => const MyWATableScreen(),
        '/msngrtable': (context) => const MyMSNGRTableScreen(),
        '/sctable': (context) => const MySCTableScreen(),
        '/igtable': (context) => const MyIGTableScreen(),
        '/contactstable': (context) => const MyContactsTableScreen(),
        '/video': (context) => const MyHome(),
        '/install': (context) => const Install(),
      },
    );
  }
}
