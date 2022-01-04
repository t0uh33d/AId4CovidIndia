import 'package:flutter/material.dart';
import 'package:oxygenforcovid/shared/colors.dart';

class LegalDisclaimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors().primaryColor,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Legal Disclaimer',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Text(
                  'This is an volunteer-drive, crowd sourced website. The site owner(s), volunteers or people associated with this website take no responsibility for accuracy of the information listed here.'),
              SizedBox(height: 5.0),
              Text(
                  'We are neither associated or are responsible for with businesses, individuals that have been listed here. While we have tried our level best to only include correct and available resources; we cannot guarantee either. Please use your better judgement while contacting any of the resources listed. If you are listed here and want to get de-listed, please contact us via email.')
            ],
          ),
        ),
      ),
    );
  }
}
