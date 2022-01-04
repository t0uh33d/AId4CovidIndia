import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:oxygenforcovid/auth/forgotPassword.dart';
import 'package:oxygenforcovid/controllers/authController.dart';
import 'package:oxygenforcovid/shared/colors.dart';
import 'package:oxygenforcovid/shared/loader.dart';
import 'package:oxygenforcovid/shared/theme.dart';
import 'package:oxygenforcovid/shared/widgets.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool autoval = false;
  var authController = Get.find<AuthController>();

  // text fields state
  String email = "";
  String password = "";
  String error = "";
  bool showpass = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return loading
        ? Loader()
        : SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                  backgroundColor: CustomColors().primaryColor,
                  elevation: 0.0,
                  iconTheme: IconThemeData(color: Colors.white)),
              body: SingleChildScrollView(
                child: Center(
                  child: Container(
                    height: size.height,
                    width: size.width > 650 ? 650 : size.width,
                    color: CustomColors().primaryColor,
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 30.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Sign In',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                decoration:
                                    textDecorationa.copyWith(hintText: 'Email'),
                                //  autovalidateMode : autoval,
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: Colors.white),
                                validator: (value) {
                                  Pattern pattern =
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  RegExp regex = new RegExp(pattern);
                                  if (!regex.hasMatch(value))
                                    return 'Enter Valid Email';
                                  else
                                    return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    email = value;
                                    autoval = true;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              TextFormField(
                                obscureText: showpass,
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
                                style: TextStyle(color: Colors.white),
                                validator: (val) {
                                  if (val.length < 6) {
                                    return 'Enter password with more than 6 characters';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() => password = value);
                                },
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    Get.to(ForgotPassword());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text('Forgot Password',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: size.width > 650
                                    ? size.width * 0.04
                                    : size.width * 0.1,
                                child: CustomWidgets().customRaisedButton(
                                    buttonText: 'Sign In',
                                    onpressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        setState(() {
                                          loading = true;
                                        });
                                        authController.signInEmailPass(
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
                              Text(
                                error,
                                style: TextStyle(color: Colors.red),
                              ),
                              OutlineButton.icon(
                                  label: Text(
                                    "Click here to register",
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
                              SizedBox(height: 10.0),
                              Text(
                                '-- OR --',
                                textScaleFactor: 1,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              SizedBox(height: 20.0),
                              InkWell(
                                onTap: () async {
                                  authController.signInWithGoogle();
                                },
                                child: ListTile(
                                  tileColor: Colors.white,
                                  leading: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Image.asset(
                                      'lib/assets/google.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(
                                    'Continue with Google',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ),
            ),
          );
  }
}
