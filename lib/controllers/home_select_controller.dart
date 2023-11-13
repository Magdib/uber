import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uber/core/constant/app_colors.dart';
import 'package:uber/core/constant/arguments.dart';
import 'package:uber/core/constant/hive_data.dart';
import 'package:uber/core/functions/hive_null_check.dart';
import 'package:uber/core/functions/snack_bars/custom_snack_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeSelectController extends GetxController {
  Box userDataBox = Hive.box(HiveData.userDataBox);
  late String homeStreet;
  LatLng userLatLng = Get.arguments[ArgumentsNames.userLatLng];
  late LatLng homeLatLng;
  late GoogleMapController mapController;
  List<Marker> homeMarkers = [];
  BitmapDescriptor userMarkerData = Get.arguments[ArgumentsNames.mapMarker];
  bool canSaveHome = false;
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(
        '[{"featureType": "all","elementType": "geometry","stylers": [{"color": "#0D1724"},{ "visibility": "simplified" }]},{"featureType": "all","elementType": "labels.text.stroke","stylers": [{"lightness": -80},{ "visibility": "simplified" }]},{"featureType": "administrative","elementType": "labels.text.fill","stylers": [{"color": "#37434D"}]},{"featureType": "administrative.locality","elementType": "labels.text.fill","stylers": [{"color": "#d59563"}]},{"featureType": "poi","elementType": "labels.text.fill","stylers": [{"color": "#d59563"}]},{"featureType": "poi.park","elementType": "geometry","stylers": [{"color": "#263c3f"}]},{"featureType": "poi.park","elementType": "labels.text.fill","stylers": [{"color": "#6b9a76"}]},{"featureType": "road","elementType": "geometry.fill","stylers": [{"color": "#2b3544"}]},{"featureType": "road","elementType": "labels.text.fill","stylers": [{"color": "#9ca5b3"}]},{"featureType": "road.arterial","elementType": "geometry.fill","stylers": [{"color": "#000000"}]},{"featureType": "road.arterial","elementType": "geometry.stroke","stylers": [{"color": "#212a37"}]},{"featureType": "road.highway","elementType": "geometry.fill","stylers": [{"color": "#000000"}]},{"featureType": "road.highway","elementType": "geometry.stroke","stylers": [{"color": "#1f2835"}]},{"featureType": "road.highway","elementType": "labels.text.fill","stylers": [{"color": "#f3d19c"}]},{"featureType": "road.local","elementType": "geometry.fill","stylers": [{"color": "#000000"}]},{"featureType": "road.local","elementType": "geometry.stroke","stylers": [{"color": "#212a37"}]},{"featureType": "transit","elementType": "geometry","stylers": [{"color": "#2f3948"}]},{"featureType": "transit.station","elementType": "labels.text.fill","stylers": [{"color": "#d59563"}]},{"featureType": "water","elementType": "geometry","stylers": [{"color": "#17263c"}]},{"featureType": "water","elementType": "labels.text.fill","stylers": [{"color": "#515c6d"}]},{"featureType": "water","elementType": "labels.text.stroke","stylers": [{"lightness": -20}]},{"featureType": "administrative","elementType": "geometry","stylers": [{"visibility": "off"}]},{"featureType": "poi","stylers": [{"visibility": "off"}]},{"featureType": "road","elementType": "labels.icon","stylers": [{"visibility": "off"}]},{"featureType": "transit","stylers": [{"visibility": "off"}]},{"elementType": "labels.text","stylers": [{"color": "#282525"}]},{"elementType": "labels.text.fill","stylers": [{"color": "#37434d"}]},{"elementType": "labels.text.stroke","stylers": [{"color": "#2d2a2a"}]}]');
  }

  void chooseHome(LatLng argument) async {
    homeStreet = "Loading...";
    canSaveHome = false;
    homeMarkers.clear();
    homeMarkers.add(Marker(
        markerId: const MarkerId("1"),
        icon: userMarkerData,
        position: argument));
    update();
    try {
      homeStreet = await placemarkFromCoordinates(
              argument.latitude, argument.longitude,
              localeIdentifier: "en")
          .then((value) => value.first.street!);
      canSaveHome = true;
      homeLatLng = argument;
    } catch (e) {
      homeStreet = "bad connection";
    }
    update();
  }

  void saveHome() {
    if (homeStreet != "Loading...") {
      userDataBox.put(HiveData.home, homeStreet);
      userDataBox.put(HiveData.homeLat, homeLatLng.latitude);
      userDataBox.put(HiveData.homeLong, homeLatLng.longitude);
      Get.back();
      Fluttertoast.showToast(
          msg: "Home Saved",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          textColor: AppColors.white,
          fontSize: 16.0);
    }
  }

  @override
  void onReady() {
    if (homeStreet == "empty") {
      customSnackBar("Home", "Select your home location from the map",
          snackPosition: SnackPosition.TOP);
    }
    super.onReady();
  }

  @override
  void onInit() {
    homeStreet = hiveNullCheck(HiveData.home, "empty");
    if (userDataBox.get(HiveData.homeLat) != null) {
      homeLatLng = LatLng(userDataBox.get(HiveData.homeLat),
          userDataBox.get(HiveData.homeLong));
      homeMarkers.add(Marker(
          markerId: const MarkerId("1"),
          icon: userMarkerData,
          position: homeLatLng));
    }
    super.onInit();
  }

  @override
  void onClose() {
    mapController.dispose();
    super.onClose();
  }
}
