// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:path/path.dart' as fileUtil;
import 'package:work/Models/country_model.dart';
import 'package:work/Models/orderDetailModelNew.dart';
import 'package:work/Models/profileModel.dart';
import 'package:work/Models/reviewModel.dart';
import 'package:work/Models/states_model.dart';
import 'package:work/Screens/HomeScreen/NewOrder/model/newOrderModel.dart';
import 'package:work/Screens/HomeScreen/NotificationScreen/model/notificationsModel.dart';
import 'package:work/Screens/ProfileScreen/Chat/model/chatModel.dart';
import 'package:work/Screens/WalletScreen/model/transactionModel.dart';
import 'package:work/Screens/WalletScreen/model/withdrawModel.dart';
import 'package:work/Screens/staticPages/model/staticPagesModel.dart';
import 'package:work/utilities/shared_pref..dart';

import '../../Models/cities_model.dart';

typedef OnDownloadProgressCallback = void Function(
    int receivedBytes, int totalBytes);
typedef OnUploadProgressCallback = void Function(int sentBytes, int totalBytes);

class HTTPClient {
  static Future<Map<String, dynamic>> postRequest(String api, Map params,
      {String type = "raw"}) async {
    // var userid = SharedPref.shared.pref?.getInt(PrefKeys.userId);
    // var sCode = SharedPref.shared.pref?.getString(PrefKeys.sCode);
    final url = Uri.parse(api);
    final http.Response res;

    Get.log(
        "========================================================================================================");
    Get.log(
        "-------------------------------------------- URL --------------------------------------------");
    Get.log("url: $url");
    Get.log(
        "-------------------------------------------- PARAMETERS --------------------------------------------");
    Get.log("params: $params");
    var token = SharedPref.shared.pref!.getString(PrefKeys.token) ?? "";

    res = await http
        .post(url, body: type == "raw" ? jsonEncode(params) : params, headers: {
      // 'apiusername': APIs.apiUserName,
      // 'apipassword': APIs.apipassword,
      'Authorization': 'Bearer $token',

      'Content-type': type == "raw"
          ? 'application/json'
          : "application/x-www-form-urlencoded",
    });

    // Get.log("userId $userid");
    // Get.log("userId  $sCode");

    final Map<String, dynamic> json = await jsonDecode(res.body);
    Get.log(
        "-------------------------------------------- RESPONSE --------------------------------------------");

    Get.log(" Response api $json");
    Get.log(
        "========================================================================================================");
    return json;
  }

  static Future<Map<String, dynamic>> putRequest(String api, Map params,
      {String type = "raw"}) async {
    // var userid = SharedPref.shared.pref?.getInt(PrefKeys.userId);
    // var sCode = SharedPref.shared.pref?.getString(PrefKeys.sCode);
    final url = Uri.parse(api);
    final http.Response res;

    Get.log(
        "========================================================================================================");
    Get.log(
        "-------------------------------------------- URL --------------------------------------------");
    Get.log("url: $url");
    Get.log(
        "-------------------------------------------- PARAMETERS --------------------------------------------");
    Get.log("params: $params");
    var token = SharedPref.shared.pref!.getString(PrefKeys.token)!;
    print(token);

    res = await http
        .put(url, body: type == "raw" ? jsonEncode(params) : params, headers: {
      // 'apiusername': APIs.apiUserName,
      // 'apipassword': APIs.apipassword,
      'Authorization': 'Bearer $token',

      'Content-type': type == "raw"
          ? 'application/json'
          : "application/x-www-form-urlencoded",
    });

    // Get.log("userId $userid");
    // Get.log("userId  $sCode");

    final Map<String, dynamic> json = await jsonDecode(res.body);
    Get.log(
        "-------------------------------------------- RESPONSE --------------------------------------------");

    Get.log(" Response api $json");
    Get.log(
        "========================================================================================================");
    return json;
  }

  static bool trustSelfSigned = true;

  static HttpClient getHttpClient() {
    HttpClient httpClient = HttpClient()
      ..connectionTimeout = const Duration(seconds: 100);
    // ..badCertificateCallback =
    //     ((X509Certificate cert, String host, int port) => trustSelfSigned);

    return httpClient;
  }

