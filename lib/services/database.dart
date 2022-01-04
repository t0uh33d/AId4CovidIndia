import 'package:firebase_db_web_unofficial/DatabaseSnapshot.dart';
import 'package:firebase_db_web_unofficial/firebasedbwebunofficial.dart';
import 'package:get/get.dart';
import 'package:oxygenforcovid/controllers/authController.dart';
import 'package:oxygenforcovid/models/postModel.dart';
import 'package:oxygenforcovid/screens/requests/userRequests.dart';
import 'package:oxygenforcovid/screens/posts/userPosts.dart';
import 'package:oxygenforcovid/screens/posts/userPosts.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:firebase_db_web_unofficial/Query.dart';

class DatabaseService {
  DatabaseRef firebaseRef = FirebaseDatabaseWeb.instance.reference();
  var authcontroller = Get.find<AuthController>();

  Future<List<PostModel>> fetchUserPosts() async {
    DatabaseSnapshot data = await firebaseRef.child('posts').once();
    Map<dynamic, dynamic> values = data.value;
    // print(values);
    List<PostModel> tempPostData = [];
    if (values != null) {
      values.forEach((key, value) async {
        tempPostData.add(PostModel.fromSnapshot(value));
      });
    }
    //  print(authcontroller.useruid);
    tempPostData = tempPostData
        .where((element) => element.userId == authcontroller.useruid)
        .toList();

    tempPostData.sort((a, b) {
      var adate = a.timestamp;
      var bdate = b.timestamp;
      return adate.compareTo(bdate);
    });
    tempPostData = tempPostData.reversed.toList();
    return tempPostData;
  }

  Future<PostModel> viewPost(String postId) async {
    DatabaseSnapshot data =
        await firebaseRef.child('posts').child(postId).once();
    var values = data.value;
    PostModel model = PostModel.fromSnapshot(values);
    return model;
  }

  Future<PostModel> viewRequest(String postId) async {
    DatabaseSnapshot data =
        await firebaseRef.child('requests').child(postId).once();
    var values = data.value;
    PostModel model = PostModel.fromSnapshot(values);
    return model;
  }

  Future<List<PostModel>> fetchHelpRequests({String state}) async {
    DatabaseSnapshot data = await firebaseRef.child('requests').once();
    Map<dynamic, dynamic> values = data.value;
    // print(values);
    List<PostModel> tempPostData = [];
    if (values != null) {
      values.forEach((key, value) async {
        tempPostData.add(PostModel.fromSnapshot(value));
      });
    }

    tempPostData =
        tempPostData.where((element) => element.state == state).toList();

    tempPostData.sort((a, b) {
      var adate = a.timestamp;
      var bdate = b.timestamp;
      return adate.compareTo(bdate);
    });
    tempPostData = tempPostData.reversed.toList();
    return tempPostData;
  }

  Future<List<PostModel>> fetchUserRequests() async {
    DatabaseSnapshot data = await firebaseRef.child('requests').once();
    Map<dynamic, dynamic> values = data.value;
    // print(values);
    List<PostModel> tempPostData = [];
    if (values != null) {
      values.forEach((key, value) async {
        tempPostData.add(PostModel.fromSnapshot(value));
      });
    }

    tempPostData = tempPostData
        .where((element) => element.userId == authcontroller.useruid)
        .toList();

    tempPostData.sort((a, b) {
      var adate = a.timestamp;
      var bdate = b.timestamp;
      return adate.compareTo(bdate);
    });
    tempPostData = tempPostData.reversed.toList();
    return tempPostData;
  }

  Future<List<PostModel>> fetchPublicPostsOtherLocation(
      {String city, String resourceType}) async {
    // print(city);
    DatabaseSnapshot data = await firebaseRef.child('posts').once();
    Map<dynamic, dynamic> values = data.value;
    // print(values);
    List<PostModel> tempPostData = [];
    if (values != null) {
      values.forEach((key, value) async {
        tempPostData.add(PostModel.fromSnapshot(value));
      });
    }

    // checking resource type selected by the user

    switch (resourceType) {
      case "Medicine":
        {
          tempPostData = tempPostData.where((element) {
            return element.tablets == true;
          }).toList();
        }
        break;

      case "Vaccine":
        {
          tempPostData = tempPostData.where((element) {
            return element.injection == true;
          }).toList();
        }
        break;

      case "Oxygen Cylinder":
        {
          tempPostData = tempPostData.where((element) {
            return element.oxygen == true;
          }).toList();
        }
        break;

      case "Plasma":
        {
          tempPostData = tempPostData.where((element) {
            return element.plasma == true;
          }).toList();
        }
        break;

      case "Hospital Beds":
        {
          tempPostData = tempPostData.where((element) {
            return element.bed == true;
          }).toList();
        }
        break;

      case "ICU/Ventilator":
        {
          tempPostData = tempPostData.where((element) {
            return element.ventilator == true;
          }).toList();
        }
        break;

      default:
        {
          tempPostData = tempPostData;
        }
        break;
    }

    tempPostData.sort((a, b) {
      var adate = a.timestamp;
      var bdate = b.timestamp;
      return adate.compareTo(bdate);
    });
    tempPostData = tempPostData.reversed.toList();
    return tempPostData;
  }

