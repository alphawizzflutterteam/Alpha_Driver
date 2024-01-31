import 'package:get/get.dart';
import 'package:work/Screens/HomeScreen/NotificationScreen/model/notificationsModel.dart';
import 'package:work/utilities/api_manager/apis.dart';
import 'package:work/utilities/api_manager/http_client.dart';

class NotificationsController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<NotificationModel>? notificaitonModel;
  RxList<Notifications> noti = <Notifications>[].obs;

  getNotifiHistory() async {
    isLoading = true.obs;
    update();

    final res = await HTTPClient.getNotifications(APIs.notifications);
    notificaitonModel = res.obs;
    noti = notificaitonModel!.value.notifications.obs;
    isLoading = false.obs;
    update();
  }
}
