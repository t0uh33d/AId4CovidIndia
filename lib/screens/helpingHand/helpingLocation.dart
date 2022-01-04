import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oxygenforcovid/controllers/postController.dart';
import 'package:oxygenforcovid/controllers/searchController.dart';
import 'package:oxygenforcovid/screens/helpingHand/helpRequests.dart';
import 'package:oxygenforcovid/screens/search/searchOption.dart';
import 'package:oxygenforcovid/shared/loader.dart';
import 'package:oxygenforcovid/shared/theme.dart';
import 'package:oxygenforcovid/shared/widgets.dart';
import 'dart:convert';

class HelpingLocation extends StatefulWidget {
  @override
  _HelpingLocationState createState() => _HelpingLocationState();
}

class _HelpingLocationState extends State<HelpingLocation> {
  var postController = Get.put(SearchController());
  var locationDataStore;
  TextEditingController searchController = TextEditingController();

  var locationList = [];
  var searchList = [];

  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

  void fetchLocation() async {
    var result = await DefaultAssetBundle.of(context)
        .loadString('lib/assets/json/cityData.json');
    var locationData = json.decode(result.toString());
    locationDataStore = locationData;

    setState(() {
      locationData.forEach((element) {
        locationList.add(element);
      });
    });
  }

  onSearchTextChanged(String text) async {
    searchList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    locationDataStore.forEach((userDetail) {
      if (userDetail['state']
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()) ||
          userDetail['city']
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase())) searchList.add(userDetail);
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomWidgets().centerTitleAppBar(title: 'Choose your location'),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextFormField(
              controller: searchController,
              onChanged: onSearchTextChanged,
              decoration: otpinputDecoration.copyWith(
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => searchController.clear())
                      : Icon(Icons.search)),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: searchController.text.isNotEmpty
                    ? searchList.length
                    : locationList.length,
                itemBuilder: (context, index) {
                  if (searchList.length != 0 ||
                      searchController.text.isNotEmpty) {
                    return ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text(
                            '${searchList[index]["city"]}, ${searchList[index]["state"]}'),
                        onTap: () {
                          postController.searchLocation.value =
                              "${searchList[index]["city"]}, ${searchList[index]["state"]}";
                          postController.searchCity.value =
                              "${searchList[index]["city"]}";
                          postController.searchState.value =
                              "${searchList[index]["state"]}";
                          Get.to(HelpRequests());
                        });
                  } else {
                    return ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text(
                            '${locationList[index]["city"]}, ${locationList[index]["state"]}'),
                        onTap: () {
                          postController.searchLocation.value =
                              "${locationList[index]["city"]}, ${locationList[index]["state"]}";
                          postController.searchCity.value =
                              "${locationList[index]["city"]}";
                          postController.searchState.value =
                              "${locationList[index]["state"]}";
                          Get.to(HelpRequests());
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}