  static Future<Map<String, dynamic>> postRequestCoordinates(
    String api,
  ) async {
    final url = Uri.parse(api);
    final http.Response res;

    Get.log(
        "========================================================================================================");
    Get.log(
        "-------------------------------------------- URL --------------------------------------------");
    Get.log("$url");
    Get.log(
        "-------------------------------------------- PARAMETERS --------------------------------------------");

    res = await http.post(
      url,
    );

    final Map<String, dynamic> json = await jsonDecode(res.body);
    Get.log(
        "-------------------------------------------- RESPONSE --------------------------------------------");

    Get.log("$json");
    Get.log(
        "========================================================================================================");
    return json;
  }

  static Future<Map<String, dynamic>> multipartRequest(
    String api,
    Map params,
    File licenseImage,
    File vehileImage,
    MediaType mediaType,
  ) async {
    // var userid = SharedPref.shared.pref?.getInt(PrefKeys.userId);
    // var sCode = SharedPref.shared.pref?.getString(PrefKeys.sCode);
    final url = Uri.parse(api);
    Get.log(
        "========================================================================================================");
    Get.log(
        "-------------------------------------------- URL --------------------------------------------");
    Get.log("$url");
    Get.log(
        "-------------------------------------------- PARAMETERS --------------------------------------------");
    Get.log("${licenseImage.path.split('/').last}");
    Get.log("${vehileImage.path.split('/').last}");
    Get.log("$params");

    final length = await licenseImage.length();
    final length2 = await vehileImage.length();

    final request = http.MultipartRequest("POST", url);
    // request.headers["apiusername"] = APIs.apiUserName;
    // request.headers["apipassword"] = APIs.apipassword;
    // request.headers["Content-type"] = "multipart/form-data";
    // request.headers["uid"] = userid.toString();
    // request.headers["scode"] = sCode.toString();

    request.fields["name"] = params["name"];
    request.fields["email"] = params["email"];
    request.fields["phone"] = params["phone"];
    request.fields["fcm_id"] = params["fcm_id"];
    request.fields["password"] = params["password"];
    request.fields["license_number"] = params["license_number"];
    request.fields["license_doi"] = params["license_doi"];
    request.fields["license_exp_date"] = params["license_exp_date"];
    request.fields["license_state"] = params["license_state"];
    request.fields["bank_name"] = params["bank_name"];
    request.fields["branch_name"] = params["branch_name"];
    request.fields["account_type"] = params["account_type"];
    request.fields["micr_code"] = params["micr_code"];
    request.fields["bank_address"] = params["bank_address"];
    request.fields["account_number"] = params["account_number"];
    request.fields["ifsc_code"] = params["ifsc_code"];
    request.fields["address"] = params["address"];
    request.fields["city"] = params["city"];
    request.fields["state"] = params["state"];
    request.fields["country"] = params["country"];
    request.fields["pincode"] = params["pincode"];
    request.fields["vehicle_type"] = params["vehicle_type"];
    request.fields["registeration_number"] = params["registeration_number"];
    request.fields["issue_date"] = params["issue_date"];
    request.fields["expiration_date"] = params["expiration_date"];
    request.fields["policy_number"] = params["policy_number"];
    request.fields["coverage_date"] = params["coverage_date"];
    request.files.add(http.MultipartFile(
        'license_image', licenseImage.readAsBytes().asStream(), length,
        filename: licenseImage.path.split('/').last, contentType: mediaType));
    request.files.add(http.MultipartFile(
        'vehicle_image', vehileImage.readAsBytes().asStream(), length2,
        filename: vehileImage.path.split('/').last, contentType: mediaType));
    final streamRes = await request.send();
    final res = await http.Response.fromStream(streamRes);
    print(res.body);

    final Map<String, dynamic> json = await jsonDecode(res.body);

    return json;
  }

  static Future<Map<String, dynamic>> multipartRequestUserImage(
    String api,
    File userImage,
    MediaType mediaType,
  ) async {
    // var userid = SharedPref.shared.pref?.getInt(PrefKeys.userId);
    // var sCode = SharedPref.shared.pref?.getString(PrefKeys.sCode);
    final url = Uri.parse(api);
    Get.log(
        "========================================================================================================");
    Get.log(
        "-------------------------------------------- URL --------------------------------------------");
    Get.log("$url");
    Get.log(
        "-------------------------------------------- PARAMETERS --------------------------------------------");

    Get.log("${userImage.path.split('/').last}");

    final length = await userImage.length();
    var token = SharedPref.shared.pref!.getString(PrefKeys.token) ?? "";

    final request = http.MultipartRequest("POST", url);
    request.headers.addAll({
      HttpHeaders.authorizationHeader: 'Bearer $token',
    });
    // request.headers["apiusername"] = APIs.apiUserName;
    // request.headers["apipassword"] = APIs.apipassword;
    // request.headers["Content-type"] = "multipart/form-data";
    // request.headers["uid"] = userid.toString();

    request.files.add(http.MultipartFile(
        'image', userImage.readAsBytes().asStream(), length,
        filename: userImage.path.split('/').last, contentType: mediaType));

    final streamRes = await request.send();
    final res = await http.Response.fromStream(streamRes);
    print(res.body);

    final Map<String, dynamic> json = await jsonDecode(res.body);

    return json;
  }

