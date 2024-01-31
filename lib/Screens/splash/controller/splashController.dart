import 'package:get/get.dart';
import 'package:work/Screens/HomeScreen/home_screen.dart';
import 'package:work/Screens/SinginScreens/SignInWithPhone/sign_in_wit_phone.dart';
import 'package:work/utilities/shared_pref..dart';

class SplashController extends GetxController {
  int? userId = 0;

  @override
  void onInit() {
    SharedPref.shared.getPref();
    var isLoggedIn = SharedPref.shared.pref?.getString(PrefKeys.isLoggedIn);

    Future.delayed(const Duration(seconds: 3), () {
      if (isLoggedIn == "1") {
        Get.offAll(const HomeScreen());
      } else {
        Get.offAll(const SignInWithPhone());
      }
    });

    super.onInit();
  }
}
