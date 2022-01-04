import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:oxygenforcovid/auth/phone_auth.dart';
import 'package:oxygenforcovid/shared/colors.dart';
import 'package:oxygenforcovid/shared/loader.dart';
import 'package:oxygenforcovid/shared/widgets.dart';

class PhoneAuthBg extends StatefulWidget {
  @override
  _PhoneAuthBgState createState() => _PhoneAuthBgState();
}

class _PhoneAuthBgState extends State<PhoneAuthBg> {
  String phoneNo, smssent, verificationId;
  String errorText = '';
  bool loading = false;
  bool continuebutton = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return loading
        ? Loader()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomWidgets().centerTitleAppBar(title: 'Login'),
            bottomNavigationBar: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              height: 60,
              child: FlatButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    FirebaseAuth auth = FirebaseAuth.instance;

                    // Wait for the user to complete the reCAPTCHA & for a SMS code to be sent.
                    try {
                      ConfirmationResult confirmationResult =
                          await auth.signInWithPhoneNumber('+91' + phoneNo);

                      Get.to(OtpPhone(
                        phoneNo: phoneNo,
                        confirmationResult: confirmationResult,
                      ));
                    } catch (e) {
                      setState(() {
                        loading = false;
                      });
                      Get.snackbar('Error', e.toString(),
                          backgroundColor: Colors.red, colorText: Colors.white);
                    }
                  }
                },
                child: Text('Continue'),
                disabledColor: Colors.grey,
                disabledTextColor: Colors.grey[350],
                color: CustomColors().primaryColor,
                textColor: Colors.white,
              ),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Image.asset('lib/assets/smartphone.png',
                            width: 80, height: 80),
                      ),
                      Text(
                        'Enter your phone number',
                        textScaleFactor: 1.0,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black, fontSize: 24),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'We will send a confirmation code to your phone',
                          maxLines: 2,
                          textScaleFactor: 1.0,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey[800]),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                              width: size.width * 0.3,
                              padding: EdgeInsets.only(right: 10.0),
                              child: TextFormField(
                                enabled: false,
                                initialValue: '+91',
                                decoration:
                                    InputDecoration(labelText: 'Country'),
                              )),
                          Flexible(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Enter phone number'),
                                LengthRangeValidator(
                                    min: 10,
                                    max: 10,
                                    errorText: 'Invalid number')
                              ]),
                              decoration:
                                  InputDecoration(labelText: 'Phone Number'),
                              onChanged: (value) {
                                if (value.length > 9) {
                                  this.phoneNo = value;
                                  FocusScope.of(context).unfocus();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Text(
                          errorText,
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
