import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:work/utilities/app_color.dart';

import '../app_constant.dart';
import 'drawer_home.dart';

class MenuScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  MenuScaffold({super.key, required this.title, required this.child});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context).textTheme;
    return Scaffold(
      key: _scaffoldKey,
      drawer: const HomeDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // toolbarHeight: 85,
        backgroundColor: appThemeColor,
        flexibleSpace: Container(
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  right: -10,
                  bottom: 0,
                  child: Image.asset(
                    'assets/icons/appbar_bg.png',
                    fit: BoxFit.cover,
                  )),
              Container(
                height: 130,
                padding: const EdgeInsets.symmetric(
                    horizontal: 0, vertical: defaultPadding),
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(Icons.arrow_back_ios))),
                    Expanded(
                      flex: 3,
                      child: Text(
                        title,
                        style: th.bodyMedium?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: appColorWhite),
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: child,
    );
  }
}
