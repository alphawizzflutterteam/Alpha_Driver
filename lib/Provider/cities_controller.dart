import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:work/Models/cities_model.dart';
import '../utilities/api_manager/apis.dart';
import '../utilities/api_manager/http_client.dart';

class CityController extends GetxController {
  RxBool isLoading = false.obs;
  RxString selectedCity = 'Andhra Pradesh'.obs;
  Rx<CitiesModel>? citiesList;
  RxList<Datuc>? citiesListItems;
}
