import 'package:uber/core/constant/app_assets.dart';
import 'package:uber/model/cars_type_model.dart';

class ConstantLists {
  static const List<String> recentPlaces = [
    "Clare Road",
    "Bridge Farm",
    "St Michael's Church",
    "Tennis Court",
  ];
  static final List<CarsTypeModel> carsTypeList = [
    CarsTypeModel(type: "Economy", image: AppAssets.economyCarImage),
    CarsTypeModel(type: "Luxury", image: AppAssets.luxuryCarImage),
    CarsTypeModel(type: "Family", image: AppAssets.familyCarImage)
  ];
}
