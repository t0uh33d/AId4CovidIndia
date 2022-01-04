import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:oxygenforcovid/auth/switchAuth.dart';
import 'package:oxygenforcovid/controllers/authController.dart';
import 'package:oxygenforcovid/screens/search/locationSet.dart';
import 'package:oxygenforcovid/shared/colors.dart';
import 'package:oxygenforcovid/shared/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'helpingHand/helpingLocation.dart';

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var authController = Get.put(AuthController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors().backgroundColor,
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Center(
            child: Container(
              color: Colors.white,
              width: size.width > 650 ? 650 : size.width,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'lib/assets/logo_transparent.png',
                        width: size.width > 650
                            ? size.width * 0.15
                            : size.width * 0.25,
                        height: size.width > 650
                            ? size.width * 0.15
                            : size.width * 0.25,
                      ),
                      Column(
                        children: [
                          Text(
                            'Aid4CovidIndia.in',
                            style: TextStyle(
                                color: CustomColors().redColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Covid resources near you',
                            style: TextStyle(
                                color: CustomColors().greenColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  StaggeredGridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    staggeredTiles: [
                      StaggeredTile.count(1, 1),
                      StaggeredTile.count(1, 1),
                      StaggeredTile.count(1, 1),
                      StaggeredTile.count(1, 1),
                    ],
                    children: [
                      CustomWidgets().homeCard(
                          imagePath: 'lib/assets/add-file.png',
                          cardTitle: 'Add Availability',
                          onPressed: () => Get.to(Authenticate()),
                          cardInfo:
                              'Add information regarding availability of Covid resources, Plasma donations etc.'),

                      CustomWidgets().homeCard(
                          imagePath: 'lib/assets/search.png',
                          cardTitle: 'Search',
                          cardInfo:
                              'Search for the resources based on location',
                          onPressed: () => Get.to(SetLocation())),

                      CustomWidgets().homeCard(
                          imagePath: 'lib/assets/help.png',
                          cardTitle: 'Request',
                          onPressed: () => Get.to(Authenticate()),
                          cardInfo:
                              'Request for the resources you are seeking for'),

                      // search row
                      CustomWidgets().homeCard(
                          imagePath: 'lib/assets/helping.png',
                          cardTitle: 'Helping hand',
                          onPressed: () => Get.to(HelpingLocation()),
                          cardInfo:
                              'View requests posted by other people near you'),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
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
          ),
        ),
      ),
    );
  }
}
