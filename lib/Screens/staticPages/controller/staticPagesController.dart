import 'package:get/get.dart';
import 'package:work/Screens/staticPages/model/staticPagesModel.dart';
import 'package:work/utilities/api_manager/apis.dart';

import '../../../utilities/api_manager/http_client.dart';

class StaticPagesController extends GetxController {
  RxBool isLoading = false.obs;

  late Rx<StaticPagesModel> model;

  getStaticPages() async {
    isLoading = true.obs;

    update();
    try {
      final res = await HTTPClient.getStaticPagesData(APIs.staticPages);
      model = res.obs;
    } catch (stacktrace) {
      print(stacktrace.toString());
    }

    isLoading = false.obs;
    update();
  }
}
