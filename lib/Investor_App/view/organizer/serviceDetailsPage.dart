// import 'dart:io';

// import 'package:events_app/Investor_App/controllers/lounges/addLoungesController..dart';
// import 'package:events_app/common/components/auth/defaultFormField.dart';
// import 'package:events_app/common/components/general/defult_button.dart';
// import 'package:events_app/common/core/constants/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// class ServiceDetailsPage extends GetView<AddLoungesController> {
//   ServiceDetailsPage({super.key});
//   var size, height, width;
//   @override
//   Widget build(BuildContext context) {
//     Get.put(AddLoungesController());
//     TextEditingController d = TextEditingController();
//     size = MediaQuery.of(context).size;
//     height = size.height;
//     width = size.width;
//     return Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             onPressed: () {
//               Get.back();
//             },
//             icon: const Icon(Icons.arrow_back_ios_new),
//           ),
//           title: const Text('Back'),
//         ),
//         body: Column(
//           children: [
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: [
//                   Container(
//                     height: height * 0.15,
//                     width: width,
//                     child: Obx(
//                       () => ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           shrinkWrap: true,
//                           itemCount: controller.selectedImagePaths.length +
//                               1, // Increase itemCount by 1
//                           itemBuilder: (context, index) {
//                             // Check if the current index is 0
//                             if (index == 0) {
//                               // Return the Container for adding a new picture
//                               return Container(
//                                 clipBehavior: Clip.hardEdge,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   border: Border.all(
//                                       width: 2, color: ThemesStyles.secondary),
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 width: width * 0.3,
//                                 height: height * 0.15,
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     controller.getImage(ImageSource.gallery);
//                                   },
//                                   child: const Center(
//                                     child: Icon(
//                                       size: 30,
//                                       Icons.add_a_photo,
//                                       color: ThemesStyles.secondary,
//                                     ),
//                                   ),
//                                 ),
//                               ).marginOnly(left: width * 0.0);
//                             } else {
//                               // Adjust the index to account for the first item
//                               final imagePath =
//                                   controller.selectedImagePaths[index - 1];
//                               return Stack(
//                                 children: [
//                                   Container(
//                                           clipBehavior: Clip.hardEdge,
//                                           decoration: BoxDecoration(
//                                             boxShadow: [
//                                               BoxShadow(
//                                                   spreadRadius: 0.5,
//                                                   blurRadius: 2,
//                                                   color: Colors.grey.shade300,
//                                                   offset: Offset(5, 2))
//                                             ],
//                                             borderRadius:
//                                                 BorderRadius.circular(20),
//                                           ),
//                                           width: width / 2,
//                                           height: height,
//                                           child: Image.file(File(imagePath),
//                                               fit: BoxFit.fill))
//                                       .marginOnly(left: width * 0.03),
//                                   Positioned(
//                                     top: 0,
//                                     left: 0,
//                                     child: Container(
//                                       width: 40,
//                                       height: 40,
//                                       decoration: BoxDecoration(
//                                           color: ThemesStyles.secondary,
//                                           borderRadius:
//                                               BorderRadius.circular(20)),
//                                       child: IconButton(
//                                         icon: const Icon(Icons.delete,
//                                             color: Colors.red),
//                                         onPressed: () =>
//                                             controller.removeImage(imagePath),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ).marginOnly(left: width * 0.05);
//                             }
//                           }),
//                     ).marginSymmetric(horizontal: width * 0.01),
//                   ),
//                 ],
//               ),
//             ).marginSymmetric(horizontal: width * 0.03, vertical: width * 0.03),
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: width,
//                     height: height / 4,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(
//                             color: ThemesStyles.secondary, width: 2)),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           width: width,
//                           child: DefaultFormFeild(
//                             autoFoucs: false,
//                             hintText: "service",
//                             validator: (String? value) {
//                               if (value == '') {
//                                 return "this field is required";
//                               }
//                               return null;
//                             },
//                             textEditingController: d,
//                             obscureText: false,
//                           ),
//                         )
//                             .paddingSymmetric(horizontal: width * 0.02)
//                             .marginSymmetric(
//                                 horizontal: width * 0.02,
//                                 vertical: height * 0.01),
//                         // Your existing widgets...
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Container(
//                               width: width / 2.5,
//                               child: DefaultFormFeild(
//                                 autoFoucs: false,
//                                 hintText: "Price",
//                                 validator: (String? value) {
//                                   if (value == '') {
//                                     return "this field is required";
//                                   }
//                                   return null;
//                                 },
//                                 textEditingController: d,
//                                 obscureText: false,
//                               ),
//                             ),
//                             Container(
//                               width: width / 2.5,
//                               child: DefaultFormFeild(
//                                 autoFoucs: false,
//                                 hintText: "Proportion",
//                                 validator: (String? value) {
//                                   if (value == '') {
//                                     return "this field is required";
//                                   }
//                                   return null;
//                                 },
//                                 textEditingController: d,
//                                 obscureText: false,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             DefultButton(
//                               buttonColor: ThemesStyles.secondary,
//                               borderColor: Colors.transparent,
//                               textColor: Colors.white,
//                               title: "Edit",
//                               onPressed: () {},
//                             ),
//                           ],
//                         ).marginOnly(top: height * 0.01)
//                       ],
//                     ).marginOnly(top: height * 0.01),
//                   ).marginSymmetric(horizontal: width * 0.02),
//                 ],
//               ),
//             ),
//           ],
//         ));
//   }
// }
