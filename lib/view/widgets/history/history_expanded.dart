import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:uber/core/constant/app_assets.dart';
import 'package:uber/core/constant/app_colors.dart';
import 'package:uber/core/constant/app_sizes.dart';
import 'package:uber/view/widgets/home/travel_data_view.dart';

class HistoryExpanded extends StatelessWidget {
  const HistoryExpanded({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Stack(
        children: [
          Positioned(
            bottom: 20,
            child: Container(
              width: AppSizes.appWidth - 20,
              height: 380,
              decoration: BoxDecoration(
                  color: AppColors.black.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
          Positioned(
            bottom: 40,
            child: Column(
              children: [
                TravelDataView(
                  pickUpLocation: "Springwood",
                  dropOffLocation: "Bridge Farm",
                  pickTime: "11.:30 AM",
                  dropTime: "12:02 PM",
                ),
                const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  AppAssets.audiq7Image,
                  height: 120,
                  width: 282,
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: AppSizes.appWidth / 1.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Audi Q7",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 18),
                      ),
                      Text(
                        "23 \$",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 18),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                width: AppSizes.appWidth,
                height: 20,
                color: AppColors.backgroundColor,
              )),
          Positioned(
            bottom: 0,
            left: AppSizes.appWidth / 2.5,
            child: ExpandableButton(
                theme: ExpandableThemeData(
                    inkWellBorderRadius: BorderRadius.circular(12.5)),
                child: Container(
                  height: 40,
                  width: 40,
                  padding: const EdgeInsets.only(bottom: 2),
                  decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(12.5),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.secondaryColor.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                            blurStyle: BlurStyle.normal)
                      ]),
                  child: const Icon(
                    Icons.keyboard_arrow_up,
                    color: AppColors.white,
                    size: 20,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
