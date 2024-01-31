import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:work/Models/cities_model.dart';
import 'package:work/Models/country_model.dart';
import 'package:work/Models/states_model.dart';
import 'package:work/utilities/color.dart';

import '../../../Provider/country_controller.dart';
import '../../../Provider/signupController.dart';
import '../../../Provider/state_controller.dart';
import '../../../helper/CustomWidgets/custom_button.dart';
import '../../../helper/CustomWidgets/custom_text_field.dart';
import '../../../helper/app_constant.dart';
import '../../ProfileScreen/editProfiePages/component/country_field.dart';

class AddressDetail extends StatefulWidget {
  const AddressDetail({super.key});

  @override
  State<AddressDetail> createState() => _AddressDetailState();
}

class _AddressDetailState extends State<AddressDetail> {
  final SignupController signUpContr = Get.put(SignupController());

  TextEditingController permanentAddressController = TextEditingController();
  String countryName = '';
  String stateName = '';
  String cityName = '';

  @override
  void dispose() {
    // signUpContr.countryController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    callAPI();
  }

  callAPI() async {
    await signUpContr.getCountryList();
  }

  void _increment() {
    signUpContr.increaseCurrentState();
  }

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: ListView(children: [
        Text(
          'Enter your address information',
          style: th.bodyLarge?.copyWith(
              fontSize: 26, fontWeight: FontWeight.w700, color: appColorBlack),
        ),
        const SizedBox(height: 5),
        Text(
          'Effortless shopping starts with your address – Enter it now and let the E-Commerce Driver app bring your purchases to your doorstep',
          style: th.bodySmall
              ?.copyWith(fontWeight: FontWeight.w700, color: Colors.grey),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        CustomTextField(
          controller: signUpContr.permanentAddressController,
          labelText: 'Permanent Address',
          hintText: '',
          maxLength: 50,
          textCapitalization: TextCapitalization.words,
          inputFormatters: [],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 50,
          child: Obx(() {
            return Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: appColorBlack, width: 1)),
              padding: const EdgeInsets.only(
                  left: defaultPadding,
                  bottom: defaultPadding,
                  top: defaultPadding),
              alignment: Alignment.centerLeft,
              child: DropdownButton<DataCountry>(
                underline: Container(),
                isExpanded: true,
                dropdownColor: Theme.of(context).brightness == Brightness.dark
                    ? colors.darkBG
                    : Colors.white,
                value: signUpContr.selectedCountry,
                onChanged: (value) async {
                  signUpContr.country.value = value!.name;
                  await signUpContr.setCountry(value);
                  setState(() {});
                },
                items: signUpContr.countryListItem
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e.name.toString(),
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.normal),
                          ),
                        ))
                    .toList(),
                hint: const Text('Select a country',
                    style: TextStyle(
                        color: colors.greyText, fontWeight: FontWeight.normal)),
              ),
            );
          }),
        ),
        const SizedBox(height: 20),
        Obx(() {
          return Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: appColorBlack, width: 1)),
              child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12),
                  child: DropdownButton<DatuState>(
                    underline: Container(),
                    isExpanded: true,
                    dropdownColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? colors.darkBG
                            : Colors.white,
                    value: signUpContr.selectedState,
                    onChanged: (value) async {
                      signUpContr.state.value = value!.name;
                      await signUpContr.setState(value);
                      setState(() {});
                    },
                    items: signUpContr.stateListItems!
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.name.toString(),
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                            ))
                        .toList(),
                    hint: const Text('Select State',
                        style: TextStyle(
                            color: colors.greyText,
                            fontWeight: FontWeight.normal)),
                  )));
        }),
        const SizedBox(height: 20),

        SizedBox(
          height: 50,
          child: Obx(() {
            return Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: appColorBlack, width: 1)),
              padding: const EdgeInsets.only(
                  left: defaultPadding,
                  bottom: defaultPadding,
                  top: defaultPadding),
              alignment: Alignment.centerLeft,
              child: DropdownButton<Datuc>(
                underline: Container(),
                isExpanded: true,
                dropdownColor: Theme.of(context).brightness == Brightness.dark
                    ? colors.darkBG
                    : Colors.white,
                value: signUpContr.selectedCity,
                onChanged: (value) async {
                  signUpContr.city.value = value!.name;

                  await signUpContr.setCity(value);
                  setState(() {});
                },
                items: signUpContr.citiesListItems
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e.name.toString(),
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.normal),
                          ),
                        ))
                    .toList(),
                hint: const Text('Select a city',
                    style: TextStyle(
                        color: colors.greyText, fontWeight: FontWeight.normal)),
              ),
            );
          }),
        ),

        // SizedBox(
        //   height: 50,
        //   child: Obx(() {
        //     return CustomDropdown(
        //       hint: 'City',
        //       items: signUpContr.citiesList?.value.data
        //               .map((city) => city.name)
        //               .toList() ??
        //           [],
        //       selectedValue: signUpContr.selectedCity.value,
        //       onChanged: (newValue) {
        //         signUpContr.selectedCity.value = newValue ?? "";
        //         cityName = newValue!;
        //         // stateGetXController.stateId.value=stateGetXController.getIdByName(newValue!)!;
        //         // cityGetXController.getCityList(stateGetXController.stateId.value.toString());
        //       },
        //     );
        //   }),
        // ),

        // CustomTextField(
        //   controller: signUpContr.cityController,
        //   labelText: 'City',
        //   hintText: '',
        //   inputFormatters: [],
        // ),
        // CustomTextField(
        //   controller: signUpContr.stateController,
        //   labelText: 'State/Province',
        //   hintText: '',
        //   inputFormatters: [],
        // ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: signUpContr.zipCodeController,
          keyboardType: TextInputType.number,
          labelText: 'Postal/ZIP Code',
          hintText: '',
          inputFormatters: [LengthLimitingTextInputFormatter(6)],
        ),

        // CustomTextField(
        //   controller: signUpContr.countryController,
        //   labelText: 'Country',
        //   hintText: '',
        //   inputFormatters: [],
        // ),
        const SizedBox(height: 30),
        CustomButtonWidget(
            text: 'CONTINUE',
            onPressed: () {
              signUpContr.verifyAddress();
              // _increment();
            }),
      ]),
    );
  }
}
