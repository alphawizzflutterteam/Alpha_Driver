import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:work/Provider/cities_controller.dart';

import '../Models/states_model.dart';
import '../utilities/api_manager/apis.dart';
import '../utilities/api_manager/http_client.dart';

class StateController extends GetxController {
  RxBool isLoading = false.obs;
  final selectedState = 'Andhra Pradesh'.obs;
  Rx<StateModel>? stateList;
  //RxList<Datus>? stateListItems;
  final stateId = 4039.obs;
}
