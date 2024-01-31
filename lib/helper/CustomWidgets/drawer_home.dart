import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:work/Models/profileModel.dart';
import 'package:work/Screens/HomeScreen/NewOrder/new_order.dart';
import 'package:work/Screens/PaymentScreen/payment_screen.dart';
import 'package:work/Screens/ProfileScreen/profile_screen.dart';
import 'package:work/Screens/SinginScreens/SignInWithPhone/sign_in_wit_phone.dart';
import 'package:work/Screens/WalletScreen/wallet_screen.dart';
import 'package:work/Screens/allOrders/allOrderScreen.dart';
import 'package:work/Screens/review/ui/reviewScreen.dart';
import 'package:work/helper/app_constant.dart';
import 'package:work/utilities/shared_pref..dart';

import '../../utilities/color.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var name = SharedPref.shared.pref?.getString(PrefKeys.name);
    var image = SharedPref.shared.pref?.getString(PrefKeys.image);
    print(name);
    var th = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: appPrimaryColor,
        borderRadius: BorderRadius.zero,
      ),
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        backgroundColor: appColorWhite,
        surfaceTintColor: appPrimaryColor,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.16,
              padding: const EdgeInsets.only(bottom: defaultPadding),
              decoration: BoxDecoration(
                color: appPrimaryColor,
                image: const DecorationImage(
                  image: AssetImage("assets/images/onboarding_bg-light.png"),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ListTile(
                  horizontalTitleGap: 10,
                  leading: //Text(""),
                      SizedBox(
                    width: 40.0, // Set your desired width
                    height: 40.0, // Set your desired height
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: image ?? "",
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
                  title: Text(name!,
                      style: th.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: appColorWhite,
                      )),
                  subtitle: SizedBox(
                    height: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('View profile',
                            style: th.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: colors.lightTextColor,
                            )),
                        Container(
                          height: 0.5,
                          width: 73,
                          color: colors.lightTextColor,
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Get.back();
                    Get.to(const ProfileScreen());
                  },
                ),
              ),
            ),
            ListTile(
              title: Text('Overview',
                  style: th.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: appColorBlack,
                  )),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/order.svg',
                color: appColorBlack,
              ),
              title: Text('New Order',
                  style: th.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: appColorBlack,
                  )),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewOrderScreen()));
              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.doc_plaintext),
              title: Text('Work Order',
                  style: th.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: appColorBlack,
                  )),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.doc_plaintext),
              title: Text('All Orders',
                  style: th.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: appColorBlack,
                  )),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AllOrderScreen(
                              status: '',
                            )));
              },
            ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/Wallet.svg',
              ),
              title: Text('Wallet',
                  style: th.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: appColorBlack,
                  )),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WalletScreen()));
              },
            ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/pymt.svg',
              ),
              title: Text('Payment',
                  style: th.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: appColorBlack,
                  )),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PaymentScreen()));
              },
            ),
            // ListTile(
            //   leading: SvgPicture.asset(
            //     'assets/icons/Star.svg',
            //   ),
            //   title: Text('Rating',
            //       style: th.bodyMedium?.copyWith(
            //         fontWeight: FontWeight.w700,
            //         color: appColorBlack,
            //       )),
            //   onTap: () {
            //     Get.back();
            //     Get.to(const ReviewScreen());
            //   },
            // ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.34,
            ),
            InkWell(
              onTap: () {
                SharedPref.shared.pref?.setString(PrefKeys.isLoggedIn, "0");

                Get.offAll(const SignInWithPhone());
              },
              child: ListTile(
                leading: SvgPicture.asset('assets/icons/Logout.svg'),
                title: Text('Logout',
                    style: th.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.red,
                    )),
                onTap: () {
                  SharedPref.shared.pref?.setString(PrefKeys.isLoggedIn, "0");

                  Get.offAll(const SignInWithPhone());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
