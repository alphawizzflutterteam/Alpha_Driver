import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work/Provider/order_detail_controller.dart';
import 'package:work/Screens/HomeScreen/home_screen.dart';
import 'package:work/utilities/color.dart';

class CancelOrderPopup extends StatefulWidget {
  final String order_id;
  final String reason;

  const CancelOrderPopup(
      {super.key, required this.order_id, required this.reason});

  @override
  _CancelOrderPopupState createState() => _CancelOrderPopupState();
}

class _CancelOrderPopupState extends State<CancelOrderPopup> {
  final OrderDetailController orderDetailController =
      Get.put(OrderDetailController());
  double rating = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Theme.of(context).brightness == Brightness.dark
            ? colors.overlayBG
            : Colors.white,
      ),
      height: 270,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Image.asset(
                "assets/images/bg-icon.png",
                width: 80,
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  "assets/images/cancelOrder.png",
                  width: 60,
                  height: 60,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Are you sure?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Are you sure, that you want to Cancel Order?',
            textAlign: TextAlign.center,
            style: TextStyle(color: colors.greyText),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.hovered) ||
                          states.contains(MaterialState.pressed)) {
                        return colors.buttonColor;
                      }
                      return Colors.transparent; // Default color
                    }),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.white, width: 1)),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.hovered) ||
                          states.contains(MaterialState.pressed)) {
                        return colors.buttonColor;
                      }
                      return colors.buttonColor;
                    }),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    Map data = {
                      "order_id": widget.order_id.toString(),
                      "status": "failed",
                      "cause": widget.reason
                    };
                    orderDetailController.cancelOrder(data, context);
                  },
                  child: const Text(
                    'CANCEL ORDER',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
