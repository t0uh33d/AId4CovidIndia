import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oxygenforcovid/models/postModel.dart';
import 'package:oxygenforcovid/services/database.dart';
import 'package:oxygenforcovid/shared/colors.dart';
import 'package:oxygenforcovid/shared/widgets.dart';

class ViewPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var postId = Get.parameters['post_id'];
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors().backgroundColor,
      appBar: CustomWidgets().centerTitleAppBar(title: 'Details'),
      body: SingleChildScrollView(
          child: FutureBuilder(
              future: DatabaseService().viewPost(postId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  PostModel postModel = snapshot.data;
                  return CustomWidgets().postDetails(postModel, request: false);
                } else {
                  return Container(
                    height: size.height,
                    width: size.width,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              })),
    );
  }
}
