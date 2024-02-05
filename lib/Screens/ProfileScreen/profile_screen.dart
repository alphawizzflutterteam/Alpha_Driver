import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:work/Provider/edit_profile_controller.dart';
import 'package:work/Screens/ProfileScreen/Chat/chatScreen.dart';
import 'package:work/Screens/ProfileScreen/Faq/faqScreen.dart';
import 'package:work/Screens/ProfileScreen/components/menu_type.dart';
import 'package:work/Screens/ProfileScreen/components/profile_card.dart';
import 'package:work/Screens/ProfileScreen/editProfiePages/edit_address_detail.dart';
import 'package:work/Screens/ProfileScreen/editProfiePages/edit_banking_info.dart';
import 'package:work/Screens/ProfileScreen/editProfiePages/edit_drriving_licence_info.dart';
import 'package:work/Screens/ProfileScreen/editProfiePages/edit_passsword.dart';
import 'package:work/Screens/ProfileScreen/editProfiePages/edit_vechicle_detail.dart';
import 'package:work/Screens/ProfileScreen/edit_profile.dart';
import 'package:work/Screens/SinginScreens/SignInWithPhone/sign_in_wit_phone.dart';
import 'package:work/helper/CustomWidgets/logoutSheet.dart';
import 'package:work/helper/app_constant.dart';
import 'package:work/utilities/api_manager/apis.dart';
import 'package:work/utilities/api_manager/http_client.dart';
import 'package:work/utilities/app_color.dart';
import 'package:work/utilities/color.dart';
import 'package:work/utilities/shared_pref..dart';
import 'package:work/utilities/utils.dart';

