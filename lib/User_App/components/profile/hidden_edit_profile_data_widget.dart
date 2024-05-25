import 'package:events_app/common/components/auth/Costume_login_TextField_widget.dart';
import 'package:events_app/common/controllers/auth/regester_controller.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class HiddenEditProfileDataWidget extends StatelessWidget {
  const HiddenEditProfileDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (controller) {
      return Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomeLoginTextFormField(
              prefixIcon: const Icon(Icons.assignment_ind_rounded),
              hintText: 'First name',
              inputType: TextInputType.text,
              title: 'First name',
              controller: controller.firstNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your First name';
                }
                return null;
              },
              //HERE WILL BE THE DATA FROM API which i will put it in the textfild
              isFilledTextFild: true,
              filledTextFildData: "Zakaria",
            ),
            const SizedBox(
              height: 20,
            ),
            CustomeLoginTextFormField(
              prefixIcon: const Icon(Icons.person),
              hintText: 'Last name',
              inputType: TextInputType.text,
              title: 'Last name',
              controller: controller.lastNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Last name';
                }
                return null;
              },
              isFilledTextFild: true,
              filledTextFildData: "last name",
            ),
            const SizedBox(
              height: 20,
            ),
            CustomeLoginTextFormField(
              prefixIcon: const Icon(Icons.person),
              hintText: 'Username',
              inputType: TextInputType.text,
              title: 'Username',
              controller: controller.usernameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Username';
                }
                return null;
              },
              isFilledTextFild: true,
              filledTextFildData: "M_zakaria_K",
            ),
            const SizedBox(
              height: 20,
            ),
            CustomeLoginTextFormField(
              prefixIcon: const Icon(Icons.email),
              hintText: 'Enter your Email',
              inputType: TextInputType.text,
              title: 'Email',
              controller: controller.emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Email';
                }
                return null;
              },
              isFilledTextFild: true,
              filledTextFildData: "zakariana2003@gmail.com",
            ),
            const SizedBox(
              height: 20,
            ),
            CustomeLoginTextFormField(
              prefixIcon: const Icon(Icons.place),
              hintText: 'residence place',
              inputType: TextInputType.text,
              title: 'Residence Place',
              controller: controller.residencePlaceController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your residence place';
                }
                return null;
              },
              isFilledTextFild: true,
              filledTextFildData: "Mohageren",
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xffFAFAFb),
                borderRadius: BorderRadius.circular(20),
              ),
              child: IntlPhoneField(
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
                pickerDialogStyle: PickerDialogStyle(
                  searchFieldInputDecoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search",
                    hintStyle:
                        const TextStyle(color: Color.fromARGB(255, 87, 87, 87)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        width: 1,
                        color: ThemesStyles.primary,
                      ),
                    ),
                  ),
                  backgroundColor: ThemesStyles.background,
                  width: MediaQuery.sizeOf(context).width,
                ),
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: ThemesStyles.primary, width: 2.0),
                    borderRadius: BorderRadius.circular(
                        ThemesStyles.borderradiusprimary + 5),
                  ),
                  hintText: 'Phone Number',
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 220, 220, 220),
                    fontSize: 16,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                ),
                initialCountryCode: 'SY',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      );
    });
  }
}
