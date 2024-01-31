import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work/Screens/staticPages/controller/staticPagesController.dart';
import 'package:work/helper/CustomWidgets/commonappbar.dart';
import 'package:work/utilities/color.dart';

class FAQs extends StatefulWidget {
  const FAQs({Key? key}) : super(key: key);

  @override
  State<FAQs> createState() => _FAQsState();
}

class _FAQsState extends State<FAQs> {
  final StaticPagesController controller = Get.put(StaticPagesController());

  @override
  void initState() {
    super.initState();
    callApi();
  }

  callApi() async {
    await controller.getStaticPages();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommanAppbar(
        appbarTitle: "FAQ",
        forHome: false,
      ),
      body: controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const Divider(color: Colors.transparent, height: 8),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: controller.model.value.data.faq.length,
                itemBuilder: (context, i) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(color: Colors.white38, width: 0.2),
                    ),
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.transparent
                        : colors.buttonColor,
                    elevation: 2,
                    child: ExpansionTile(
                      iconColor: Colors.white,
                      collapsedIconColor: Colors.white,
                      title: Text(
                        controller.model.value.data.faq[i].question,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.white),
                      ),
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, bottom: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    controller.model.value.data.faq[i].answer,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
