import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/controllers/home_page_controller.dart';
import 'package:uber/core/class/icons/custom_icons.dart';
import 'package:uber/core/constant/app_sizes.dart';
import 'package:uber/core/routes/routes.dart';
import 'package:uber/view/widgets/shared/custom_button.dart';
import 'home_dialog_view.dart';
import 'rounded_icon_button.dart';
import 'dart:ui';

class HomePageView extends StatelessWidget {
  const HomePageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      builder: (controller) => Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: controller.userLatLng, zoom: 20),
            onTap: (argument) => controller.chooseDropLocation(argument),
            onMapCreated: (mapcontroller) =>
                controller.onMapCreated(mapcontroller),
            mapType: MapType.normal,
            // polylines: Set<Polyline>.of(controller.polylines.values),
            markers: controller.markers.toSet(),
            buildingsEnabled: false,
            compassEnabled: false,
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
          ),
          Positioned(
            top: 40,
            left: 10,
            child: RoundedIconButton(
                icon: CustomIcons.menu,
                onPressed: () =>
                    controller.scaffoldKey.currentState!.openDrawer()),
          ),
          const HomeDialogView(),
          if (controller.step == 0)
            Positioned(
                bottom: 110,
                right: 10,
                child: Row(
                  children: [
                    RoundedIconButton(
                        icon: CustomIcons.recent,
                        iconSize: 20,
                        onPressed: () => Get.toNamed(AppRoutes.recentPage)),
                    const SizedBox(
                      width: 10,
                    ),
                    RoundedIconButton(
                        icon: CustomIcons.myLocation,
                        iconSize: 22.5,
                        onPressed: () => controller.mapController.animateCamera(
                            CameraUpdate.newLatLng(controller.userLatLng))),
                  ],
                )),
          if (controller.step == 2 || controller.step == 3)
            Positioned(
                bottom: 20,
                left: 25,
                child: CustomButton(
                  text: controller.step == 2 ? "Send Request" : "Confirm",
                  onPressed: controller.selectedCar != null
                      ? () => controller.nextStep()
                      : null,
                  width: AppSizes.appWidth - 50,
                )),
          BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: controller.backgroundBlur,
                  sigmaY: controller.backgroundBlur),
              child: Opacity(
                  opacity: controller.backgroundOpacity,
                  child: SizedBox(
                    height: AppSizes.appheight,
                    width: AppSizes.appWidth,
                  ))),
        ],
      ),
    );
  }
}
