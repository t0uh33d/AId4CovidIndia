import 'package:flutter/material.dart';
import 'package:oxygenforcovid/models/postModel.dart';
import 'package:oxygenforcovid/shared/colors.dart';
import 'package:oxygenforcovid/shared/widgets.dart';

class PostDetails extends StatelessWidget {
  PostModel postModel;
  PostDetails({this.postModel});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().backgroundColor,
      appBar: CustomWidgets().centerTitleAppBar(title: 'Details'),
      body: SingleChildScrollView(
          child: CustomWidgets().postDetails(postModel, request: false)),
    );
  }
}
