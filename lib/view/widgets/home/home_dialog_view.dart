import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber/controllers/home_page_controller.dart';
import 'package:uber/core/constant/app_colors.dart';
import 'package:uber/core/constant/app_sizes.dart';

import 'select_car_type_view.dart';
import 'select_car_view.dart';
import 'start_place_data_view.dart';
import 'travel_data_view.dart';

class HomeDialogView extends StatelessWidget {
  const HomeDialogView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      builder: (controller) => Positioned(
        bottom: controller.step < 2
            ? 10
            : controller.step == 4
                ? 25
                : 100,
        left: 15,
        child: GestureDetector(
          onTap: controller.step < 2 ? () => controller.nextStep() : null,
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: AppSizes.appWidth - 30,
              padding: EdgeInsets.symmetric(
                  vertical: controller.step == 0
                      ? 17.5
                      : controller.step == 1
                          ? 25
                          : controller.step == 4
                              ? 30
                              : 10),
              decoration: BoxDecoration(
                  color: AppColors.black.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20)),
              child: controller.step == 0
                  ? StartPlaceDataView(
                      title: "From : ${controller.userLocation}",
                      subtitle: "Where to?",
                    )
                  : controller.step == 1
                      ? TravelDataView(
                          dropOffLocation: controller.dropLocation,
                          pickUpLocation: controller.userLocation,
                        )
                      : controller.step == 2
                          ? const SelectCarTypeView()
                          : controller.step == 3
                              ? const SelectCarView()
                              : Column(
                                  children: [
                                    Text("Booking successful",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontSize: 18,
                                              color: AppColors.primaryColor,
                                            )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Your booking has been confirmed!\nThe driver will pick you in ${controller.driverArriveTime}.",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: AppColors.grey),
                                    )
                                  ],
                                )),
        ),
      ),
    );
  }
}
