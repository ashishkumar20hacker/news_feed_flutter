import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:news_feed/Utilities/globals.dart';
import 'package:news_feed/screens/dashboard_screen.dart';
import 'package:news_feed/screens/onboarding_screen.dart';
import 'Utilities/globals.dart' as globals;
import 'Utilities/pref.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  await Pref.initializeHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: globals.white, useMaterial3: false),
      home: const MyRoot(),
    );
  }
}

class MyRoot extends StatefulWidget {
  const MyRoot({super.key});

  @override
  State<MyRoot> createState() => _MyRootState();
}

class _MyRootState extends State<MyRoot> {
  bool isFirstRun = true;
  @override
  void initState() {
    super.initState();
    checkIsFirstRun();
  }

  Future<void> checkIsFirstRun() async {
    isFirstRun = Pref.getBool(globals.isFirstRun, true);
    setState(() {}); // Update UI after retrieving value from Hive

    if (isFirstRun) {
      // Start a timer of two seconds
      Timer(const Duration(seconds: 2), () {
        // Navigate to the next screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );

        // Set isFirstRun to false in Hive
        Pref.setBool(globals.isFirstRun, false);
      });
    } else {
      Timer(const Duration(seconds: 2), () {
        // Navigate to the next screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Pref.savedNewsList.assignAll(Pref.getArticleList(savedNewsListKey));
    Pref.searchesList.assignAll(Pref.getSearchesList(searchedListKey));

    return Scaffold(
      backgroundColor: white,
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(0, 4)),
              ]),
              child: Image.asset(
                '${assetImagePath}logo.png',
                width: 120,
                height: 120,
              ),
            ),
            const Spacer(flex: 1),
            const Image(
                image: AssetImage('${globals.assetGifPath}splash_gif.gif'),
                width: 200,
                height: 200,
                fit: BoxFit.contain)
          ],
        ),
      ),
    );
  }
}
