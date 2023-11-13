import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber/controllers/home_page_controller.dart';
import 'package:uber/core/constant/app_colors.dart';

class SelectCarView extends StatelessWidget {
  const SelectCarView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 15),
            child: Text(
              "Select your Uber Taxi",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 18),
            ),
          ),
          SizedBox(
            height: 146,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  controller.cars[index].image,
                  opacity: controller.carIndex == index
                      ? const AlwaysStoppedAnimation(1)
                      : const AlwaysStoppedAnimation(0.4),
                );
              },
              controller: controller.swiperController,
              scale: 0.5,
              viewportFraction: 0.62,
              onIndexChanged: (value) => controller.onCarChange(value),
              itemCount: controller.cars.length,
            ),
          ),
          ListView.separated(
              padding: const EdgeInsets.only(left: 20, bottom: 7.5, right: 20),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      index == 0
                          ? Text(
                              controller.cars[controller.carIndex].name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 18),
                            )
                          : Text(
                              controller.carsSDT[index - 1],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: AppColors.grey),
                            ),
                      Text(
                        controller.currentCarData[index],
                        style: index == 0
                            ? Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 18)
                            : Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: AppColors.white),
                      )
                    ],
                  ),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 7.5,
                  ),
              itemCount: 4)
        ],
      ),
    );
  }
}
