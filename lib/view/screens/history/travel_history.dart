import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:uber/core/constant/app_colors.dart';
import 'package:uber/core/constant/app_sizes.dart';
import 'package:uber/view/widgets/history/history_expanded.dart';
import 'package:uber/view/widgets/home/travel_data_view.dart';
import 'package:uber/view/widgets/shared/custom_app_bar.dart';

class TravelHistory extends StatelessWidget {
  const TravelHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const CustomAppBar(title: "History"),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              physics: const BouncingScrollPhysics(),
              itemCount: 4,
              separatorBuilder: (context, index) => const SizedBox(
                height: 15,
              ),
              itemBuilder: (context, index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: AppSizes.appWidth - 20,
                  padding: const EdgeInsets.only(top: 12.5, left: 3),
                  child: ExpandablePanel(
                    collapsed: ExpandableButton(
                      theme: ExpandableThemeData(
                          inkWellBorderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.black.withOpacity(0.9),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: const TravelDataView(
                              pickUpLocation: "Springwood",
                              dropOffLocation: "Bridge Farm",
                              pickTime: "11.:30 AM",
                              dropTime: "12:02 PM",
                            ),
                          ),
                        ],
                      ),
                    ),
                    expanded: const HistoryExpanded(),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
