import 'package:flutter/material.dart';
import '../app_constant.dart';

class CustomTabBar extends StatelessWidget {
  final TabController tabController;
  final List<String> tabTitles;

  const CustomTabBar({
    super.key,
    required this.tabController,
    required this.tabTitles
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: TabBar(
        indicator:  BoxDecoration(
          color: appGreenColor,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        overlayColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        tabAlignment: TabAlignment.fill,
        dividerHeight: 0,
        indicatorColor: appGreenColor,
        labelColor: appColorWhite,
        unselectedLabelColor: Colors.white,
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        tabs: List.generate(
          tabTitles.length,
              (index) => Tab(
            child: Text(
              tabTitles[index],

              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ),
      ),
    );
  }
}
