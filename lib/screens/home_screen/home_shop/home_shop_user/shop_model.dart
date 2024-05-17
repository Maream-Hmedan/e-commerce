class Shop {
  String id;
  String imageURL;
  String name;
  String ? idStateType;
  String ? idCategories;

  Shop({
    required this.id,
    required this.imageURL,
    required this.name,
    this.idStateType,
    this.idCategories,
  });
  factory Shop.fromJson(var json) {
    return Shop(
        id: json['Id'],
        imageURL: json['ImageURL'],
        name: json['Name'],
        idStateType: json['Id_statetype'],
        idCategories: json['Id_categories']
    );
  }
}
