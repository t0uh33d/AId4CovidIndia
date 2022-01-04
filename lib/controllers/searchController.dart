import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  var searchLocation = ''.obs;
  var searchState = ''.obs;
  var searchCity = ''.obs;
  // var searchResultList = [].obs;

  void onClose() {
    // TODO: implement onClose
    super.onClose();
    searchLocation.close();
    searchState.close();
    searchCity.close();
  }
}