  static Future<Map<String, dynamic>> multipartWithoutFileRequest(
    String api,
    Map params,
  ) async {
    // var userid = SharedPref.shared.pref?.getInt(PrefKeys.userId);
    // var sCode = SharedPref.shared.pref?.getString(PrefKeys.sCode);
    final url = Uri.parse(api);
    Get.log(
        "========================================================================================================");
    Get.log(
        "-------------------------------------------- URL --------------------------------------------");
    Get.log("$url");
    Get.log(
        "-------------------------------------------- PARAMETERS --------------------------------------------");
    Get.log("$params");

    final request = http.MultipartRequest("POST", url);
    // request.headers["apiusername"] = APIs.apiUserName;
    // request.headers["apipassword"] = APIs.apipassword;
    // request.headers["Content-type"] = "multipart/form-data";
    // request.headers["uid"] = userid.toString();
    // request.headers["scode"] = sCode.toString();

    request.fields["loc"] = params["loc"];
    request.fields["width"] = params["width"];
    request.fields["oldfile"] = params["oldfile"];

    final streamRes = await request.send();
    final res = await http.Response.fromStream(streamRes);
    final Map<String, dynamic> json = await jsonDecode(res.body);
    Get.log("response $json");

    return json;
  }

  static Future<Map<String, dynamic>> multipartUploadAPicRequest(
    String api,
    Map params,
    String imgPath,
    // XFile file,
    MediaType mediaType,
  ) async {
    // var userid = SharedPref.shared.pref?.getInt(PrefKeys.userId);
    // var sCode = SharedPref.shared.pref?.getString(PrefKeys.sCode);
    final url = Uri.parse(api);
    Get.log(
        "========================================================================================================");
    Get.log(
        "-------------------------------------------- URL --------------------------------------------");
    Get.log("$url");
    Get.log(
        "-------------------------------------------- PARAMETERS --------------------------------------------");
    Get.log("$params");

    // final length = await file.length();

    final request = http.MultipartRequest("POST", url);
    // request.headers["apiusername"] = APIs.apiUserName;
    // request.headers["apipassword"] = APIs.apipassword;
    // request.headers["Content-type"] = "multipart/form-data";
    // request.headers["uid"] = userid.toString();
    // request.headers["scode"] = sCode.toString();

    request.fields["typeofimport"] = "0";
    request.fields["albumid"] = params["albumid"];
    request.fields["datetime"] = params["datetime"];
    request.fields["angle"] = params["angle"];
    request.fields["geokey"] = params["geokey"];

    // request.files.add(http.MultipartFile(
    //     'file', file.readAsBytes().asStream(), length,
    //     filename: imgPath, contentType: mediaType));
    final streamRes = await request.send();

    final res = await http.Response.fromStream(streamRes);

    final Map<String, dynamic> json = await jsonDecode(res.body);
    return json;
  }

