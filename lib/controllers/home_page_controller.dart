import 'dart:async';
import 'dart:developer';
// import 'dart:math' as math;

import 'package:card_swiper/card_swiper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uber/core/class/enums/map_states.dart';
import 'package:uber/core/class/icons/custom_icons.dart';
import 'package:uber/core/constant/app_assets.dart';
import 'package:uber/core/constant/arguments.dart';
// import 'package:uber/core/constant/app_colors.dart';
import 'package:uber/core/constant/constant_lists.dart';
import 'package:uber/core/constant/hive_data.dart';
import 'package:uber/core/functions/hive_null_check.dart';
import 'package:uber/core/functions/snack_bars/custom_snack_bar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uber/core/routes/routes.dart';
import 'package:uber/model/car_model.dart';
import 'package:uber/model/cars_type_model.dart';
import 'package:uber/model/drawer_list_model.dart';

class HomePageController extends GetxController {
  late Box userDataBox;
  late String userName;
  late String email;
  late LatLng userLatLng;
  late String userLocation;
  String dropLocation = "Where to?";
  late LatLng dropLatLng;
  int step = 0;
  late BitmapDescriptor userMarkerData;
  late BitmapDescriptor carsMarkerData;
  List<Marker> markers = [];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  late List<DrawerListModel> drawerDataList;
  // Map<PolylineId, Polyline> polylines = {};
  // List<LatLng> polylineCoordinates = [];
  // PolylinePoints polylinePoints = PolylinePoints();
  StreamSubscription<Position>? postionStream;
  MapStates mapState = MapStates.loading;
  // final String googleApikey = "AIzaSyBgfib3EBAqJey298MtnV0hD2yjfBV5d4I";
  late GoogleMapController mapController;
  late String dropPlace;
  final List<CarsTypeModel> carsTypeList = ConstantLists.carsTypeList;
  final List<String> recentPlaces = ConstantLists.recentPlaces;
  int carIndex = 0;
  late List<String> currentCarData;
  late String driverArriveTime;
  late SwiperController swiperController;
  late String userImage;
  double backgroundBlur = 0.0;
  double backgroundOpacity = 0.0;
  List<CarModel> cars = [
    CarModel(
        name: "Audi Q7",
        image: AppAssets.audiq7Image,
        seatsNumber: 4,
        latLng: const LatLng(34.87615929157246, 35.89323453605175)),
    CarModel(
        name: "Car 2",
        image: AppAssets.carImage,
        seatsNumber: 2,
        latLng: const LatLng(34.87493885398512, 35.89158866554499)),
    CarModel(
        name: "Car 3",
        image: AppAssets.carImage,
        seatsNumber: 2,
        latLng: const LatLng(34.877195975394336, 35.89255392551422)),
  ];
  List<String> carsSDT = ['Seat Availability', "Distance", "Time"];
  int? selectedCar;
  getStartData() async {
    if (mapState != MapStates.loading) {
      mapState = MapStates.loading;
      update();
    }
    LocationPermission permission;
    bool serviceEnabled;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    log("20% Completed");
    if (!serviceEnabled) {
      await Future.delayed(const Duration(milliseconds: 100));
      customSnackBar('Location services are disabled.',
          "Please enable location services in your phone and try again.");
      mapState = MapStates.error;
    } else {
      permission = await Geolocator.checkPermission();
      log("40% Completed");
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          await Future.delayed(const Duration(milliseconds: 100));
          customSnackBar('Denied', "Location permissions are denied");
          mapState = MapStates.error;
        } else {
          await allowAppUse();
        }
      } else {
        log("60% Completed");
        await allowAppUse();
      }
      if (permission == LocationPermission.deniedForever) {
        customSnackBar('Denied for ever',
            "Location permissions are permanently denied,you can't access the app without it.");
        mapState = MapStates.error;
      }
    }
    update();
  }

  allowAppUse() async {
    Position userPosition = await Geolocator.getCurrentPosition();
    log("80% Completed");
    userLatLng = LatLng(userPosition.latitude, userPosition.longitude);
    markers = [
      Marker(
        position: LatLng(userLatLng.latitude, userLatLng.longitude),
        markerId: const MarkerId('1'),
        icon: userMarkerData,
      ),
      Marker(
        position: cars[0].latLng!,
        markerId: const MarkerId('2'),
        icon: carsMarkerData,
      ),
      Marker(
        position: cars[1].latLng!,
        markerId: const MarkerId('3'),
        icon: carsMarkerData,
      ),
      Marker(
        position: cars[2].latLng!,
        markerId: const MarkerId('4'),
        icon: carsMarkerData,
      ),
    ];
    try {
      userLocation = await placemarkFromCoordinates(
              userLatLng.latitude, userLatLng.longitude,
              localeIdentifier: "en")
          .then((value) => value.first.street!);
      mapState = MapStates.loadingCompleted;

      log("100% Completed");
    } catch (e) {
      mapState = MapStates.error;
    }
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(
        '[{"featureType": "all","elementType": "geometry","stylers": [{"color": "#0D1724"},{ "visibility": "simplified" }]},{"featureType": "all","elementType": "labels.text.stroke","stylers": [{"lightness": -80},{ "visibility": "simplified" }]},{"featureType": "administrative","elementType": "labels.text.fill","stylers": [{"color": "#37434D"}]},{"featureType": "administrative.locality","elementType": "labels.text.fill","stylers": [{"color": "#d59563"}]},{"featureType": "poi","elementType": "labels.text.fill","stylers": [{"color": "#d59563"}]},{"featureType": "poi.park","elementType": "geometry","stylers": [{"color": "#263c3f"}]},{"featureType": "poi.park","elementType": "labels.text.fill","stylers": [{"color": "#6b9a76"}]},{"featureType": "road","elementType": "geometry.fill","stylers": [{"color": "#2b3544"}]},{"featureType": "road","elementType": "labels.text.fill","stylers": [{"color": "#9ca5b3"}]},{"featureType": "road.arterial","elementType": "geometry.fill","stylers": [{"color": "#000000"}]},{"featureType": "road.arterial","elementType": "geometry.stroke","stylers": [{"color": "#212a37"}]},{"featureType": "road.highway","elementType": "geometry.fill","stylers": [{"color": "#000000"}]},{"featureType": "road.highway","elementType": "geometry.stroke","stylers": [{"color": "#1f2835"}]},{"featureType": "road.highway","elementType": "labels.text.fill","stylers": [{"color": "#f3d19c"}]},{"featureType": "road.local","elementType": "geometry.fill","stylers": [{"color": "#000000"}]},{"featureType": "road.local","elementType": "geometry.stroke","stylers": [{"color": "#212a37"}]},{"featureType": "transit","elementType": "geometry","stylers": [{"color": "#2f3948"}]},{"featureType": "transit.station","elementType": "labels.text.fill","stylers": [{"color": "#d59563"}]},{"featureType": "water","elementType": "geometry","stylers": [{"color": "#17263c"}]},{"featureType": "water","elementType": "labels.text.fill","stylers": [{"color": "#515c6d"}]},{"featureType": "water","elementType": "labels.text.stroke","stylers": [{"lightness": -20}]},{"featureType": "administrative","elementType": "geometry","stylers": [{"visibility": "off"}]},{"featureType": "poi","stylers": [{"visibility": "off"}]},{"featureType": "road","elementType": "labels.icon","stylers": [{"visibility": "off"}]},{"featureType": "transit","stylers": [{"visibility": "off"}]},{"elementType": "labels.text","stylers": [{"color": "#282525"}]},{"elementType": "labels.text.fill","stylers": [{"color": "#37434d"}]},{"elementType": "labels.text.stroke","stylers": [{"color": "#2d2a2a"}]}]');
  }

  nextStep() async {
    switch (step) {
      case 0:
        step = 1;

        break;
      case 1:
        if (dropLocation != "Where to?" &&
            dropLocation != "Loading..." &&
            dropLocation != "bad connection") {
          step = 2;
        }
        break;
      case 2:
        step = 3;
        swiperController = SwiperController();
        for (int i = 0; i < cars.length; i++) {
          cars[i].userDistance = Geolocator.distanceBetween(
                userLatLng.latitude,
                userLatLng.longitude,
                cars[i].latLng!.latitude,
                cars[i].latLng!.longitude,
              ) /
              1000;
          cars[i].distance = Geolocator.distanceBetween(
                      dropLatLng.latitude,
                      dropLatLng.longitude,
                      userLatLng.latitude,
                      userLatLng.longitude) /
                  1000 +
              cars[i].userDistance!;
          cars[i].time = (cars[i].distance! * 2).toStringAsFixed(1);
          cars[i].price = cars[i].distance! * 3;
        }
        currentCarData = [
          "${cars[0].price!.toStringAsFixed(1)} \$",
          "${cars[0].seatsNumber} Person",
          "${cars[0].distance!.toStringAsFixed(1)} kms",
          "${cars[0].time} mins"
        ];
        driverArriveTime = (cars[0].userDistance! * 2).toStringAsFixed(1);
        if (double.parse(driverArriveTime) < 1) {
          driverArriveTime =
              "${(double.parse(driverArriveTime) * 60).round()} seconds";
        }
        break;
      case 3:
        // await addPolyline(cars[swiperController.index].latLng!, userLatLng);
        swiperController.dispose();
        step = 4;
        break;
    }
    update();
  }

  chooseDropLocation(LatLng argument) async {
    if (step == 1) {
      dropLocation = "Loading...";
      update();
      try {
        dropLocation = await placemarkFromCoordinates(
                argument.latitude, argument.longitude,
                localeIdentifier: "en")
            .then((value) => value.first.street!);
        dropLatLng = argument;
      } catch (e) {
        dropLocation = "bad connection";
      }
    }
    update();
  }

  void selectRecent(int index) {
    dropLocation = recentPlaces[index];
    dropLatLng = LatLng(userLatLng.latitude, userLatLng.longitude);
    update();
  }

  void selectCar(int index) {
    selectedCar = index;
    for (int i = 0; i < carsTypeList.length; i++) {
      carsTypeList[i].selected = false;
    }
    carsTypeList[index].selected = true;
    update();
  }

  onCarChange(int index) {
    carIndex = index;

    driverArriveTime = (cars[0].userDistance! * 2).toStringAsFixed(1);
    if (double.parse(driverArriveTime) < 1) {
      driverArriveTime =
          "${(double.parse(driverArriveTime) * 60).round()} seconds";
    }
    currentCarData = [
      "${cars[index].price!.toStringAsFixed(1)} \$",
      "${cars[index].seatsNumber} Person",
      "${cars[index].distance!.toStringAsFixed(1)} kms",
      "${cars[index].time} mins"
    ];
    update();
  }

  // addPolyline(LatLng startLatLng, LatLng endLatLng) async {
  //   await polylinePoints.getRouteBetweenCoordinates(
  //       googleApikey,
  //       PointLatLng(startLatLng.latitude, startLatLng.longitude), //source
  //       PointLatLng(endLatLng.latitude, endLatLng.longitude), //destination
  //       travelMode: TravelMode.driving);
  //   polylineCoordinates
  //       .add(LatLng(startLatLng.latitude, startLatLng.longitude));
  //   polylineCoordinates.add(LatLng(endLatLng.latitude, endLatLng.longitude));

  //   int polylineId = math.Random().nextInt(1000);
  //   PolylineId id = PolylineId("$polylineId");
  //   Polyline polyline = Polyline(
  //       polylineId: id,
  //       color: AppColors.carGradientEColor,
  //       points: polylineCoordinates);
  //   polylines[id] = polyline;
  // }
  pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? ximage = await picker.pickImage(source: ImageSource.gallery);
    if (ximage != null) {
      userImage = ximage.path;
      update();
    }
  }

  onDrawerChanged(bool isOpend) {
    if (isOpend) {
      backgroundOpacity = 1;
      backgroundBlur = 3.0;
      log("Open Drawer");
    } else {
      backgroundOpacity = 0.0;
      backgroundBlur = 0.0;
      log("Close Drawer");
    }
    update();
  }

  @override
  void onReady() async {
    userDataBox = await Hive.openBox(HiveData.userDataBox);
    userName = userDataBox.get(HiveData.userName);
    email = userDataBox.get(HiveData.email);
    userImage = hiveNullCheck(HiveData.image, AppAssets.anonymousPerson);
    userMarkerData = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(
          devicePixelRatio: 0.5,
          size: Size(20, 20),
        ),
        AppAssets.userMarkerImage);
    carsMarkerData = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(
          size: Size(5, 5),
        ),
        AppAssets.carMarkerImage);
    ConnectivityResult connectionState =
        await Connectivity().checkConnectivity();
    if (connectionState == ConnectivityResult.wifi ||
        connectionState == ConnectivityResult.mobile ||
        connectionState == ConnectivityResult.vpn) {
      await getStartData();
    } else {
      customSnackBar("No Internet",
          "There is no internet connection please connect to wifi or enable mobile data");
      Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        if ((result == ConnectivityResult.wifi ||
                result == ConnectivityResult.mobile) &&
            mapState != MapStates.loadingCompleted) {
          await getStartData();
        }
      });
      mapState = MapStates.error;
      update();
    }

    super.onReady();
  }

  @override
  void onInit() {
    drawerDataList = [
      DrawerListModel(
          icon: CustomIcons.home,
          text: "Home",
          onTap: () {
            scaffoldKey.currentState!.closeDrawer();
            Get.toNamed(AppRoutes.selectHomePage, arguments: {
              ArgumentsNames.userLatLng: userLatLng,
              ArgumentsNames.mapMarker: userMarkerData
            });
          }),
      DrawerListModel(
          icon: CustomIcons.recent,
          text: "Travel History",
          onTap: () {
            scaffoldKey.currentState!.closeDrawer();
            Get.toNamed(AppRoutes.travelPage);
          }),
      DrawerListModel(
          icon: CustomIcons.notification,
          text: "Notifications",
          onTap: () {
            scaffoldKey.currentState!.closeDrawer();
            Get.toNamed(AppRoutes.notificationsPage);
          }),
      DrawerListModel(
          icon: CustomIcons.settings,
          text: "Settings",
          onTap: () {
            scaffoldKey.currentState!.closeDrawer();
            Get.toNamed(AppRoutes.settingsPage);
          }),
      DrawerListModel(
          icon: CustomIcons.logOut,
          text: "Log Out",
          onTap: () async {
            await userDataBox.clear();
            Get.offAllNamed(AppRoutes.startPageRoute);
          }),
    ];
    postionStream = Geolocator.getPositionStream().listen((Position position) {
      if (markers.isNotEmpty) {
        userLatLng = LatLng(position.latitude, position.longitude);
        markers.removeAt(0);
        markers.insert(
            0,
            Marker(
              position: LatLng(userLatLng.latitude, userLatLng.longitude),
              markerId: const MarkerId('1'),
              icon: userMarkerData,
            ));

        update();
      }
    });
    super.onInit();
  }
}
