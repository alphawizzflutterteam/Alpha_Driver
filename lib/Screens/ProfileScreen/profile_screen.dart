import 'dart:convert';

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
  getProfile() async {
    final res = await HTTPClient.getProfileResponse(APIs.profile);

    if (res.status == true) {
      SharedPref.shared.pref?.setString(PrefKeys.name, res.data[0].fName);

      SharedPref.shared.pref
          ?.setString(PrefKeys.userDetails, jsonEncode(res.data[0]));
    } else {
      Utils.showFlushBarWithMessage(
        'Something went wrong!!!',
        Get.context!,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    //  getProfile();
    var model =
        jsonDecode(SharedPref.shared.pref!.getString(PrefKeys.userDetails)!);

    Datum user = Datum.fromJson(model);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        toolbarHeight: height * 0.23,
        flexibleSpace: ProfileCard(
          name: user.fName,
          email: user.email,
          phone: user.phone,
          onPress: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const EditProfile()));
          },
          image: user.image,
        ),
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
                      builder: (context) => const EditDrivingLicence()));
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
                      builder: (context) => const EditBankingInformation()));
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FAQs()));
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
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => Navigator.pop(ctx),
                                  child: Container(
                                    height: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
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
                                      borderRadius: BorderRadius.circular(10),
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
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: appThemeColor),
          padding: EdgeInsets.all(defaultPadding),
          child: SvgPicture.asset('assets/icons/chat.svg'),
        ),
      ),
    );
  }
}
