import 'package:events_app/User_App/controllers/booking/book_Now_controller.dart';
import 'package:events_app/common/components/general/Costume_TextField_widget.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookEventCategoryWidget extends StatefulWidget {
  const BookEventCategoryWidget({super.key});

  @override
  State<BookEventCategoryWidget> createState() =>
      _BookEventCategoryWidgetState();
}

class _BookEventCategoryWidgetState extends State<BookEventCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    final bookNowController = Get.put(BookNowController());

    return SizedBox(
      height: 90,
      child: Obx(
        () => Row(
          children: [
            if (bookNowController.addedCategorriesMap.isNotEmpty)
              Obx(
                () => Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ThemesStyles.thirdColor,
                      border:
                          Border.all(color: ThemesStyles.primary, width: 1)),
                  child: Text(
                    bookNowController.addedCategorriesMap["name"]!["en"]!,
                  ),
                ),
              ),
            //================================
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: bookNowController.existedCategoriesList.length + 1,
              itemBuilder: (context, index) {
                bool isSelected =
                    bookNowController.selectedCategoryCardIndex == index;
                if (index == bookNowController.existedCategoriesList.length) {
                  //to insure there will be no more one added value
                  return GestureDetector(
                    onTap: bookNowController.addedCategorriesMap.isEmpty
                        ? () {
                            showAddedCategoryDialog(context);
                          }
                        : () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: ThemesStyles.blueColor,
                                    width: 150,
                                    height: 300,
                                    child: Text(
                                      "You have just add an event category",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: ThemesStyles.mainFontSize,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color.fromARGB(255, 55, 55, 55)
                            : const Color.fromARGB(255, 246, 246, 246),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Color.fromARGB(255, 215, 215, 215),
                      ),
                    ),
                  );
                }

                return GestureDetector(
                  onTap: () {
                    bookNowController.selectedCategoryCardIndex = index;
                    setState(() {
                      //Here should be the category list not time list
                      bookNowController.selectedChoosenCategoryId.value =
                          bookNowController.existedCategoriesList[index].id;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ThemesStyles.thirdColor,
                      border: isSelected
                          ? Border.all(color: ThemesStyles.primary, width: 1)
                          : null,
                    ),
                    child: Text(
                      bookNowController.existedCategoriesList[index].name,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showAddedCategoryDialog(BuildContext context) {
    final bookNowController = Get.put(BookNowController());
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Form(
          key: _formKey,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 227, 227, 227),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomeTextFormField(
                      hintText: "Event English Name",
                      inputType: TextInputType.text,
                      title: "",
                      controller: bookNowController.addedEnglishnameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter event english name';
                        }
                        return null;
                      },
                      prefixIcon: null,
                    ),
                    const SizedBox(height: 10),
                    CustomeTextFormField(
                      hintText: "Event Arabic Name",
                      inputType: TextInputType.text,
                      title: "",
                      controller: bookNowController.addedArabicnameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter event arabic name';
                        }
                      },
                      prefixIcon: null,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              bookNowController.addedCategorriesMap["name"] = {
                                "ar": bookNowController
                                    .addedArabicnameController.text,
                                "en": bookNowController
                                    .addedEnglishnameController.text,
                              };
                              bookNowController
                                  .selectedChoosenCategoryId.value = 0;

                              bookNowController.addedArabicnameController
                                  .clear();
                              bookNowController.addedEnglishnameController
                                  .clear();
                              Navigator.of(context).pop();
                            }
                          },
                          child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ThemesStyles.primary,
                              ),
                              child: const Text(
                                'Submit',
                                style: TextStyle(
                                  color: ThemesStyles.seconndTextColor,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
