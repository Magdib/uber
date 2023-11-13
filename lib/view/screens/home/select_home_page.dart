import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber/controllers/home_select_controller.dart';
import 'package:uber/core/constant/app_colors.dart';
import 'package:uber/core/constant/app_sizes.dart';
import 'package:uber/view/widgets/shared/custom_button.dart';

class SelectHomePage extends StatelessWidget {
  const SelectHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeSelectController>(
        builder: (controller) => Stack(
          children: [
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: controller.userLatLng, zoom: 20),
              onTap: (argument) => controller.chooseHome(argument),
              onMapCreated: (mapcontroller) =>
                  controller.onMapCreated(mapcontroller),
              mapType: MapType.normal,
              buildingsEnabled: false,
              markers: controller.homeMarkers.toSet(),
              compassEnabled: false,
              mapToolbarEnabled: false,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
            ),
            Positioned(
                bottom: 10,
                left: 15,
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: AppSizes.appWidth - 30,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        color: AppColors.black.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: AppSizes.appWidth / 2,
                          child: Text(
                            controller.homeStreet,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        CustomButton(
                          text: "Save",
                          onPressed: controller.canSaveHome
                              ? () => controller.saveHome()
                              : null,
                          width: AppSizes.appWidth / 4,
                          height: 8,
                          lowerOpacity: true,
                        )
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}
