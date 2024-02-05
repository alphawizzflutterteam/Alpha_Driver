import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:work/utilities/app_color.dart';

import '../app_constant.dart';

class BaseScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? bottomSheet;
  const BaseScaffold(
      {super.key, required this.title, required this.child, this.bottomSheet});

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            alignment: Alignment.bottomLeft,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.left_chevron,
              color: appColorWhite,
            )),

        title: Text(
          title,
          style: th.bodyMedium?.copyWith(
              fontSize: 18, fontWeight: FontWeight.w700, color: appColorWhite),
          textAlign: TextAlign.left,
        ),
        //toolbarHeight: 82,
        backgroundColor: appThemeColor,
        flexibleSpace: Container(
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  right: -10,
                  bottom: 0,
                  child: Image.asset('assets/icons/appbar_bg.png')),
            ],
          ),
        ),
      ),
      body: child,
      bottomSheet: bottomSheet,
    );
  }
}
