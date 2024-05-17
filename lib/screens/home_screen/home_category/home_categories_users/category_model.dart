class CategoriesModel {
  String id;
  String imageURL;
  String name;
  String ? iDStateType;

  CategoriesModel({
    required this.id,
    required this.imageURL,
    required this.name,
     this.iDStateType,
  });

  factory CategoriesModel.fromJson(var json) {
    return CategoriesModel(
      id: json['Id'],
      imageURL: json['ImageURL'],
      name: json['Name'],
      iDStateType: json['iDStateType'],
    );
  }
}
