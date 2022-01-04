import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oxygenforcovid/auth/phone_auth.dart';
import 'package:oxygenforcovid/binding/authBinding.dart';
import 'package:oxygenforcovid/controllers/authController.dart';
import 'package:oxygenforcovid/screens/home.dart';
import 'package:oxygenforcovid/screens/index.dart';
import 'package:oxygenforcovid/screens/root.dart';
import 'package:oxygenforcovid/screens/search/searchOption.dart';
import 'package:oxygenforcovid/screens/viewPost.dart';
import 'package:oxygenforcovid/screens/viewrequest.dart';

import 'auth/phone_login.dart';

void main() {
  Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      title: 'Aid4Covid India',
      debugShowCheckedModeBanner: false,
      initialBinding: AuthBinding(),
      // initialRoute: '/index',
      defaultTransition: Transition.rightToLeft,
      getPages: [
        /* GetPage(
          name: '/index',
          page: () => IndexPage(),
        ), */
        GetPage(
          name: '/searchoptions',
          page: () => SearchOptions(),
        ),
        /*   GetPage(
          name: '/login',
          page: () => PhoneAuthBg(),
        ), */
        GetPage(name: '/viewpost', page: () => ViewPost()),
        GetPage(name: '/viewrequest', page: () => ViewRequest())
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Root(),
    );
  }
}
