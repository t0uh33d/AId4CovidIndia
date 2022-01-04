import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oxygenforcovid/controllers/authController.dart';
import 'package:oxygenforcovid/shared/colors.dart';
import 'package:oxygenforcovid/shared/loader.dart';
import 'package:oxygenforcovid/shared/theme.dart';
import 'package:oxygenforcovid/shared/widgets.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool autoval = false;
  String email = "";
  String password = "";
  String error = "";
  var authController = Get.find<AuthController>();
  bool showpass = true;
  String passmatch = "";
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return loading
        ? Loader()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  height: size.height,
                  color: CustomColors().primaryColor,
                  width: size.width > 650 ? 650 : size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 30.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Text('Register',
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  decoration: textDecorationa.copyWith(
                                      hintText: 'Email'),
                                  autovalidate: autoval,
                                  style: TextStyle(color: Colors.white),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    Pattern pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regex = new RegExp(pattern);
                                    if (!regex.hasMatch(value))
                                      return 'Enter Valid Email';
                                    else
                                      return null;
                                  },
                                  onChanged: (val) {
                                    setState(() {
                                      email = val;
                                      autoval = true;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  decoration: textDecorationa.copyWith(
                                      hintText: 'Password',
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          Icons.remove_red_eye,
                                          color: !showpass
                                              ? Colors.white
                                              : Colors.grey,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            showpass = !showpass;
                                          });
                                        },
                                      )),
                                  validator: (val) {
                                    if (val.length < 6) {
                                      return 'Enter password with more than 6+ characters';
                                    }
                                    return null;
                                  },
                                  onChanged: (val) {
                                    setState(() => password = val);
                                  },
                                  obscureText: showpass,
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  obscureText: true,
                                  decoration: textDecorationa.copyWith(
                                      hintText: "Re enter password"),
                                  autovalidate: true,
                                  onChanged: (value) {
                                    setState(() {
                                      passmatch = value;
                                    });
                                  },
                                  validator: (val) => passmatch != password
                                      ? "password mismatch"
                                      : null,
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: size.width * 0.1,
                                  child: CustomWidgets().customRaisedButton(
                                      buttonText: 'Register',
                                      onpressed: () async {
                                        if (_formKey.currentState.validate()) {
                                          setState(() {
                                            loading = true;
                                          });
                                          authController.registerEmail(
                                              email: email, password: password);
                                          Future.delayed(Duration(seconds: 1),
                                              () {
                                            setState(() {
                                              loading = false;
                                            });
                                          });
                                        }
                                      },
                                      textColor: CustomColors().primaryColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      buttonColor: Colors.white,
                                      borderColor: Colors.white),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                OutlineButton.icon(
                                    label: Text(
                                      "Back to login",
                                      textScaleFactor: 1.0,
                                    ),
                                    icon: Icon(Icons.person_outline),
                                    textColor: Colors.white,
                                    onPressed: () {
                                      widget.toggleView();
                                    },
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0))),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  error,
                                  style: TextStyle(color: Colors.red),
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ));
  }
}
