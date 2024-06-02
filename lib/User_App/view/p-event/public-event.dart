import 'package:events_app/User_App/components/home/person_kind_card.dart';
import 'package:events_app/User_App/view/p-event/offer.dart';
import 'package:events_app/User_App/view/p-event/p_event_details.dart';
import 'package:events_app/User_App/view/p-event/puplic_card.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';

class PublicEventPage extends StatefulWidget {
   PublicEventPage({super.key});

  @override
  State<PublicEventPage> createState() => _PublicEventPageState();
}

class _PublicEventPageState extends State<PublicEventPage> {
 bool isAll = true;

 bool isCultural = false;

 bool isEntertaining = false;

 bool isSocial = false;

 bool isEdiucational = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     body: Padding(
       padding:  EdgeInsets.symmetric(horizontal:ThemesStyles.paddingprimary,vertical: ThemesStyles.paddingprimary),
       child: Column(
                     mainAxisSize: MainAxisSize.min,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       //فعاليات عامة
                       const PuplicEventCard(
                         isNewOnApp: false,
                  image: 'assets/images/person.png',
                  content: "organizers",
                  width: 200,
                       ),
                       //=====================================3=======================================
                       Padding(
                         padding: const EdgeInsets.symmetric(vertical:20.0),
                         child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                           child: Row(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                                                  
                               ElevatedButton(
                                         onPressed: () {
                                       setState(() {
                                             isAll = true;
                                             isCultural = false;
                           
                                             isEntertaining = false;
                           
                                             isSocial = false;
                           
                                             isEdiucational = false;
                                       });
                                         },
                                         style: ElevatedButton.styleFrom(
                                          primary:isAll ?ThemesStyles.primary: ThemesStyles.secondary,
                                           shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(8),
                                           ),
                                         ),
                                         child: const Text(
                                           'All',
                                           style: TextStyle(
                                             fontSize:11,
                                             color: Colors.white,
                                           ),
                                         ),
                                       ),
                             Padding(
                               padding: const EdgeInsets.symmetric(horizontal:2),
                               child: ElevatedButton(
                                           onPressed: () {
                                           setState(() {
                                             isCultural = true;
                                             isAll = false;
                                             isEntertaining = false;
                           
                                             isSocial = false;
                           
                                             isEdiucational = false;
                                           });
                                           },
                                           style: ElevatedButton.styleFrom(
                                               primary:isCultural ?ThemesStyles.primary: ThemesStyles.secondary,
                                             shape: RoundedRectangleBorder(
                                               borderRadius: BorderRadius.circular(8),
                                             ),
                                           ),
                                           child: const Text(
                                             'Cultural',
                                             style: TextStyle(
                                               fontSize:11,
                                               color: Colors.white,
                                             ),
                                           ),
                                         ),
                             ),
                             Padding(
                               padding: const EdgeInsets.symmetric(horizontal:2),
                               child: ElevatedButton(
                                           onPressed: () {
                                            setState(() {
                                               isEdiucational =true;
                                              isAll = false;
                                             isCultural = false;
                           
                                             isEntertaining = false;
                           
                                             isSocial = false;
                           
                                            });
                                           },
                                           style: ElevatedButton.styleFrom(
                                             primary:isEdiucational ?ThemesStyles.primary: ThemesStyles.secondary,
                                             shape: RoundedRectangleBorder(
                                               borderRadius: BorderRadius.circular(8),
                                             ),
                                           ),
                                           child: const Text(
                                             'Ediucational',
                                             style: TextStyle(
                                               fontSize:11,
                                               color: Colors.white,
                                             ),
                                           ),
                                         ),
                             ),
                             Padding(
                               padding: const EdgeInsets.symmetric(horizontal:2),
                               child: ElevatedButton(
                                           onPressed: () {
                                         setState(() {
                                             isEntertaining =true;
                           
                                             isAll = false; 
                           
                                             isCultural = false;
                           
                                             isSocial = false;
                           
                                             isEdiucational = false;
                                         });
                                           },
                                           style: ElevatedButton.styleFrom(
                                            primary:isEntertaining ?ThemesStyles.primary: ThemesStyles.secondary,
                                             shape: RoundedRectangleBorder(
                                               borderRadius: BorderRadius.circular(8),
                                             ),
                                           ),
                                           child: const Text(
                                             'Entertaining',
                                             style: TextStyle(
                                               fontSize:11,
                                               color: Colors.white,
                                             ),
                                           ),
                                         ),
                             ),
                             Padding(
                               padding: const EdgeInsets.symmetric(horizontal:2),
                               child: ElevatedButton(
                                           onPressed: () {
                                         setState(() {
                                             isSocial = true;
                           
                                             isAll = false;
                           
                                             isCultural = false;
                           
                                             isEntertaining = false;
                           
                                             isEdiucational = false;
                                         });
                                           },
                                           style: ElevatedButton.styleFrom(
                                             primary:isSocial ?ThemesStyles.primary: ThemesStyles.secondary,
                                             shape: RoundedRectangleBorder(
                                               borderRadius: BorderRadius.circular(8),
                                             ),
                                           ),
                                           child: const Text(
                                             'Social',
                                             style: TextStyle(
                                               fontSize:11,
                                               color: Colors.white,
                                             ),
                                           ),
                                         ),
                             ),
                             ],
                           ),
                         ),
                       ),
                    //=====================================4======================================
                    GestureDetector(
                      onTap: (){
                        Get.to(P_Event_Details());
                      },
                      child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 20.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(ThemesStyles.borderradiusprimary + 10),
                                ),
                                color
                                    : const Color.fromARGB(255, 243, 243, 243),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                                  decoration: BoxDecoration(
                                    image:const  DecorationImage(image:AssetImage(
                                      "assets/images/ballons.jpeg"
                                    ),
                                    fit: BoxFit.contain
                                     ),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(width: 1, color: ThemesStyles.textColor,)
                                  ),
                                  width: 130,
                                  height: 130,
                                  // child: Image.asset("assets/images/ballons.jpeg"),
                                  
                                  ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom:5.0),
                                      child: Container(
                                        width: MediaQuery.sizeOf(context).width * 0.4,
                                        child: Text("Mural Art Festival",
                                          overflow: TextOverflow.ellipsis
                                        ,style: TextStyle(
                                          fontSize: ThemesStyles.mainFontSize,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                      ),
                                    ),
                                    // Text("عدد التذاكر المباعة: "),
                                    // Text("عدد التذاكر الغير مباعة: "),
                                    // ignore: sized_box_for_whitespace
                                    Container(
                                      width: MediaQuery.sizeOf(context).width * 0.4,
                                      child: Text("Wed, Dec 18 - 18.00 - 22.00 PM",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: ThemesStyles.littelFontSize,
                                        color: ThemesStyles.primary,
                                      )),
                                    ),
                                    Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                          Icons.money,
                                          color: ThemesStyles.primary,
                                        ),

                                        Text("55000 SYP",style: TextStyle(
                                      fontSize: ThemesStyles.littelFontSize,
                                    ),),
                                          ],
                                        ),
                                                                      // faveorite button
                                 IconButton(
                                  onPressed: (){}, 
                                  icon: const Icon(
                                          Icons.favorite,
                                          color: ThemesStyles.primary,
                                        ),),
                                      ],
                                    ),
                                  ],
                                ),
                              ],),
                              
                            ),
                           
                          ),
                    ),
                     
                     ],
                   ),
     ),
    );
  }
}