  static Future<String> fileUploadMultipart(
      {String? api,
      Map<String, dynamic>? params,
      required MediaType? mediaType,
      File? file,
      OnUploadProgressCallback? onUploadProgress,
      Function(int)? fileUploaded}) async {
    assert(file != null);
    // var userid = SharedPref.shared.pref?.getInt(PrefKeys.userId);
    // var sCode = SharedPref.shared.pref?.getString(PrefKeys.sCode);

    final url = Uri.parse(api!);

    final httpClient = HttpClient(); //getHttpClient();

    final request = await httpClient.postUrl(Uri.parse(api));

    int byteCount = 0;

    var multipart = await http.MultipartFile.fromPath(
        fileUtil.basename(file!.path), file.path,
        contentType: mediaType);

    // var multipart = http.MultipartFile.fromBytes(
    //     'file', await File.fromUri(Uri.parse(file!.path)).readAsBytes(),
    //     contentType: MediaType('image', 'jpeg'));

    var requestMultipart = http.MultipartRequest("POST", Uri.parse(api));

    // requestMultipart.headers["apiusername"] = APIs.apiUserName;
    // requestMultipart.headers["apipassword"] = APIs.apipassword;
    requestMultipart.headers["Content-type"] = "multipart/form-data";
    // requestMultipart.headers["uid"] = userid.toString();
    // requestMultipart.headers["scode"] = sCode.toString();

    requestMultipart.fields["typeofimport"] = "0";
    requestMultipart.fields["albumid"] = params?["albumid"];
    requestMultipart.fields["datetime"] = params?["datetime"];
    requestMultipart.fields["angle"] = params?["angle"];
    requestMultipart.fields["geokey"] = params?["geokey"];

    requestMultipart.files.add(multipart);

    var msStream = requestMultipart.finalize();

    var totalByteLength = requestMultipart.contentLength;

    request.contentLength = totalByteLength;

    // request.headers.set("apiusername", APIs.apiUserName);
    // request.headers.set("apipassword", APIs.apipassword);
    // request.headers.set("Content-type", "multipart/form-data");
    // request.headers.set("uid", userid.toString());
    // request.headers.set("scode", sCode.toString());
    request.headers.set(HttpHeaders.contentTypeHeader,
        requestMultipart.headers[HttpHeaders.contentTypeHeader]!);

    Stream<List<int>> streamUpload = msStream.transform(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          sink.add(data);

          byteCount += data.length;

          if (onUploadProgress != null) {
            onUploadProgress(byteCount, totalByteLength);
          }
        },
        handleError: (error, stack, sink) {
          throw error;
        },
        handleDone: (sink) {
          sink.close();
          // UPLOAD DONE;
          fileUploaded!(totalByteLength);
          print("Upload is done");
        },
      ),
    );

    final res = await request.addStream(streamUpload);

    print("res $res");

    final httpResponse = await request.close();

    var statusCode = httpResponse.statusCode;
    print("httpStatusCode $statusCode");
    if (statusCode ~/ 100 != 2) {
      return "error";
      // throw Exception(
      //     'Error uploading file, Status code: ${httpResponse.statusCode}');
    } else {
      return await readResponseAsString(httpResponse);
    }
  }

  static Future<String> readResponseAsString(HttpClientResponse response) {
    var completer = Completer<String>();
    var contents = StringBuffer();
    response.transform(utf8.decoder).listen((String data) {
      contents.write(data);
    }, onDone: () => completer.complete(contents.toString()));
    return completer.future;
  }

  static Future<Map<String, dynamic>> uploadUserImage(
    String api,
    Map<String, String> params,
    // XFile file,
  ) async {
    final url = Uri.parse(api);
    Get.log(
        "========================================================================================================");
    Get.log(
        "-------------------------------------------- URL --------------------------------------------");
    Get.log("$url");
    Get.log(
        "-------------------------------------------- PARAMETERS --------------------------------------------");
    Get.log("$params");

    //final length = await file.length();

    final request = http.MultipartRequest("POST", url);
    request.headers["apiusername"] = "lbus8830082tree";
    request.headers["apipassword"] = "NDU0dDctZmRhajcta2Zkc2ozLWZkYXNr";
    request.headers["Content-type"] = "multipart/form-data";

    request.fields.addAll(params);

    // request.files.add(http.MultipartFile(
    //     isFormDrawer ? 'files' : 'file', file.readAsBytes().asStream(), length,
    //     filename: file.name, contentType: mediaType));
    // request.files.add(http.MultipartFile(
    //     "image",
    //     contentType: MediaType('image', 'jpeg'),
    //     filename: file.path,
    //     file.readAsBytes().asStream(),
    //     length));
    final streamRes = await request.send();
    final res = await http.Response.fromStream(streamRes);
    final Map<String, dynamic> json = await jsonDecode(res.body);
    return json;
  }

  static Future<ProfileModel> getProfileResponse(String api) async {
    final url = Uri.parse(api);

    final http.Response res;
    var token = SharedPref.shared.pref!.getString(PrefKeys.token)!;

    res = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    Get.log(res.body);
    return profileModelFromJson(res.body);
  }

  static Future getOrderResponse(String api) async {
    var token = SharedPref.shared.pref!.getString(PrefKeys.token);
    final url = Uri.parse(api);
    Get.log(api);

    final http.Response res;

    res = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    Get.log(res.body);
    return res;
  }

  static Future<NewOrderModel> getNewOrderModel(String api) async {
    final url = Uri.parse(api);

    final http.Response res;
    var token = SharedPref.shared.pref!.getString(PrefKeys.token)!;

    print(api);
    res = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    Get.log(res.body);
    return newOrderModelFromJson(res.body);
  }

  static Future<StaticPagesModel> getStaticPagesData(String api) async {
    final url = Uri.parse(api);

    final http.Response res;
    print(api);
    // var token = SharedPref.shared.pref!.getString(PrefKeys.token)! ?? "";

    res = await http.get(url, headers: {
      // 'Authorization': 'Bearer $token',
    });

    Get.log(res.body + "STATIC RESPONSE");
    return staticPagesModelFromJson(res.body);
  }

  static Future<OrderDetailModelNew> getNewOrderDetailModel(String api) async {
    final url = Uri.parse(api);

    final http.Response res;
    var token = SharedPref.shared.pref!.getString(PrefKeys.token)!;

    res = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    Get.log(res.body);
    return orderDetailModelNewFromJson(res.body);
  }

  static Future<ReviewModel> getReviewList(String api) async {
    final url = Uri.parse(api);

    final http.Response res;
    var token = SharedPref.shared.pref!.getString(PrefKeys.token)!;

    print(token);
    res = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    Get.log(res.body);
    return reviewModelFromJson(res.body);
  }

  static Future<TransactionModel> getTransactionList(String api) async {
    final url = Uri.parse(api);

    final http.Response res;
    var token = SharedPref.shared.pref!.getString(PrefKeys.token)!;

    print(token);
    res = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    Get.log(res.body);
    return transactionModelFromJson(res.body);
  }

  static Future<WithdrawModel> getWithdrawList(String api) async {
    final url = Uri.parse(api);

    print(api);
    final http.Response res;
    var token = SharedPref.shared.pref!.getString(PrefKeys.token)!;

    print(token);
    res = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    Get.log(res.body);
    return withdrawModelFromJson(res.body);
  }

  static Future<ChatModel> getChatList(String api) async {
    final url = Uri.parse(api);

    final http.Response res;
    var token = SharedPref.shared.pref!.getString(PrefKeys.token)!;

    print(token);
    res = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    Get.log(res.body);
    return chatModelFromJson(res.body);
  }

  static Future<NotificationModel> getNotifications(String api) async {
    final url = Uri.parse(api);

    final http.Response res;
    var token = SharedPref.shared.pref!.getString(PrefKeys.token)!;

    print(token);
    res = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    Get.log(res.body);
    return notificationModelFromJson(res.body);
  }

  static Future<CountryModel> getCountryList(String api) async {
    final url = Uri.parse(api);

    final http.Response res;
    var token = SharedPref.shared.pref!.getString(PrefKeys.token)!;

    print(token);
    res = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    Get.log(res.body);
    return countryModelFromJson(res.body);
  }

  static Future<StateModel> getStateList(String api) async {
    final url = Uri.parse(api);

    final http.Response res;
    var token = SharedPref.shared.pref!.getString(PrefKeys.token)!;

    print(token);
    print(api);
    res = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    Get.log(res.body);
    return stateModelFromJson(res.body);
  }

  static Future<CitiesModel> getCitiesList(String api) async {
    final url = Uri.parse(api);

    final http.Response res;
    var token = SharedPref.shared.pref!.getString(PrefKeys.token)!;

    print(token);
    res = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    Get.log(res.body);
    return citiesModelFromJson(res.body);
  }

  // static Future<List<DashboardFaceModel>> getDashboardFace(String api) async {
  //   final url = Uri.parse(api);
  //   final http.Response res;
  //   Get.log("DAshboard Faces URL $url");

  //   res = await http.get(url, headers: {
  //     'apiusername': APIs.apiUserName,
  //     'apipassword': APIs.apipassword,
  //     'uid': userid.toString(),
  //     'scode': sCode.toString(),
  //     'Content-type': 'application/json',
  //   });
  //   Get.log("userI $userid");
  //   Get.log("scode $sCode");

  //   Get.log("DAshboard Faces${res.body}");

  //   return dashboardFaceModelFromJson(res.body);
  // }

  static Future<Map<String, dynamic>> getAPI(String api) async {
    final url = Uri.parse(api);

    final http.Response res;
    print(api);
    var token = SharedPref.shared.pref!.getString(PrefKeys.token)!;

    res = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    Get.log(api);
    Get.log(
        "======================================================== Response =======================================================");
    Get.log("ress${res.body}");
    final json = await jsonDecode(res.body);
    return json;
  }
}
