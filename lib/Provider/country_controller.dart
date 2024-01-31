import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:work/Models/cities_model.dart';
import 'package:work/Models/states_model.dart';
import 'package:work/Provider/state_controller.dart';

import '../Models/country_model.dart';
import '../utilities/api_manager/apis.dart';
import '../utilities/api_manager/http_client.dart';

class CountryController extends GetxController {
  RxBool isLoading = false.obs;
  //RxString selectedCountry = 'Select Country'.obs;
}
