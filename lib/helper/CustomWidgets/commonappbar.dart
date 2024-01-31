import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:work/Screens/HomeScreen/home_screen.dart';
import 'package:work/helper/CustomWidgets/comman_header.dart';
import 'package:work/utilities/color.dart';

class CommanAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String appbarTitle;
  final bool forHome;

  const CommanAppbar(
      {super.key, required this.appbarTitle, required this.forHome});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: InkWell(
        onTap: () {
          if (forHome) {
            Get.offAll(const HomeScreen());
          } else {
            Get.back();
          }
        },
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 25,
          color: Colors.white,
        ),
      ),
      title: Text(
        appbarTitle,
        style: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      flexibleSpace: Container(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.transparent
            : colors.buttonColor,
        child: const Stack(
          children: [
            ProfileHeader(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
