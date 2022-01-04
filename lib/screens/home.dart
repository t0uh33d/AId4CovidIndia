import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:oxygenforcovid/controllers/authController.dart';
import 'package:oxygenforcovid/controllers/postController.dart';
import 'package:oxygenforcovid/screens/helpingHand/helpingLocation.dart';
import 'package:oxygenforcovid/screens/index.dart';
import 'package:oxygenforcovid/screens/legalDisclaimer.dart';
import 'package:oxygenforcovid/screens/posts/postPage.dart';
import 'package:oxygenforcovid/screens/requests/postRequest.dart';
import 'package:oxygenforcovid/screens/requests/userRequests.dart';
import 'package:oxygenforcovid/screens/posts/userPosts.dart';
import 'package:oxygenforcovid/screens/search/locationSet.dart';
import 'package:oxygenforcovid/services/database.dart';
import 'package:oxygenforcovid/shared/colors.dart';
import 'package:oxygenforcovid/shared/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //  var postController = Get.put(PostController());
    var authController = Get.find<AuthController>();
    return Scaffold(
      backgroundColor: CustomColors().backgroundColor,
      appBar: CustomWidgets().centerTitleAppBar(title: 'Home', share: true),
      drawer: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.network(
              'https://pbs.twimg.com/profile_banners/1387947324245102593/1619749531/1500x500',
              fit: BoxFit.fitWidth,
            ),
            InkWell(
              onTap: () {
                Get.to(LegalDisclaimer());
              },
              child: ListTile(
                leading: Icon(Icons.warning, color: Colors.yellow),
                title: Text('Legal disclaimer'),
              ),
            ),
            InkWell(
              onTap: () async {
                await authController.signOut();
                Get.offAll(IndexPage());
              },
              child: ListTile(
                leading: Icon(Icons.power_settings_new, color: Colors.red),
                title: Text('Log out'),
              ),
            ),
            Divider(thickness: 0.5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomWidgets().formLabel(label: 'Contact Us:'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    icon: Image.asset('lib/assets/instagram.png'),
                    onPressed: () async {
                      await launch(
                          'https://www.instagram.com/aid4covidindia.official/');
                    }),
                IconButton(
                    icon: Image.asset('lib/assets/twitter.png'),
                    onPressed: () async {
                      await launch('https://twitter.com/aid4covidindia');
                    }),
                IconButton(
                    icon: Image.asset('lib/assets/facebook.png'),
                    onPressed: () async {
                      await launch(
                          'https://www.facebook.com/aidforcovid.india');
                    }),
              ],
            )
          ],
        ),
      ),
      body: Center(
        child: Container(
            height: size.height,
            color: Colors.white,
            width: size.width > 650 ? 650 : size.width,
            child: StaggeredGridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              staggeredTiles: [
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 1),
              ],
              children: [
                // post row
                CustomWidgets().homeCard(
                    imagePath: 'lib/assets/add-file.png',
                    cardTitle: 'Add Availability',
                    onPressed: () => Get.to(PostPage()),
                    cardInfo:
                        'Add information regarding availability of Covid resources, Plasma donations etc.'),

                CustomWidgets().homeCard(
                    imagePath: 'lib/assets/platelet.png',
                    cardTitle: 'Your posts',
                    cardInfo: 'View/delete your posts',
                    onPressed: () {
                      Get.to(UserPosts());
                    }),

                // request row
                CustomWidgets().homeCard(
                    imagePath: 'lib/assets/add-file.png',
                    cardTitle: 'Your requests',
                    onPressed: () => Get.to(UserRequests()),
                    cardInfo: 'View/Delete your requests'),
                CustomWidgets().homeCard(
                    imagePath: 'lib/assets/help.png',
                    cardTitle: 'Request',
                    onPressed: () => Get.to(PostRequest()),
                    cardInfo: 'Request for the resources you are seeking for'),

                // search row
                CustomWidgets().homeCard(
                    imagePath: 'lib/assets/helping.png',
                    cardTitle: 'Helping hand',
                    onPressed: () => Get.to(HelpingLocation()),
                    cardInfo: 'View requests posted by other people near you'),
                CustomWidgets().homeCard(
                    imagePath: 'lib/assets/search.png',
                    cardTitle: 'Search',
                    cardInfo: 'Search for the resources based on location',
                    onPressed: () => Get.to(SetLocation())),
              ],
            )),
      ),
    );
  }
}
