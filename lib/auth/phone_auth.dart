import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:oxygenforcovid/controllers/authController.dart';
import 'package:oxygenforcovid/shared/theme.dart';

class OtpPhone extends StatefulWidget {
  String phoneNo;
  ConfirmationResult confirmationResult;
  OtpPhone({this.phoneNo, this.confirmationResult});

  @override
  _OtpPhoneState createState() => _OtpPhoneState();
}

class _OtpPhoneState extends State<OtpPhone> {
  String smssent;
  String errorText = '';
  bool loading = false;
  bool continuebutton = false;

  Timer _timer;
  int _start = 10;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            _timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  final _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var authController = Get.find<AuthController>();
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: loading
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              height: 60,
              child: Center(child: CircularProgressIndicator()))
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              height: 60,
              child: FlatButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    await authController.signIn(
                        smssent, widget.confirmationResult);
                  }
                },
                child: Text('Confirm'),
                disabledColor: Colors.grey,
                disabledTextColor: Colors.grey[350],
                color: HexColor('#1454ab'),
                textColor: Colors.white,
              ),
            ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Image.asset('lib/assets/business-and-finance.png',
                      width: 80, height: 80),
                ),
                Text(
                  'Enter your confirmation code',
                  textScaleFactor: 1.0,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    'We have sent a 6-digit code to +91${widget.phoneNo}',
                    maxLines: 2,
                    textScaleFactor: 1.1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[800]),
                  ),
                ),
                TextFormField(
                    maxLength: 6,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Enter confirmation code'),
                      LengthRangeValidator(
                          min: 6, max: 6, errorText: 'Enter 6 digit code')
                    ]),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.length > 5) {
                        this.smssent = value;
                        FocusScope.of(context).unfocus();
                      }
                    },
                    decoration:
                        otpinputDecoration.copyWith(hintText: 'Enter OTP')),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    errorText,
                    textScaleFactor: 1.1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w600),
                  ),
                ),
                InkWell(
                  onTap: _start == 0
                      ? () {
                          print('verify');
                        }
                      : () {},
                  child: Text(
                    'Resend Code ${_start}s',
                    textScaleFactor: 1.0,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: _start == 0 ? Colors.black : Colors.grey,
                        fontSize: 16,
                        decoration: TextDecoration.underline),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      'Edit phone number',
                      textScaleFactor: 1.0,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
