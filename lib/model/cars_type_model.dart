class CarsTypeModel {
  final String type;
  final String image;
  bool selected;

  CarsTypeModel(
      {required this.type, required this.image, this.selected = false});
}
