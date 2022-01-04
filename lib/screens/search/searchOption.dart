import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:oxygenforcovid/controllers/searchController.dart';
import 'package:oxygenforcovid/screens/search/searchResult.dart';
import 'package:oxygenforcovid/shared/colors.dart';
import 'package:oxygenforcovid/shared/widgets.dart';

class SearchOptions extends StatelessWidget {
  @override
  var searchController = Get.find<SearchController>();
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors().primaryColor),
        elevation: 0.0,
        title: Text(
          'Select Option',
          style: TextStyle(
              color: CustomColors().primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text(searchController.searchLocation.value),
            ),
            StaggeredGridView.count(
              crossAxisCount: size.width > 650 ? 6 : 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              staggeredTiles: [
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 1),
              ],
              children: [
                CustomWidgets().searchCard(
                    title: 'Medicine',
                    iconPath: 'lib/assets/medicine.png',
                    onPressed: () => Get.to(SearchResult(
                          location: searchController.searchLocation.value,
                          resourceType: 'Medicine',
                        ))),
                CustomWidgets().searchCard(
                    title: 'Vaccine',
                    iconPath: 'lib/assets/drugs.png',
                    onPressed: () => Get.to(SearchResult(
                          location: searchController.searchLocation.value,
                          resourceType: 'Vaccine',
                        ))),
                CustomWidgets().searchCard(
                    title: 'Oxygen Cylinder',
                    iconPath: 'lib/assets/oxygen.png',
                    onPressed: () => Get.to(SearchResult(
                          location: searchController.searchLocation.value,
                          resourceType: 'Oxygen Cylinder',
                        ))),
                CustomWidgets().searchCard(
                    title: 'Plasma',
                    iconPath: 'lib/assets/platelet.png',
                    onPressed: () => Get.to(SearchResult(
                          location: searchController.searchLocation.value,
                          resourceType: 'Plasma',
                        ))),
                CustomWidgets().searchCard(
                    title: 'Hospital Beds',
                    iconPath: 'lib/assets/hospital-bed.png',
                    onPressed: () => Get.to(SearchResult(
                          location: searchController.searchLocation.value,
                          resourceType: 'Hospital Beds',
                        ))),
                CustomWidgets().searchCard(
                    title: 'ICU/Ventilator',
                    iconPath: 'lib/assets/ventilation.png',
                    onPressed: () => Get.to(SearchResult(
                          location: searchController.searchLocation.value,
                          resourceType: 'ICU/Ventilator',
                        ))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
