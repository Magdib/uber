import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber/controllers/home_page_controller.dart';
import 'package:uber/core/constant/app_colors.dart';
import 'package:uber/core/constant/app_sizes.dart';

class SelectCarTypeView extends StatelessWidget {
  const SelectCarTypeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      builder: (controller) => Column(
        children: [
          SizedBox(
              width: AppSizes.appWidth,
              height: 166,
              child: Center(
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 30,
                        ),
                    itemBuilder: (context, index) => Column(
                          children: [
                            GestureDetector(
                              onTap: () => controller.selectCar(index),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 50),
                                    height: 75,
                                    width: 75,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        gradient: LinearGradient(
                                            colors: controller
                                                    .carsTypeList[index]
                                                    .selected
                                                ? [
                                                    AppColors.secondaryColor,
                                                    AppColors.primaryColor
                                                  ]
                                                : [
                                                    AppColors.carGradientSColor,
                                                    AppColors.carGradientEColor
                                                  ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter)),
                                  ),
                                  Positioned(
                                    top: controller.carsTypeList[index].selected
                                        ? 5
                                        : 20,
                                    child: Image.asset(
                                      controller.carsTypeList[index].image,
                                      height: 110,
                                      width: 75,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              controller.carsTypeList[index].type,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 14),
                            )
                          ],
                        ),
                    itemCount: 3),
              )),
        ],
      ),
    );
  }
}
