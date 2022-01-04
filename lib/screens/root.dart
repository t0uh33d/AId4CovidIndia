import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:oxygenforcovid/controllers/authController.dart';
import 'package:oxygenforcovid/screens/home.dart';
import 'package:oxygenforcovid/screens/index.dart';
import 'package:oxygenforcovid/shared/loader.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User data = snapshot.data;
          if (data == null) {
            return IndexPage();
          } else {
            return Home();
          }
        } else {
          return IndexPage();
        }
      },
    );
  }
}
