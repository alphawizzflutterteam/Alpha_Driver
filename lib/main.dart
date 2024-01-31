import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:work/Screens/splash/spashScreen.dart';
import 'package:work/utilities/fcm_helper.dart';
import 'package:work/utilities/shared_pref..dart';
import 'package:work/utilities/theme.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  FCMHelper.shared.listenNotificationInBackground(message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FCMHelper.shared.intializeFirebase();

  await SharedPref.shared.getPref();

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Container()),
    );
  };
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseSetup();
  }

  void _handleMessage(RemoteMessage message) {
    print("_handleMessage : ${message.data}");
  }

  firebaseSetup() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        print('Message also contained a notification: ${message.data}');
        await FirebaseMessaging.instance
            .setForegroundNotificationPresentationOptions(
          alert: true, // Required to display a heads up notification
          badge: true,
          sound: true,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetMaterialApp(
          useInheritedMediaQuery: true,
          //locale: DevicePreview.locale(context),
          debugShowCheckedModeBanner: false,
          //locale: Locale(SharedPref.shared.pref?.getString(PrefKeys.appLanguage) ?? 'en', 'IN'),
          title: 'Alpha Driver',
          theme: appTheme,
          home: SplashScreen()),
    );
  }
}
