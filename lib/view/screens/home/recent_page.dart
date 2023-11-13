import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber/controllers/home_page_controller.dart';
import 'package:uber/core/class/icons/custom_icons.dart';
import 'package:uber/core/constant/app_colors.dart';
import 'package:uber/core/constant/app_sizes.dart';
import 'package:uber/view/widgets/home/travel_data_view.dart';
import 'package:uber/view/widgets/shared/custom_button.dart';

class RecentPage extends StatelessWidget {
  const RecentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomePageController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(children: [
            const SizedBox(
              height: 30,
            ),
            AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: AppSizes.appWidth - 30,
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(20)),
                child: TravelDataView(
                  dropOffLocation: controller.dropLocation,
                  pickUpLocation: controller.userLocation,
                )),
            Expanded(
              flex: 7,
              child: SizedBox(
                height: AppSizes.appheight / 2,
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 25),
                    itemBuilder: (context, index) => InkWell(
                          splashColor: AppColors.primaryColor,
                          onTap: () => controller.selectRecent(index),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      index == 0
                                          ? CustomIcons.home
                                          : CustomIcons.recent,
                                      color: AppColors.white,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    index == 0
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Home",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              Text(
                                                controller.recentPlaces[index],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color: AppColors.white),
                                              )
                                            ],
                                          )
                                        : Text(
                                            controller.recentPlaces[index],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          )
                                  ],
                                ),
                                if (index == controller.recentPlaces.length - 1)
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Divider(
                                      color: AppColors.grey,
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                    separatorBuilder: (context, index) => const Divider(
                          color: AppColors.grey,
                        ),
                    itemCount: controller.recentPlaces.length),
              ),
            ),
            Expanded(
                child: CustomButton(
              text: "Done",
              width: AppSizes.appWidth - 50,
              onPressed: controller.dropLocation == "Where to?"
                  ? null
                  : () {
                      controller.step = 1;
                      controller.nextStep();
                      Get.back();
                    },
            )),
          ]),
        ),
      ),
    );
  }
}
