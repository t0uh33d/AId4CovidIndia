import 'package:firebase_db_web_unofficial/firebasedbwebunofficial.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oxygenforcovid/models/postModel.dart';
import 'package:oxygenforcovid/screens/posts/postDetails.dart';
import 'package:oxygenforcovid/services/database.dart';
import 'package:oxygenforcovid/shared/colors.dart';
import 'package:oxygenforcovid/shared/widgets.dart';

class UserPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors().backgroundColor,
      appBar: CustomWidgets().centerTitleAppBar(
        title: 'Your Posts',
      ),
      body: Container(
        child: FutureBuilder(
          future: DatabaseService().fetchUserPosts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<PostModel> postList = snapshot.data;
              print('in build : ${postList.length}');
              if (postList.length != 0) {
                return ListView.builder(
                  itemCount: postList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                          child: CustomWidgets().postWidget(postList[index],
                              userSelf: true,
                              request: false,
                              onpressed: () => Get.to(
                                  PostDetails(postModel: postList[index])))),
                    );
                  },
                );
              } else {
                return Container(
                  height: size.height,
                  width: size.width,
                  child: Center(
                    child: CustomWidgets().postLabel('No data available'),
                  ),
                );
              }
            } else {
              return Container(
                height: size.height,
                width: size.width,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
