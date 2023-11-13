import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber/controllers/home_page_controller.dart';
import 'package:uber/core/constant/app_colors.dart';
import 'package:uber/core/constant/app_sizes.dart';

class TravelDataView extends StatelessWidget {
  const TravelDataView({
    super.key,
    required this.pickUpLocation,
    required this.dropOffLocation,
    this.pickTime,
    this.dropTime,
  });
  final String pickUpLocation;
  final String dropOffLocation;
  final String? pickTime;
  final String? dropTime;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      builder: (controller) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 7.5),
            child: EasyStepper(
              direction: Axis.vertical,
              stepRadius: 5,
              padding: EdgeInsets.only(
                left: 40,
              ),
              alignment: Alignment.centerLeft,
              activeStepBackgroundColor: AppColors.green,
              finishedStepBackgroundColor: AppColors.secondaryColor,
              borderThickness: 0,
              enableStepTapping: false,
              showLoadingAnimation: false,
              disableScroll: true,
              showScrollbar: false,
              showTitle: false,
              lineStyle: LineStyle(
                  lineLength: 95,
                  lineWidth: 10,
                  unreachedLineType: LineType.dashed,
                  defaultLineColor: AppColors.deepGrey),
              steps: [
                EasyStep(
                  customStep: SizedBox(),
                ),
                EasyStep(
                  customStep: SizedBox(),
                ),
              ],
              activeStep: 1,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: AppSizes.appWidth / 1.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "PICK UP",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    if (pickTime != null)
                      Text(
                        pickTime!,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  pickUpLocation,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 15),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: AppSizes.appWidth / 1.4,
                child: const Divider(
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(
                height: 19,
              ),
              SizedBox(
                width: AppSizes.appWidth / 1.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "DROP OFF",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    if (dropTime != null)
                      Text(
                        dropTime!,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SizedBox(
                  width: AppSizes.appWidth - 100,
                  child: Text(
                    dropOffLocation,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 15),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
