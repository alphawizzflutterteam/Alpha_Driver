import 'package:flutter/material.dart';
import '../../../../helper/app_constant.dart';

class CustomDropdown extends StatelessWidget {
  final List<String>? items;
  final String? selectedValue;
  final String? hint;
  final Function(String?)? onChanged;

  const CustomDropdown(
      {super.key, this.items, this.selectedValue, this.onChanged, this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: appColorBlack, width: 1)),
      padding: const EdgeInsets.only(
          left: defaultPadding, bottom: defaultPadding, top: defaultPadding),
      alignment: Alignment.centerLeft,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(hint!),
          isExpanded: true,
          elevation: 0,
          value: selectedValue,
          items: items
                  ?.map((item) => DropdownMenuItem<String>(
                        value: item,
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          item,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                  .toList() ??
              [],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
