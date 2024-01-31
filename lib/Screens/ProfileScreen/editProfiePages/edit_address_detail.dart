import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:work/Models/country_model.dart';
import 'package:work/Models/profileModel.dart';
import 'package:work/Provider/cities_controller.dart';
import 'package:work/Provider/country_controller.dart';
import 'package:work/Screens/ProfileScreen/editProfiePages/component/country_field.dart';
import 'package:work/helper/CustomWidgets/base_scaffold.dart';
import 'package:work/utilities/shared_pref..dart';

import '../../../Provider/edit_profile_controller.dart';
import '../../../Provider/state_controller.dart';
import '../../../helper/CustomWidgets/custom_button.dart';
import '../../../helper/CustomWidgets/custom_text_field.dart';
import '../../../helper/app_constant.dart';

class EditAddressDetail extends StatefulWidget {
  const EditAddressDetail({super.key});

  @override
  State<EditAddressDetail> createState() => _EditAddressDetailState();
}

class _EditAddressDetailState extends State<EditAddressDetail> {
  final CountryController countryGetXController = Get.put(CountryController());
  final StateController stateGetXController = Get.put(StateController());
  final CityController cityGetXController = Get.put(CityController());
  final EditProfileController editProfileController =
      Get.put(EditProfileController());

  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  String countryName = '';
  String stateName = '';
  String cityName = '';
  @override
  void dispose() {
    // editProfileController.permanentAddressController.dispose();
    // editProfileController.zipCodeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // countryGetXController.getCountryList();
    var model =
        jsonDecode(SharedPref.shared.pref!.getString(PrefKeys.userDetails)!);
    Datum user = Datum.fromJson(model);
    country.text = user.country;
    editProfileController.permanentAddressController.text = user.address;
    country.text = user.country;
    state.text = user.state;
    city.text = user.city;

    cityGetXController.selectedCity.value = user.city;
    stateGetXController.selectedState.value = user.state;
    // stateGetXController.stateId.value=stateGetXController.getIdByName(user.state)!;
    editProfileController.zipCodeController.text = user.pincode;
    //countryGetXController.selectedCountry.value = user.country;
    // countryGetXController.id.value=countryGetXController.getIdByName(user.country)!;
  }

  @override
  Widget build(BuildContext context) {
    final th = Theme.of(context).textTheme;
    return BaseScaffold(
      title: 'Address Info',
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding),
        child: ListView(children: [
          // Text(
          //   'Enter your address information',
          //   style: th.bodyLarge?.copyWith(
          //       fontSize: 26,
          //       fontWeight: FontWeight.w700,
          //       color: appColorBlack),
          // ),
          // const SizedBox(height: 5),
          // Text(
          //   'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
          //   style: th.bodySmall
          //       ?.copyWith(fontWeight: FontWeight.w700, color: Colors.grey),
          // ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          CustomTextField(
            controller: editProfileController.permanentAddressController,
            labelText: 'Permanent Address',
            hintText: '',
            enabled: false,
            inputFormatters: [],
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: country,
            labelText: 'Country',
            hintText: '',
            enabled: false,
            inputFormatters: [],
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: state,
            enabled: false,
            labelText: 'State',
            hintText: '',
            inputFormatters: [],
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: city,
            labelText: 'City',
            enabled: false,
            hintText: '',
            inputFormatters: [],
          ),
          //  const SizedBox(height: 15),
          // SizedBox(
          //   height: 50,
          //   child: Obx(() {
          //     return CustomDropdown(
          //       hint: 'Country',
          //       items: countryGetXController.countryList?.value.data
          //               ?.map((country) => country.name)
          //               .toList() ??
          //           [],
          //       selectedValue: countryGetXController.selectedCountry.value,
          //       onChanged: (String? newValue) {
          //         countryGetXController.selectedCountry.value = newValue ?? "";
          //         countryGetXController.id.value =
          //             countryGetXController.getCountryIdByName(newValue!)!;
          //         print(countryGetXController.id.value);
          //         countryGetXController
          //             .getStateList(countryGetXController.id.value.toString());
          //         countryGetXController.changeSelectedState();
          //         countryGetXController.changeSelectedCity();
          //         // editProfileController.countryName.value=newValue;
          //         editProfileController.countryName1 = newValue;
          //       },
          //     );
          //   }),
          // ),
          //const SizedBox(height: 15),
          // SizedBox(
          //   height: 50,
          //   child: Obx(() {
          //     return CustomDropdown(
          //       hint: 'State',
          //       items: stateGetXController.stateList?.value.data
          //               .map((state) => state.name)
          //               .toList() ??
          //           [],
          //       selectedValue: stateGetXController.selectedState.value,
          //       onChanged: (String? newValue) {
          //         countryGetXController.selectedState.value = newValue ?? "";
          //         countryGetXController.stateId.value =
          //             countryGetXController.getStateIdByName(newValue!)!;
          //         countryGetXController.getCityList(
          //             stateGetXController.stateId.value.toString());
          //         countryGetXController.changeSelectedCity();
          //         // editProfileController.stateName.value=newValue;
          //         editProfileController.stateName1 = newValue;
          //       },
          //     );
          //   }),
          // ),

          // const SizedBox(height: 15),
          // SizedBox(
          //   height: 50,
          //   child: Obx(() {
          //     return CustomDropdown(
          //       hint: 'City',
          //       items: cityGetXController.citiesList?.value.data
          //               .map((city) => city.name)
          //               .toList() ??
          //           [],
          //       selectedValue: cityGetXController.selectedCity.value,
          //       onChanged: (String? newValue) {
          //         cityGetXController.selectedCity.value = newValue ?? "";
          //         // editProfileController.cityName.value=newValue!;
          //         editProfileController.cityName1 = newValue!;

          //         // stateGetXController.stateId.value=stateGetXController.getIdByName(newValue!)!;
          //         // cityGetXController.getCityList(stateGetXController.stateId.value.toString());
          //       },
          //     );
          //   }),
          // ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: editProfileController.zipCodeController,
            keyboardType: TextInputType.number,
            labelText: 'Postal/ZIP Code',
            hintText: '',
            enabled: false,
            inputFormatters: [],
          ),
          const SizedBox(height: 40),
          // CustomButtonWidget(
          //     text: 'SAVE',
          //     onPressed: () {
          //       editProfileController.verifyAndPostAddress();
          //     }),
        ]),
      ),
    );
  }
}
