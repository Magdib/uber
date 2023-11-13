import 'dart:async';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uber/core/constant/hive_data.dart';

class Services extends GetxService {
  Box? userDataBox;
  Future<Services> init() async {
    await Hive.initFlutter();
    userDataBox = await Hive.openBox(HiveData.userDataBox);
    return this;
  }
}

initialServices() async {
  await Get.putAsync(() => Services().init());
}
