import 'package:flutter/material.dart';
import 'package:work/Provider/order_detail_controller.dart';
import 'package:work/Screens/OrderScreens/OrderShipment/compoments/price_details.dart';
import 'package:work/helper/CustomWidgets/base_scaffold.dart';
import 'package:work/helper/app_constant.dart';

class AcceptPaymentMethod extends StatefulWidget {
  final String productId;
  final String deliveryTpe;
  final String price;
  final OrderDetailController orderDetailController;
  final String orderId;
  final bool isPaid;
  const AcceptPaymentMethod(
      {super.key,
      required this.productId,
      required this.deliveryTpe,
      required this.price,
      required this.orderDetailController,
      required this.orderId,
      required this.isPaid});

  @override
  State<AcceptPaymentMethod> createState() => _AcceptPaymentMethodState();
}

class _AcceptPaymentMethodState extends State<AcceptPaymentMethod> {
  String selectedPaymentOption = '';
  @override
  void initState() {
    super.initState();

    selectedPaymentOption = widget.isPaid ? 'Online Payment' : 'Pay by Cash';
  }

  @override
  Widget build(BuildContext context) {
    var th = Theme.of(context).textTheme;

    return BaseScaffold(
        title: "Payment",
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                margin: const EdgeInsets.all(defaultPadding),
                elevation: 0,
                color: appCardColor,
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.productId,
                        style: th.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: appColorBlack,
                        ),
                      ),
                      Text(
                        widget.deliveryTpe,
                        style: th.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              widget.price,
                              style: th.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: appColorBlack,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              PriceDetails(
                price: widget.orderDetailController.priceList.first.subTotal,
                discount: widget.orderDetailController.priceList.first.discount,
                item: '1',
                deliveryFee:
                    widget.orderDetailController.priceList.first.deliveryFee,
                tax: widget.orderDetailController.priceList.first.tax,
                totalPrice: widget.orderDetailController.priceList.first.total,
              ),
              SizedBox(
                height: 20,
              ),
              widget.isPaid
                  ? Container()
                  : Text(
                      "Payment Mode",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
              widget.isPaid
                  ? Container()
                  : RadioListTile(
                      title: Text('Pay by Cash'),
                      value: 'Pay by Cash',
                      groupValue: selectedPaymentOption,
                      onChanged: (value) {
                        setState(() {
                          selectedPaymentOption = value!;
                        });
                      },
                    ),
              // widget.isPaid
              //     ? Container()
              //     : RadioListTile(
              //         title: Text('Online Payment'),
              //         value: 'Online Payment',
              //         groupValue: selectedPaymentOption,
              //         onChanged: (value) {
              //           setState(() {
              //             selectedPaymentOption = value!;
              //           });
              //         },
              //       ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    if (selectedPaymentOption == "Pay by Cash") {
                      Map params = {
                        "order_id": widget.orderId.toString(),
                        "pay_by": "cash_in_hand",
                        "cause": "",
                        "status": "delivered"
                      };
                      widget.orderDetailController
                          .updateDeliveryStatus(params, context);
                    } else {
                      Map params = {
                        "order_id": widget.orderId.toString(),
                        "pay_by": "online",
                        "cause": "",
                        "status": "delivered"
                      };
                      widget.orderDetailController
                          .updateDeliveryStatus(params, context);
                    }
                  },
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width - 50,
                    decoration: BoxDecoration(
                      color: appPrimaryColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green, width: 0.5),
                    ),
                    child: Center(
                      child: Text(
                        "Confirm",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: appColorWhite,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
