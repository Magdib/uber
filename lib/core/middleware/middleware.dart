import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber/core/constant/hive_data.dart';

import '../routes/routes.dart';
import '../services/services.dart';

class MiddleWare extends GetMiddleware {
  @override
  int? get priority => 1;
  Services myServices = Get.find();
  @override
  RouteSettings? redirect(String? route) {
    switch (myServices.userDataBox!.get(HiveData.step)) {
      case 1:
        return const RouteSettings(name: AppRoutes.homePageRoute);
      // case 2:
      //   return const RouteSettings(name: AppRoutes.fastModePageRoute);
      default:
        return null;
    }
  }
}