import '../../Models/profileModel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final EditProfileController editProfileController =
      Get.put(EditProfileController());

  @override
  void initState() {
    super.initState();
    editProfileController.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    //  getProfile();

    final th = Theme.of(context).textTheme;

    return GetBuilder<EditProfileController>(builder: (controller) {
      return controller.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  toolbarHeight: height * 0.23,
                  flexibleSpace: Container(
                    color: appBarColor,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned(
                            top: 0,
                            bottom: 0,
                            right: -30,
                            child: Image.asset(
                              'assets/icons/bg.png',
                            )),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16.0),
                              bottomRight: Radius.circular(16.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: height * 0.08,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: defaultPadding),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.chevron_left,
                                          color: appColorWhite,
                                          size: 30,
                                        )),
                                    Text(
                                      'Profile',
                                      style: th.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                          color: appColorWhite),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const EditProfile()));
                                        },
                                        child: Image.asset(
                                          "assets/images/edit_btn.png",
                                          height: 25,
                                          width: 25,
                                        )),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: const EdgeInsets.all(defaultPadding),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: SizedBox(
                                        width: 70.0, // Set your desired width
                                        height: 70.0, // Set your desired height
                                        child: ClipOval(
                                          child: CachedNetworkImage(
                                            imageUrl: controller.user.image,
                                            fit: BoxFit.cover,
                                            errorWidget:
                                                (context, url, error) =>
                                                    ClipOval(
                                              child: Image.asset(
                                                "assets/images/profile.png",
                                                fit: BoxFit.cover,
                                                width:
                                                    70.0, // Set your desired width
                                                height: 70.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.user.fName,
                                          style: th.bodyLarge?.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: appColorWhite),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.email_outlined,
                                              size: 12,
                                              color: appColorWhite,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              controller.user.email,
                                              style: th.bodyLarge?.copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: appColorWhite),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.phone,
                                              size: 12,
                                              color: appColorWhite,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              controller.user.phone,
                                              style: th.bodyLarge?.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: appColorWhite),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                  //  ProfileCard(
                  //   name: user.fName,
                  //   email: user.email,
                  //   phone: user.phone,
                  //   onPress: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) => const EditProfile()));
                  //   },
                  //   image: user.image,
                  // ),
                  ),
              body: ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  MenuType(
                    svgPath: 'assets/icons/vechile.svg',
                    type: 'Vehicle Info',
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditVehicleDetail()));
                    },
                  ),
                  const Divider(),
                  MenuType(
                    svgPath: 'assets/icons/user.svg',
                    type: 'Driving\' Licencse',
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const EditDrivingLicence()));
                    },
                  ),
                  const Divider(),
                  MenuType(
                    svgPath: 'assets/icons/Location.svg',
                    type: 'Address Information',
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditAddressDetail()));
                    },
                  ),
                  const Divider(),
                  MenuType(
                    svgPath: 'assets/icons/Paper.svg',
                    type: 'Bank Information',
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const EditBankingInformation()));
                    },
                  ),
                  // Divider(),
                  // MenuType(
                  //   svgPath: 'assets/icons/earphn.svg',
                  //   type: 'Customer support',
                  //   function: () {},
                  // ),
                  const Divider(),
                  MenuType(
                    svgPath: 'assets/icons/faq.svg',
                    type: 'FAQs',
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FAQs()));
                    },
                  ),
                  const Divider(),
                  MenuType(
                    svgPath: 'assets/icons/Unlock.svg',
                    type: 'Change password',
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditConfirmPassword(
                                    forLogin: true,
                                  )));
                    },
                  ),
                  //       Divider(),
                  //       MenuType(icon: Icons.lock_open_outlined, type: 'Change password',function: (){
                  //
                  // },),
                  // Divider(),
                  // MenuType(
                  //   svgPath: 'assets/icons/currency.svg',
                  //   type: 'Currency',
                  //   function: () {},
                  // ),
                  // Divider(),
                  // MenuType(
                  //   svgPath: 'assets/icons/language.svg',
                  //   type: 'Change Language',
                  //   function: () {},
                  // ),
                  // Divider(),
                  // MenuType(
                  //   svgPath: 'assets/icons/Location.svg',
                  //   type: 'Change Theme',
                  //   function: () {},
                  // ),
                  const Divider(),
                  MenuType(
                    svgPath: 'assets/icons/Unlock.svg',
                    type: 'Delete Account',
                    function: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            // height: height * .35,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: colors.lightGrey,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    "assets/images/deactivate.png",
                                    fit: BoxFit.contain,
                                    color: Colors.black,
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      'Are you sure want to delete account ',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 18),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () => Navigator.pop(ctx),
                                          child: Container(
                                            height: 40,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Color(0xFFC3C5DD),
                                                width: 1,
                                              ),
                                            ),
                                            child: Text(
                                              'CANCEL',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      VerticalDivider(),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.back();
                                            Get.find<EditProfileController>()
                                                .deleteAccount();
                                          },
                                          //                     onTap: () =>
                                          //                         profilePro.deleteAccount().then((value) {
                                          //                       if (value) {
                                          //                        SharedPref.shared.pref!.setString(PrefKeys.isLoggedIn, "0");
                                          // SharedPref.shared.pref!.setString(PrefKeys.token, "");
                                          //                         Navigator.pop(ctx);
                                          //                       //   Navigator.pushAndRemoveUntil(
                                          //                       //       context,
                                          //                       //       MaterialPageRoute(
                                          //                       //         builder: (context) => LoginPage(),
                                          //                       //       ),
                                          //                       //       (route) => false);
                                          //                       // } else {
                                          //                       //   Navigator.pop(ctx);
                                          //                       // }
                                          //                     }),

                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Color(0xFF0A9494),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              'DELETE',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Divider(),
                  MenuType(
                    svgPath: 'assets/icons/Logout.svg',
                    type: 'Logout',
                    function: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => LogoutSheet(),
                      );
                    },
                  ),
                  Divider(),
                ],
              ),
              floatingActionButton: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(),
                    )),
                child: Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: appThemeColor),
                  padding: EdgeInsets.all(defaultPadding),
                  child: SvgPicture.asset('assets/icons/chat.svg'),
                ),
              ),
            );
    });
  }
}
