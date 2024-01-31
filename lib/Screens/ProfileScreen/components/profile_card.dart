import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:work/helper/app_constant.dart';
import 'package:work/utilities/app_color.dart';
import 'package:work/utilities/mediaQuery.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String image;
  final VoidCallback onPress;
  const ProfileCard(
      {super.key,
      required this.name,
      required this.email,
      required this.phone,
      required this.onPress,
      required this.image});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    final th = Theme.of(context).textTheme;
    return Container(
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
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.chevron_left,
                            color: appColorWhite,
                          )),
                      Text(
                        'Profile',
                        style: th.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700, color: appColorWhite),
                      ),
                      GestureDetector(
                          onTap: onPress,
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
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: th.bodyLarge?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: appColorWhite),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                email,
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
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                phone,
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
    );
  }
}
