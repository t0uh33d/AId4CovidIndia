import 'package:firebase_db_web_unofficial/firebasedbwebunofficial.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oxygenforcovid/controllers/searchController.dart';
import 'package:oxygenforcovid/models/postModel.dart';
import 'package:oxygenforcovid/screens/posts/postDetails.dart';
import 'package:oxygenforcovid/screens/search/searchStateResult.dart';
import 'package:oxygenforcovid/services/database.dart';
import 'package:oxygenforcovid/shared/widgets.dart';

class SearchResult extends StatelessWidget {
  String location;
  String resourceType;
  SearchResult({this.location, this.resourceType});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var searchController = Get.find<SearchController>();
    return Scaffold(
      appBar: CustomWidgets().centerTitleAppBar(
        title: 'Results',
      ),
      body: Container(
        child: FutureBuilder(
          future: DatabaseService().fetchPublicPosts(
              city: searchController.searchCity.value,
              resourceType: resourceType),
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
                              userSelf: false,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomWidgets().postLabel('No data available'),
                        SizedBox(height: 10.0),
                        CustomWidgets().customRaisedButton(
                            buttonText: 'View results from other Locations',
                            onpressed: () => Get.to(SearchStateResult(
                                  resourceType: resourceType,
                                  location: location,
                                )))
                      ],
                    ),
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
