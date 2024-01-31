import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:work/Provider/reviewController.dart';
import 'package:work/helper/CustomWidgets/base_scaffold.dart';
import 'package:work/helper/CustomWidgets/commonappbar.dart';
import 'package:work/helper/app_constant.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final ReviewController controller = Get.put(ReviewController());

  @override
  void initState() {
    super.initState();
    callApi();
  }

  callApi() async {
    await controller.getReviews();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: const CommanAppbar(
            appbarTitle: 'Ratings',
            forHome: true,
          ),
          body: controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                        child: Text(
                      controller.model!.value.averageRating,
                      style: const TextStyle(color: Colors.black, fontSize: 24),
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: RatingBar.builder(
                      initialRating:
                          double.parse(controller.model!.value.averageRating),
                      minRating: 1,
                      // direction: _isVertical ? Axis.vertical : Axis.horizontal,
                      allowHalfRating: true,

                      unratedColor: Colors.grey.withAlpha(50),
                      itemCount: 5,
                      itemSize: 40.0,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          var _rating = rating;
                        });
                      },
                      updateOnDrag: false,
                      ignoreGestures:
                          true, // Set this to true to make the rating bar unclickable
                    )),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                        child: Text(
                      controller.model!.value.totalSize.toString() +
                          " Global Ratings",
                      style: const TextStyle(fontSize: 16),
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                    for (int i = 0;
                        i < controller.model!.value.review.length;
                        i++)
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: appWhiteShade),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      child: Icon(Icons.person),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(controller.model!.value.review[i]
                                              .customerName),
                                          Text(controller
                                              .model!.value.review[i].comment)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                    controller.model!.value.review[i].createdAt)
                              ],
                            ),
                          ),
                        ),
                      )
                  ],
                ));
    });
  }
}
