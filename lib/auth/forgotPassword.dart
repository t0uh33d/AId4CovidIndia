import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oxygenforcovid/controllers/authController.dart';
import 'package:oxygenforcovid/shared/colors.dart';
import 'package:oxygenforcovid/shared/theme.dart';
import 'package:oxygenforcovid/shared/widgets.dart';

class ForgotPassword extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: CustomWidgets().centerTitleAppBar(title: 'Forgot Password'),
      body: Container(
        color: Colors.white,
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomWidgets().formLabel(label: 'Enter Email'),
              TextFormField(
                controller: emailController,
                decoration: otpinputDecoration,
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () async {
                  await controller.resetPasssword(emailController.text);
                },
                child: ListTile(
                  tileColor: CustomColors().primaryColor,
                  title: Text('Reset Password',
                      style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.arrow_right, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
