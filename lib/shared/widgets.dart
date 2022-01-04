import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oxygenforcovid/controllers/authController.dart';
import 'package:oxygenforcovid/controllers/postController.dart';
import 'package:oxygenforcovid/models/postModel.dart';
import 'package:oxygenforcovid/services/database.dart';
import 'package:oxygenforcovid/shared/colors.dart';
import 'dart:convert';
import 'package:timeago/timeago.dart' as timeago;
import 'package:oxygenforcovid/shared/theme.dart';
import 'package:share_plus/share_plus.dart';

class CustomWidgets {
  var authController = Get.find<AuthController>();
  Widget customRaisedButton(
      {String buttonText,
      Function onpressed,
      BorderRadiusGeometry borderRadius,
      Color buttonColor,
      Color borderColor,
      Color textColor}) {
    return ElevatedButton(
        child: Text(buttonText, overflow: TextOverflow.ellipsis),
        style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(3.0),
            foregroundColor:
                MaterialStateProperty.all<Color>(textColor ?? Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(
                buttonColor ?? CustomColors().primaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: borderRadius ?? BorderRadius.zero,
                    side: BorderSide(
                        color: borderColor ?? CustomColors().primaryColor)))),
        onPressed: onpressed);
  }

  Widget centerTitleAppBar(
      {String title,
      Color backgroundColor,
      Color textColor,
      bool share = false}) {
    return AppBar(
      iconTheme: IconThemeData(color: textColor ?? CustomColors().primaryColor),
      elevation: 0.0,
      actions: [
        if (share)
          IconButton(
              icon: Icon(Icons.share, color: textColor),
              onPressed: () {
                Share.share('https://aid4covidindia.in');
              })
      ],
      title: Text(
        title ?? 'Select Option',
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: textColor ?? CustomColors().primaryColor,
            fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: backgroundColor ?? Colors.white,
    );
  }

  Widget homeCard(
      {String imagePath,
      String cardTitle,
      String cardInfo,
      Function onPressed,
      Size size}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: onPressed,
        child: Card(
          color: CustomColors().primaryColor,
          elevation: 3.0,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(imagePath ?? '/platelet.png'),
                SizedBox(height: 3.0),
                Text(
                  cardTitle,
                  textScaleFactor: 1.0,
                  // overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 3.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    cardInfo,
                    textScaleFactor: 0.9,
                    // overflow: TextOverflow.ellipsis,
                    // maxLines: 4,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget formLabel({String label}) {
    return Text(label,
        textScaleFactor: 1.0,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            color: CustomColors().primaryColor,
            fontWeight: FontWeight.w500,
            fontSize: 16));
  }

  Widget plasmaCircle({bool isSelected, Function onTap, String label}) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: isSelected ? Colors.red : Colors.grey,
        child: Text(label,
            textScaleFactor: 1.0,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
        radius: 20,
      ),
    );
  }

  Widget postWidget(PostModel postModel,
      {Function onpressed, bool userSelf, bool request}) {
    var groups = postModel.bloodGroups;
    print(groups);
    List<String> groupList = [];
    if (postModel.plasma) {
      groups.forEach((key, value) {
        groupList.add(value);
      });
    }

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(Icons.location_on, color: Colors.white),
            title:
                Text(postModel.location, style: TextStyle(color: Colors.white)),
            tileColor: CustomColors().primaryColor,
            trailing: IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  if (request) {
                    Share.share(
                        'https://aid4covidindia.in/#/viewrequest?post_id=${postModel.postId}');
                  } else {
                    Share.share(
                        'https://aid4covidindia.in/#/viewpost?post_id=${postModel.postId}');
                  }
                }),
          ),
          ListTile(
            leading: request ? postLabel('Requested') : postLabel('Posted'),
            trailing: _dateDisplay(postModel.timeDisplay),
          ),
          ListTile(
            leading: postLabel('Name'),
            trailing: Text(postModel.name),
          ),
          Divider(thickness: 0.2),
          ListTile(
              leading: request
                  ? postLabel('In need of')
                  : postLabel('Availability')),
          if (postModel.plasma)
            ListTile(
              leading: Text('Plasma'),
              trailing: postModel.plasma
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : Icon(Icons.circle, color: Colors.red),
            ),
          if (postModel.plasma)
            ListTile(
              leading: Text('Blood groups'),
              title: postLabel(groupList.toString()),
            ),
          if (postModel.oxygen)
            ListTile(
              leading: Text('Oxygen Cylinder'),
              trailing: postModel.oxygen
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : Icon(Icons.circle, color: Colors.red),
            ),
          if (postModel.bed)
            ListTile(
              leading: Text('Hospital Beds'),
              trailing: postModel.bed
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : Icon(Icons.circle, color: Colors.red),
            ),
          if (postModel.injection)
            ListTile(
              leading: Text('Covid vaccine'),
              trailing: postModel.injection
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : Icon(Icons.circle, color: Colors.red),
            ),
          if (postModel.tablets)
            ListTile(
              leading: Text('Covid Medicine'),
              trailing: postModel.tablets
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : Icon(Icons.circle, color: Colors.red),
            ),
          if (postModel.ventilator)
            ListTile(
              leading: Text('ICU & Ventilator'),
              trailing: postModel.ventilator
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : Icon(Icons.circle, color: Colors.red),
            ),
          Divider(thickness: 0.5),
          // add userId

          ListTile(
            leading: postModel.userId == authController.useruid
                ? FlatButton.icon(
                    onPressed: () {
                      request
                          ? DatabaseService().deleteRequest(postModel.postId)
                          : DatabaseService().deletePost(postModel.postId);
                    },
                    color: Colors.red,
                    icon: Icon(Icons.delete, color: Colors.white),
                    label: Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ))
                : customRaisedButton(
                    buttonText: 'Share',
                    buttonColor: CustomColors().greenColor,
                    borderColor: CustomColors().greenColor,
                    onpressed: () {
                      if (request) {
                        print(window.location.href);
                        Share.share(
                            'https://aid4covidindia.in/#/viewrequest?post_id=${postModel.postId}');
                      } else {
                        Share.share(
                            'https://aid4covidindia.in/#/viewpost?post_id=${postModel.postId}');
                      }
                    }),
            trailing: FlatButton.icon(
                onPressed: onpressed,
                color: CustomColors().primaryColor,
                icon: Icon(Icons.arrow_right, color: Colors.white),
                label: Text(
                  'More Details',
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }

  Widget postDetails(PostModel postModel, {bool request}) {
    var groups = postModel.bloodGroups;
    print(groups);
    List<String> groupList = [];
    if (postModel.plasma) {
      groups.forEach((key, value) {
        groupList.add(value);
      });
    }

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
              leading: Icon(Icons.location_on, color: Colors.white),
              title: Text(postModel.location,
                  style: TextStyle(color: Colors.white)),
              tileColor: CustomColors().primaryColor,
              trailing: IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    if (request) {
                      Share.share(
                          'https://aid4covidindia.in/#/viewrequest?post_id=${postModel.postId}');
                    } else {
                      Share.share(
                          'https://aid4covidindia.in/#/viewpost?post_id=${postModel.postId}');
                    }
                  })),
          ListTile(
            leading: postLabel('Name'),
            trailing: Text(postModel.name),
          ),
          Divider(thickness: 0.5),
          ListTile(
              leading: request
                  ? postLabel('In need of')
                  : postLabel('Availability')),
          if (postModel.plasma)
            ListTile(
              leading: Text('Plasma'),
              trailing: postModel.plasma
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : Icon(Icons.circle, color: Colors.red),
            ),
          if (postModel.plasma)
            ListTile(
              leading: Text('Blood groups'),
              title: postLabel(groupList.toString()),
            ),
          if (postModel.oxygen)
            ListTile(
              leading: Text('Oxygen Cylinder'),
              trailing: postModel.oxygen
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : Icon(Icons.circle, color: Colors.red),
            ),
          if (postModel.bed)
            ListTile(
              leading: Text('Hospital Beds'),
              trailing: postModel.bed
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : Icon(Icons.circle, color: Colors.red),
            ),
          if (postModel.injection)
            ListTile(
              leading: Text('Covid Vaccine'),
              trailing: postModel.injection
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : Icon(Icons.circle, color: Colors.red),
            ),
          if (postModel.tablets)
            ListTile(
              leading: Text('Covid Medicine'),
              trailing: postModel.tablets
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : Icon(Icons.circle, color: Colors.red),
            ),
          if (postModel.ventilator)
            ListTile(
              leading: Text('ICU & Ventilator'),
              trailing: postModel.ventilator
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : Icon(Icons.circle, color: Colors.red),
            ),
          ListTile(
            leading: postLabel('Contact Information'),
            title: Text(postModel.contact),
          ),
          ListTile(
            leading: postLabel('Address/ Other details'),
            title: Text(postModel.address),
          )
        ],
      ),
    );
  }

  Widget postLabel(String label) {
    return Text(label,
        textScaleFactor: 1.0,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontWeight: FontWeight.w600, color: CustomColors().primaryColor));
  }

  Widget _dateDisplay(String timedisplay) {
    var loadedTime = DateTime.parse(timedisplay);
    final now = new DateTime.now();
    final difference = now.difference(loadedTime);
    var timediff = timeago.format(now.subtract(difference), locale: 'en');
    print(timediff);

    return Text(timediff);
  }

  Widget searchCard({String iconPath, String title, Function onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onPressed,
        child: Card(
          color: Colors.white,
          elevation: 4.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                iconPath,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(title, style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }
}
