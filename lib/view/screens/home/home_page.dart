import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber/controllers/home_page_controller.dart';
import 'package:uber/core/class/enums/map_states.dart';
import 'package:uber/core/constant/app_colors.dart';
import 'package:uber/core/constant/app_sizes.dart';
import 'package:uber/view/widgets/home/home_drawer.dart';
import 'package:uber/view/widgets/home/home_page_view.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: controller.scaffoldKey,
        onDrawerChanged: (isOpend) => controller.onDrawerChanged(isOpend),
        drawer: const HomeDrawer(),
        body: GetBuilder<HomePageController>(
            builder: (controller) => controller.mapState ==
                    MapStates.loadingCompleted
                ? const HomePageView()
                : controller.mapState == MapStates.loading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      )
                    : Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No Data",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: AppSizes.appWidth / 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                    color: AppColors.secondaryColor,
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                    blurStyle: BlurStyle.normal)
                              ],
                            ),
                            child: MaterialButton(
                              disabledColor: AppColors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 17),
                              color: AppColors.primaryColor,
                              elevation: 15,
                              onPressed: () => controller.getStartData(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.refresh,
                                    color: AppColors.white,
                                  ),
                                  Text(
                                    "Retry",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ))));
  }
}
