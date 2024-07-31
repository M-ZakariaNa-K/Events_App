import 'package:events_app/User_App/controllers/profile/profile_controller.dart';
import 'package:events_app/common/components/auth/Costume_login_TextField_widget.dart';
import 'package:events_app/common/components/general/defult_button.dart';
import 'package:events_app/common/controllers/auth/regester_controller.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class HiddenEditProfileDataWidget extends StatelessWidget {
  HiddenEditProfileDataWidget({super.key});
  final _phonNumberKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //Here u will take the data from Backend
    return GetBuilder<ProfileController>(builder: (controller) {
      final profileController = Get.put(ProfileController());
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomeLoginTextFormField(
            prefixIcon: const Icon(Icons.assignment_ind_rounded),
            hintText: 'First name',
            inputType: TextInputType.text,
            title: 'First name',
            controller: profileController.firstNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your First name';
              }
              return null;
            },
            //HERE WILL BE THE DATA FROM API which i will put it in the textfild
            isFilledTextFild: true,
            filledTextFildData: profileController.profileItems[0].firstName,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomeLoginTextFormField(
            prefixIcon: const Icon(Icons.person),
            hintText: 'Last name',
            inputType: TextInputType.text,
            title: 'Last name',
            controller: profileController.lastNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your Last name';
              }
              return null;
            },
            isFilledTextFild: true,
            filledTextFildData: "${profileController.profileItems[0].lastName}",
          ),
          const SizedBox(
            height: 20,
          ),
          CustomeLoginTextFormField(
            prefixIcon: const Icon(Icons.person),
            hintText: 'Username',
            inputType: TextInputType.text,
            title: 'Username',
            controller: profileController.usernameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your Username';
              }
              return null;
            },
            isFilledTextFild: true,
            filledTextFildData: profileController.profileItems[0].username,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomeLoginTextFormField(
            prefixIcon: const Icon(Icons.email),
            hintText: 'Enter your Email',
            inputType: TextInputType.text,
            title: 'Email',
            controller: profileController.emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your Email';
              }
              return null;
            },
            isFilledTextFild: true,
            filledTextFildData: profileController.profileItems[0].email,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomeLoginTextFormField(
            prefixIcon: const Icon(Icons.place),
            hintText: 'residence place',
            inputType: TextInputType.text,
            title: 'Residence Place',
            controller: profileController.addressController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your residence place';
              }
              return null;
            },
            isFilledTextFild: true,
            filledTextFildData: profileController.profileItems[0].address,
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: _phonNumberKey,
            child: CustomeLoginTextFormField(
              prefixIcon: const Icon(Icons.phone),
              hintText: 'Phone Number',
              inputType: TextInputType.text,
              title: 'Phone Number',
              controller: profileController.phoneNumberController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Phone Number';
                }
                if (value.length < 10) {
                  return 'The entered Phone Number most be more than 10 numbers';
                }
                return null;
              },
              isFilledTextFild: true,
              filledTextFildData: profileController.profileItems[0].phoneNumber,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // Container(
          //   decoration: BoxDecoration(
          //     color: const Color(0xffFAFAFb),
          //     borderRadius: BorderRadius.circular(20),
          //   ),
          //   child: IntlPhoneField(
          //     initialCountryCode: 'SY',
          //     countries: const [
          //       Country(
          //         name: 'Syria',
          //         code: 'SY',
          //         dialCode: '963',
          //         flag: '🇸🇾',
          //         nameTranslations: {
          //           'en': 'Syria',
          //           'ar': 'سوريا',
          //         },
          //         minLength: 7,
          //         maxLength: 9,
          //       )
          //     ], // Allow only Syrian numbers
          //     disableLengthCheck: false, // Disable length check (optional)
          //     dropdownIcon: const Icon(Icons.arrow_drop_down, size: 0),
          //     onChanged: (phone) {
          //       //this controller is has the number which i will give it to the backend without +963
          //       print(profileController.phoneNumberController.text);
          //       print(phone.completeNumber);
          //     },
          //     pickerDialogStyle: PickerDialogStyle(
          //       searchFieldInputDecoration: InputDecoration(
          //         prefixIcon: const Icon(Icons.search),
          //         hintText: "Search",
          //         hintStyle:
          //             const TextStyle(color: Color.fromARGB(255, 87, 87, 87)),
          //         enabledBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(20),
          //           borderSide: const BorderSide(
          //             width: 1,
          //             color: ThemesStyles.primary,
          //           ),
          //         ),
          //       ),
          //       backgroundColor: ThemesStyles.background,
          //       width: MediaQuery.sizeOf(context).width,
          //     ),
          //     decoration: InputDecoration(
          //       enabledBorder: const OutlineInputBorder(
          //         borderSide: BorderSide(
          //           width: 1,
          //           color: Colors.transparent,
          //         ),
          //       ),
          //       focusedBorder: OutlineInputBorder(
          //         borderSide:
          //             const BorderSide(color: ThemesStyles.primary, width: 2.0),
          //         borderRadius: BorderRadius.circular(
          //             ThemesStyles.borderradiusprimary + 5),
          //       ),
          //       hintText: 'Phone Number',
          //       hintStyle: const TextStyle(
          //         color: Color.fromARGB(255, 220, 220, 220),
          //         fontSize: 16,
          //       ),
          //       contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
          //     ),
          //     controller: profileController.phoneNumberController,
          //   ),
          // ),
          const SizedBox(
            height: 10,
          ),
          DefultButton(
            buttonColor: Theme.of(context).brightness == Brightness.dark
                ? ThemesStyles.backgroundDark
                : ThemesStyles.background,
            borderColor: const Color.fromARGB(255, 206, 206, 206),
            textColor: ThemesStyles.primary,
            title: "Update",
            onPressed: () async {
              if (_phonNumberKey.currentState!.validate()) {
                await profileController.postEditedProfileItems();
              }
            },
          )
        ],
      );
    });
  }
}
