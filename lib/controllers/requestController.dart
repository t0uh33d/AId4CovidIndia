import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:oxygenforcovid/models/plasmaModel.dart';
import 'package:oxygenforcovid/screens/posts/userPosts.dart';
import 'package:oxygenforcovid/services/database.dart';

class RequestController extends GetxController {
  TextEditingController nameController, contactController, addressController;
  var plasmaAvail = false.obs;
  var bedAvail = false.obs;
  var oxygenAvail = false.obs;
  var injections = false.obs;
  var tablets = false.obs;
  var ventilator = false.obs;
  var loading = false.obs;

  var plasmaGroups = [];
  var location = "Click Here".obs;
  var city = ''.obs;
  var state = ''.obs;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  var plamsaGroupList = [
    PlasmaModel(label: "A+"),
    PlasmaModel(label: "B+"),
    PlasmaModel(label: "AB+"),
    PlasmaModel(label: "A-"),
    PlasmaModel(label: "B-"),
    PlasmaModel(label: "AB-"),
    PlasmaModel(label: "O+"),
    PlasmaModel(label: "O-"),
  ].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nameController = TextEditingController();
    contactController = TextEditingController();
    addressController = TextEditingController();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    nameController.dispose();
    contactController.dispose();
    addressController.dispose();
    location.close();
    city.close();
    state.close();
  }

  void addToList(String label, {bool select}) {
    if (select) {
      plasmaGroups.add(label);
    } else {
      plasmaGroups.remove(label);
    }

    print(plasmaGroups);
  }

  void addPlasma(String plasmaType) {
    plasmaGroups.add(plasmaType);
  }

  void plasmaChange(bool value) {
    plasmaAvail(value);
  }

  void injectionChange(bool value) {
    injections(value);
  }

  void tabletChange(bool value) {
    tablets(value);
  }

  void ventilatorChange(bool value) {
    ventilator(value);
  }

  void oxygenChange(bool value) {
    oxygenAvail(value);
  }

  void bedChange(bool value) {
    bedAvail(value);
  }

  void validatePost() async {
    if (location.value == "Click Here") {
      Get.snackbar('Location', "Please select a location",
          backgroundColor: Colors.red, colorText: Colors.white);
    } else {
      if (plasmaAvail.value ||
          bedAvail.value ||
          oxygenAvail.value ||
          injections.value ||
          tablets.value ||
          ventilator.value) {
        if (plasmaAvail.value) {
          if (plasmaGroups.length != 0) {
            if (formkey.currentState.validate()) {
              await DatabaseService().uploadRequest(
                  name: nameController.text,
                  contact: contactController.text,
                  address: addressController.text,
                  plasma: plasmaAvail.value,
                  bed: bedAvail.value,
                  oxygen: oxygenAvail.value,
                  plasmaGroups: plasmaGroups,
                  location: location.value,
                  city: city.value,
                  state: state.value,
                  injection: injections.value,
                  tablets: tablets.value,
                  ventilator: ventilator.value);
            } else {
              Get.snackbar(
                  'Field(s) missing', 'Please fill the required fields',
                  backgroundColor: Colors.red, colorText: Colors.white);
            }
          } else {
            Get.snackbar(
                'Select Blood Group', 'Select type of blood group(s) required',
                backgroundColor: Colors.red, colorText: Colors.white);
          }
        } else {
          if (formkey.currentState.validate()) {
            DatabaseService().uploadRequest(
                name: nameController.text,
                contact: contactController.text,
                address: addressController.text ?? 'NO',
                plasma: plasmaAvail.value,
                bed: bedAvail.value,
                oxygen: oxygenAvail.value,
                plasmaGroups: plasmaGroups,
                location: location.value,
                city: city.value,
                state: state.value,
                injection: injections.value,
                ventilator: ventilator.value,
                tablets: tablets.value);
          }
        }
      } else {
        Get.snackbar('Select Availabilty', 'Please select required resources',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
  }
}
