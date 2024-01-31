import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:work/Screens/staticPages/controller/staticPagesController.dart';
import 'package:work/helper/CustomWidgets/commonappbar.dart';

class StaticScreens extends StatefulWidget {
  final String title;
  const StaticScreens({super.key, required this.title});

  @override
  State<StaticScreens> createState() => _StaticScreensState();
}

class _StaticScreensState extends State<StaticScreens> {
  final StaticPagesController controller = Get.put(StaticPagesController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callApi();
  }

  callApi() async {
    await controller.getStaticPages();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context).textTheme;
    return Obx(() {
      return Scaffold(
        appBar: CommanAppbar(
          appbarTitle: widget.title,
          forHome: false,
        ),
        body: controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Html(
                  data: widget.title == "Terms of Service"
                      ? controller.model.value.data.termsNConditions.content
                      : controller.model.value.data.privacyPolicy.content,
                  style: {
                    'p': Style(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      fontSize: FontSize(14),
                    ),
                    'li': Style(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      fontSize: FontSize(14),
                    )
                  },
                ),
              ),
      );
    });
  }
}
