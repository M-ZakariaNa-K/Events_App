import 'package:events_app/User_App/controllers/reservation/reservation_controller.dart';
import 'package:events_app/User_App/view/reservations/public_events_tickets_page.dart';
import 'package:events_app/User_App/view/reservations/reservations_user.dart';
import 'package:events_app/common/Util/lang_controller.dart';
import 'package:events_app/common/core/constants/theme.dart';
import 'package:events_app/common/core/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvestorReservationsAsUserWidget extends StatelessWidget {
  const InvestorReservationsAsUserWidget({
    super.key,
    required this.isTicketsCard,
  });
  final bool isTicketsCard;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {},
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Stack(
                            children: [
                              Opacity(
                                opacity: isTicketsCard
                                    ? Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? .5
                                        : 1
                                    : 0.5,
                                child: Image.asset(
                                  isTicketsCard
                                      ? 'assets/images/background.jpg'
                                      : 'assets/images/OffersCardBackgroundGraident.jpeg',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 200,
                                ),
                              ),
                              //===================the Left Icon and its text===============
                              Positioned(
                                top: 20,
                                left: LanguageRadioController().selectedValue
                                    ? 10
                                    : 0,
                                // right: LanguageRadioController()
                                //         .selectedValue
                                //     ? 0
                                //     : 10,
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      ThemesStyles.paddingprimary),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        0), // Half of container width/height for perfect circle
                                    child: SizedBox(
                                      width: 150,
                                      height: 150,
                                      child: isTicketsCard
                                          ? const Icon(
                                              Icons.card_membership_sharp,
                                              size: 100,
                                              color: ThemesStyles.primary,
                                            )
                                          : Image.asset(
                                              "assets/images/planner.png",
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              //===================eND the Left Icon and its text===============
                              //===================Start the TAG ===============
                              Positioned(
                                top: 30,
                                // left: LanguageRadioController()
                                //         .selectedValue
                                //     ? 0
                                //     : 20,
                                right: LanguageRadioController().selectedValue
                                    ? 0
                                    : 20,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: SizedBox(
                                    width: 170,
                                    child: Text(
                                      isTicketsCard
                                          ? "Tickits: If you want to see your public event tickets cleck on:"
                                          : 'Investor as user: If you want to see your reservations as user cleck on:',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ThemesStyles.mainFontSize - 2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              //===================End the TAG ===============
                              //===================Start the see offers ===============

                              Positioned(
                                bottom: 10,
                                right: 10,
                                child: Opacity(
                                  opacity: 1
                                  // - _animation!.value,
                                  ,
                                  child: MaterialButton(
                                    onPressed: !isTicketsCard
                                        ? () {
                                            final reservationController =
                                                Get.put(
                                                    ReservationController());
                                            reservationController
                                                .isPrivateSelected.value = true;
                                            reservationController
                                                .isUpcomingSelected
                                                .value = true;
                                            reservationController
                                                .reservationsUserList
                                                .clear();
                                            reservationController
                                                .getReservationItems(
                                                    service_kind: "private",
                                                    date: ">=");
                                            Get.to(() => ReservationsUserPage(
                                                  isCommingFromInvestorSide:
                                                      true,
                                                  isTheReservationDetailComeFromInvestorHalls:
                                                      false,
                                                ));
                                          }
                                        : () async {
                                            final reservationController =
                                                Get.put(
                                                    ReservationController());
                                            await reservationController
                                                .getPublicEventTickets();
                                            Get.to(() =>
                                                const PublicEventTicketsPage());
                                          },
                                    color: ThemesStyles.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      isTicketsCard
                                          ? "see tickets"
                                          : 'see reservations',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
