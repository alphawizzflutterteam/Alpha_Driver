import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:work/Models/profileModel.dart';
import 'package:work/Provider/edit_profile_controller.dart';
import 'package:work/helper/CustomWidgets/base_scaffold.dart';
import 'package:work/helper/app_constant.dart';
import 'package:work/utilities/color.dart';
import 'package:work/utilities/shared_pref..dart';

import '../../helper/CustomWidgets/custom_button.dart';
import '../../helper/CustomWidgets/custom_text_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  var image = "";
  final EditProfileController controller = Get.put(EditProfileController());
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    numberController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          controller.selecteduserImage = File(pickedFile.path);
          controller.uploadFile(context);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    var model =
        jsonDecode(SharedPref.shared.pref!.getString(PrefKeys.userDetails)!);

    Datum user = Datum.fromJson(model);
    image = user.image;
    nameController.text = user.fName;
    emailController.text = user.email;
    numberController.text = user.phone;
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Theme.of(context).brightness != Brightness.dark
              ? Colors.white
              : colors.overlayBG,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: Theme.of(context).brightness != Brightness.dark
                      ? colors.darkBG
                      : Colors.white,
                ),
                title: Text(
                  'Choose from Gallery',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).brightness != Brightness.dark
                            ? colors.darkBG
                            : Colors.white,
                      ),
                ),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.camera_alt,
                  color: Theme.of(context).brightness != Brightness.dark
                      ? colors.darkBG
                      : Colors.white,
                ),
                title: Text(
                  'Take a Picture',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).brightness != Brightness.dark
                            ? colors.darkBG
                            : Colors.white,
                      ),
                ),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        title: "Edit Profile",
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  height: 120,
                  child: Stack(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 120.0, // Set your desired width
                          height: 120.0, // Set your desired height
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: image,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => ClipOval(
                                child: Image.asset(
                                  "assets/images/profile.png",
                                  fit: BoxFit.cover,
                                  width: 70.0, // Set your desired width
                                  height: 70.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () {
                          //   profileProvider.pickFile(context);
                          _showImagePickerOptions(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.edit,
                            ),
                            Text("Edit Image")
                          ],
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: nameController,
                labelText: 'Full Name',
                hintText: '',
                enabled: false,
                inputFormatters: [],
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: emailController,
                labelText: 'Personal Email ID',
                hintText: '',
                enabled: false,
                inputFormatters: [],
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: numberController,
                keyboardType: TextInputType.datetime,
                labelText: 'Personal Phone Number',
                hintText: '',
                enabled: false,
                inputFormatters: [],
              ),
              const SizedBox(height: 30),
              // CustomButtonWidget(
              //     text: 'SAVE',
              //     onPressed: () {
              //       Navigator.pop(context);
              //     }),
            ],
          ),
        ));
  }
}
