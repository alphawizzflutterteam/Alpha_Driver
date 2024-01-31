import 'package:get/get.dart';
import 'package:work/Models/reviewModel.dart';
import 'package:work/utilities/api_manager/apis.dart';

import '../utilities/api_manager/http_client.dart';

class ReviewController extends GetxController {
  Rx<ReviewModel>? model;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    getReviews();
    super.onInit();
  }

  getReviews() async {
    isLoading = true.obs;
    update();

    final res = await HTTPClient.getReviewList(APIs.reviews);
    model = res.obs;

    isLoading = false.obs;
    update();
    update();
  }
}
