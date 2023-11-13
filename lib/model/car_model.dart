import 'package:google_maps_flutter/google_maps_flutter.dart';

class CarModel {
  final String name;
  final String image;
  double? price;
  final int seatsNumber;
  double? distance;
  double? userDistance;
  String? time;
  LatLng? latLng;

  CarModel({
    required this.name,
    required this.image,
    this.price,
    required this.seatsNumber,
    this.distance,
    this.userDistance,
    this.time,
    this.latLng,
  });
}
