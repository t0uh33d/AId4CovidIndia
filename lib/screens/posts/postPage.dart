import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:oxygenforcovid/controllers/postController.dart';
import 'package:oxygenforcovid/models/plasmaModel.dart';
import 'package:oxygenforcovid/screens/posts/locationSearch.dart';
import 'package:oxygenforcovid/screens/posts/userPosts.dart';
import 'package:oxygenforcovid/shared/colors.dart';
import 'package:oxygenforcovid/shared/loader.dart';
import 'package:oxygenforcovid/shared/theme.dart';
import 'package:oxygenforcovid/shared/widgets.dart';
import 'dart:convert';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  bool loading = false;
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var postController = Get.put(PostController());
    return loading
        ? Loader()
        : Scaffold(
            backgroundColor: CustomColors().backgroundColor,
            appBar:
                CustomWidgets().centerTitleAppBar(title: 'Post Availability'),
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  color: Colors.white,
                  width: size.width > 650 ? 650 : size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: postController.formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // name field
                          CustomWidgets().formLabel(label: 'Name *'),
                          SizedBox(height: 5.0),
                          TextFormField(
                            decoration: otpinputDecoration,
                            controller: postController.nameController,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                      'Please enter donor/organization name')
                            ]),
                          ),
                          SizedBox(height: 10.0),

                          // availability field
                          CustomWidgets().formLabel(label: 'Availability *'),
                          SizedBox(height: 5.0),
                          // plasma data
                          Card(
                            color: Colors.white,
                            elevation: 2.0,
                            child: Obx(() {
                              return SwitchListTile(
                                value: postController.plasmaAvail.value,
                                onChanged: (bool value) {
                                  postController.plasmaChange(value);
                                },
                                title: Text('Plasma'),
                                subtitle: postController.plasmaAvail.value
                                    ? Text('Select blood group(s)')
                                    : SizedBox(),
                              );
                            }),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(() {
                              if (postController.plasmaAvail.value) {
                                return GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10),
                                    itemCount:
                                        postController.plamsaGroupList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CustomWidgets().plasmaCircle(
                                          label: postController
                                              .plamsaGroupList[index].label,
                                          isSelected: postController
                                              .plamsaGroupList[index]
                                              .isSelected
                                              .value,
                                          onTap: () {
                                            setState(() {
                                              postController
                                                  .plamsaGroupList[index]
                                                  .isSelected(!postController
                                                      .plamsaGroupList[index]
                                                      .isSelected
                                                      .value);
                                            });
                                            postController.addToList(
                                                postController
                                                    .plamsaGroupList[index]
                                                    .label,
                                                select: postController
                                                    .plamsaGroupList[index]
                                                    .isSelected
                                                    .value);
                                          });
                                    });
                              } else {
                                return SizedBox();
                              }
                            }),
                          ),

                          // Oxygen cylinder data
                          Card(
                            color: Colors.white,
                            elevation: 2.0,
                            child: Obx(() {
                              return SwitchListTile(
                                  value: postController.oxygenAvail.value,
                                  onChanged: (bool value) {
                                    postController.oxygenChange(value);
                                  },
                                  title: Text('Oxygen Cylinder'));
                            }),
                          ),

                          // bed data
                          Card(
                            color: Colors.white,
                            elevation: 2.0,
                            child: Obx(() {
                              return SwitchListTile(
                                  value: postController.bedAvail.value,
                                  onChanged: (bool value) {
                                    postController.bedChange(value);
                                  },
                                  title: Text('Hospital Beds'));
                            }),
                          ),

                          // injections
                          Card(
                            color: Colors.white,
                            elevation: 2.0,
                            child: Obx(() {
                              return SwitchListTile(
                                  value: postController.injections.value,
                                  onChanged: (bool value) {
                                    postController.injectionChange(value);
                                  },
                                  title: Text('Covid Vaccines'));
                            }),
                          ),

                          // tablets
                          Card(
                            color: Colors.white,
                            elevation: 2.0,
                            child: Obx(() {
                              return SwitchListTile(
                                  value: postController.tablets.value,
                                  onChanged: (bool value) {
                                    postController.tabletChange(value);
                                  },
                                  title: Text('Covid Medicine'));
                            }),
                          ),

                          // ventilators
                          Card(
                            color: Colors.white,
                            elevation: 2.0,
                            child: Obx(() {
                              return SwitchListTile(
                                  value: postController.ventilator.value,
                                  onChanged: (bool value) {
                                    postController.ventilatorChange(value);
                                  },
                                  title: Text('ICU & Ventilator'));
                            }),
                          ),

                          //contact field
                          SizedBox(height: 10.0),
                          CustomWidgets()
                              .formLabel(label: 'Contact Information *'),
                          SizedBox(
                            height: 5.0,
                          ),
                          TextFormField(
                            maxLines: 5,
                            decoration: otpinputDecoration,
                            controller: postController.contactController,
                            validator: RequiredValidator(
                                errorText: 'Please enter Contact information'),
                          ),

                          // Location
                          SizedBox(height: 10.0),
                          CustomWidgets().formLabel(label: 'Select Location *'),
                          SizedBox(height: 5.0),
                          Obx(() {
                            return ListTile(
                              tileColor: Colors.white,
                              leading: Icon(
                                Icons.location_on_outlined,
                                color: CustomColors().primaryColor,
                              ),
                              title: Text(
                                postController.location.value,
                                style: TextStyle(
                                    color: CustomColors().primaryColor),
                              ),
                              onTap: () {
                                // location sheet widget
                                Get.to(LocationSearch());

                                // location sheet widget end
                              },
                            );
                          }),

                          // Address
                          SizedBox(height: 10.0),
                          CustomWidgets().formLabel(
                              label:
                                  'Address / Any relevant information (optional)'),
                          SizedBox(height: 5.0),
                          TextFormField(
                            maxLines: 5,
                            decoration: otpinputDecoration,
                            controller: postController.addressController,
                          ),
                          SizedBox(height: 10.0),
                          SizedBox(
                              width: double.infinity,
                              height: size.width > 650
                                  ? size.width * 0.04
                                  : size.width * 0.1,
                              child: CustomWidgets().customRaisedButton(
                                  buttonText: 'Submit',
                                  onpressed: () async {
                                    setState(() {
                                      loading = true;
                                    });

                                    await postController.validatePost();

                                    Future.delayed(Duration(seconds: 1), () {
                                      setState(() {
                                        loading = false;
                                      });
                                    });
                                  }))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}
