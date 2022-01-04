import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_db_web_unofficial/firebasedbwebunofficial.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oxygenforcovid/screens/home.dart';
import 'package:oxygenforcovid/screens/posts/postPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  // FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> firebaseuser = Rxn<User>();

  String get useruid => firebaseuser.value?.uid;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    firebaseuser.bindStream(auth.authStateChanges());
  }

  var _googleSignIn = GoogleSignIn();
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> verificationCheck() async {
    await auth.currentUser.reload();
    return auth.currentUser.emailVerified;
  }

  void sendVerificationLink() async {
    try {
      await auth.currentUser.sendEmailVerification();
      Get.snackbar('Email sent!',
          'An Email with verification link has been sent to your account',
          colorText: Colors.white, backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.message.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  void signInEmailPass({String email, String password}) async {
    try {
      UserCredential signIn = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("uid", signIn.user.uid);
      Get.offAll(Home());
      //  Get.back();
    } catch (e) {
      Get.snackbar('Couldn\'t sign in!', e.message.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void registerEmail({String email, String password}) async {
    try {
      var user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("uid", user.user.uid);
      Get.offAll(Home());
    } catch (e) {
      Get.snackbar('Couldn\'t register!', e.message.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  void signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await auth.signInWithCredential(credential).then((userCredentials) async {
        var _user = userCredentials;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("uid", _user.user.uid);
        Get.offAll(Home());
      });
    } catch (e) {
      print(e.message.toString());
      print(e.toString());
      Get.snackbar('Error occured', 'Error signing in with your Google account',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

//sign in with phone number
  Future<void> signIn(
      String smsCode, ConfirmationResult confirmationResult) async {
    try {
      UserCredential userCredential = await confirmationResult.confirm(smsCode);
      await FirebaseDatabaseWeb.instance
          .reference()
          .child("users")
          .child(userCredential.user.uid)
          .update({"phoneNo": "${userCredential.user.phoneNumber}"});
      if (useruid != null) {
        Get.offAll(Home());
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void resetPasssword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.snackbar(
          'Sucess!', 'A pasword reset link has been sent to your email',
          colorText: Colors.white, backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.message.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      Get.snackbar('Error signing out', e.toString());
    }
  }
}