  Future<List<PostModel>> fetchPublicPosts(
      {String city, String resourceType}) async {
    //  print(city);
    DatabaseSnapshot data = await firebaseRef.child('posts').once();
    Map<dynamic, dynamic> values = data.value;
    //  print(values);
    List<PostModel> tempPostData = [];
    if (values != null) {
      values.forEach((key, value) async {
        tempPostData.add(PostModel.fromSnapshot(value));
      });
    }

    // checking resource type selected by the user

    switch (resourceType) {
      case "Medicine":
        {
          tempPostData = tempPostData.where((element) {
            return element.city == city && element.tablets == true;
          }).toList();
        }
        break;

      case "Vaccine":
        {
          tempPostData = tempPostData.where((element) {
            return element.city == city && element.injection == true;
          }).toList();
        }
        break;

      case "Oxygen Cylinder":
        {
          tempPostData = tempPostData.where((element) {
            return element.city == city && element.oxygen == true;
          }).toList();
        }
        break;

      case "Plasma":
        {
          tempPostData = tempPostData.where((element) {
            return element.city == city && element.plasma == true;
          }).toList();
        }
        break;

      case "Hospital Beds":
        {
          tempPostData = tempPostData.where((element) {
            return element.city == city && element.bed == true;
          }).toList();
        }
        break;

      case "ICU/Ventilator":
        {
          tempPostData = tempPostData.where((element) {
            return element.city == city && element.ventilator == true;
          }).toList();
        }
        break;

      default:
        {
          tempPostData = tempPostData.where((element) {
            return element.city == city;
          }).toList();
        }
        break;
    }

    tempPostData.sort((a, b) {
      var adate = a.timestamp;
      var bdate = b.timestamp;
      return adate.compareTo(bdate);
    });
    tempPostData = tempPostData.reversed.toList();
    return tempPostData;
  }

  void deletePost(String postId) async {
    try {
      await firebaseRef.child('posts').child(postId).remove();
      Get.back();
    } catch (e) {
      Get.snackbar('Not able to delete', e.message,
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  void deleteRequest(String postId) async {
    try {
      await firebaseRef.child('requests').child(postId).remove();
      Get.back();
    } catch (e) {
      Get.snackbar('Not able to delete', e.message,
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  void uploadPost(
      {String name,
      String address,
      String contact,
      bool plasma,
      bool bed,
      bool oxygen,
      List plasmaGroups,
      String location,
      String city,
      String state,
      bool injection,
      bool ventilator,
      bool tablets}) async {
    var uuid = Uuid().v1();
    var timestamp = DateTime.now().millisecondsSinceEpoch;
    var timeDisplay = "${DateTime.now()}";
    try {
      await firebaseRef.child("posts").child(uuid).update({
        "name": name,
        "location": location,
        "address": address,
        "contact": contact,
        "plasma": plasma,
        "bed": bed,
        "oxygen": oxygen,
        "state": state,
        "city": city,
        "injection": injection,
        "ventilator": ventilator,
        "tablets": tablets,
        "postId": uuid,
        "userId": authcontroller.useruid,
        "timestamp": timestamp,
        "timedisplay": timeDisplay
      });

      if (plasma) {
        plasmaGroups.forEach((element) async {
          await firebaseRef
              .child('posts')
              .child(uuid)
              .child('bloodGroups')
              .update({element: element});
        });
      }

      Get.off(UserPosts());
    } catch (e) {
      Get.snackbar('Upload error', e.message.toString());
    }
  }

  void uploadRequest(
      {String name,
      String address,
      String contact,
      bool plasma,
      bool bed,
      bool oxygen,
      List plasmaGroups,
      String location,
      String city,
      String state,
      bool injection,
      bool ventilator,
      bool tablets}) async {
    var uuid = Uuid().v1();
    var timestamp = DateTime.now().millisecondsSinceEpoch;
    var timeDisplay = "${DateTime.now()}";
    try {
      await firebaseRef.child("requests").child(uuid).update({
        "name": name,
        "location": location,
        "address": address,
        "contact": contact,
        "plasma": plasma,
        "bed": bed,
        "oxygen": oxygen,
        "state": state,
        "city": city,
        "injection": injection,
        "ventilator": ventilator,
        "tablets": tablets,
        "postId": uuid,
        "userId": authcontroller.useruid,
        "timestamp": timestamp,
        "timedisplay": timeDisplay
      });

      if (plasma) {
        plasmaGroups.forEach((element) async {
          await firebaseRef
              .child('requests')
              .child(uuid)
              .child('bloodGroups')
              .update({element: element});
        });
      }
      // add view user requests here
      Get.off(UserRequests());
    } catch (e) {
      Get.snackbar('Upload error', e.message.toString());
    }
  }
}
