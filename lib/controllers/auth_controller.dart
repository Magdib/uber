import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uber/core/constant/hive_data.dart';
import 'package:uber/core/functions/snack_bars/custom_snack_bar.dart';
import 'package:uber/core/routes/routes.dart';

class AuthController extends GetxController {
  late TextEditingController countryCodeController;
  late TextEditingController phoneNumberController;
  late TextEditingController emailController;
  late TextEditingController nameController;
  late TapGestureRecognizer privacyPolicyTap;
  late FocusNode firstNode;
  late FocusNode secondeNode;
  late FocusNode thirdNode;
  late FocusNode fourthNode;
  late List<FocusNode> focusList;
  String firstNumber = '';
  String secondeNumber = '';
  String thirdNumber = '';
  String fourthNumber = '';
  bool canNavigate = false;
  GlobalKey<FormState> phoneFormState = GlobalKey<FormState>();
  GlobalKey<FormState> emailFormState = GlobalKey<FormState>();
  GlobalKey<FormState> nameFormState = GlobalKey<FormState>();
  late Box userDataBox;
  void navigateToOtpPage() {
    FormState formData = phoneFormState.currentState!;
    if (formData.validate()) {
      formData.save();
      Get.toNamed(AppRoutes.phoneOtpPageRoute);
    }
  }

  void otpChanged(BuildContext context, String val, int index) {
    if (index != focusList.length - 1) {
      FocusScope.of(context).requestFocus(focusList[index + 1]);
    } else {
      FocusScope.of(context).unfocus();
    }
    switch (index) {
      case 0:
        firstNumber = val;
        break;
      case 1:
        secondeNumber = val;
        break;
      case 2:
        thirdNumber = val;
        break;
      default:
        fourthNumber = val;
    }
    nextButtonCheck();
  }

  nextButtonCheck() {
    if (firstNumber.isNotEmpty &&
        secondeNumber.isNotEmpty &&
        thirdNumber.isNotEmpty &&
        fourthNumber.isNotEmpty) {
      canNavigate = true;
    } else {
      canNavigate = false;
    }
    update();
  }

  onWillPopPhoneNumber() {
    firstNumber = '';
    secondeNumber = '';
    thirdNumber = '';
    fourthNumber = '';
    canNavigate = false;
    Get.back();
    return Future.value(false);
  }

  navigateToEmailOtp() {
    FormState formData = emailFormState.currentState!;
    if (formData.validate()) {
      firstNumber = '';
      secondeNumber = '';
      thirdNumber = '';
      fourthNumber = '';
      canNavigate = false;
      formData.save();
      Get.toNamed(AppRoutes.emailOtpPageRoute);
    }
  }

  Future<void> navigateToHomePage(BuildContext context) async {
    FormState formData = nameFormState.currentState!;
    if (formData.validate()) {
      formData.save();
      FocusScope.of(context).unfocus();
      LocationPermission permission;
      bool serviceEnabled;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Future.delayed(const Duration(milliseconds: 100));
        customSnackBar('Location services are disabled.',
            "Please enable location services in your phone and try again.");
      } else {
        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            await Future.delayed(const Duration(milliseconds: 100));
            customSnackBar('Denied', "Location permissions are denied");
          } else {
            saveData();
          }
        } else {
          saveData();
        }
        if (permission == LocationPermission.deniedForever) {
          customSnackBar('Denied for ever',
              "Location permissions are permanently denied,you can't access the app without it.");
        }
      }
    }
  }

  saveData() {
    userDataBox.put(HiveData.step, 1);
    userDataBox.put(HiveData.userName, nameController.text);
    userDataBox.put(HiveData.phoneNumber,
        "${countryCodeController.text}${phoneNumberController.text}");
    userDataBox.put(HiveData.email, emailController.text);
    Get.offAllNamed(AppRoutes.homePageRoute);
  }

  @override
  void onReady() async {
    userDataBox = await Hive.openBox(HiveData.userDataBox);
    super.onReady();
  }

  @override
  void onInit() {
    countryCodeController = TextEditingController(text: "+963");
    phoneNumberController = TextEditingController();
    emailController = TextEditingController();
    nameController = TextEditingController();
    privacyPolicyTap = TapGestureRecognizer()
      ..onTap = () => log("Open privacy&policy in webview");
    firstNode = FocusNode();
    secondeNode = FocusNode();
    thirdNode = FocusNode();
    fourthNode = FocusNode();
    focusList = [firstNode, secondeNode, thirdNode, fourthNode];

    super.onInit();
  }

  @override
  void onClose() {
    countryCodeController.dispose();
    phoneNumberController.dispose();
    privacyPolicyTap.dispose();
    firstNode.dispose();
    secondeNode.dispose();
    thirdNode.dispose();
    fourthNode.dispose();
    emailController.dispose();
    nameController.dispose();
    super.onClose();
  }
}
