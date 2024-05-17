class ItemModel {
  String id;
  String name;
  String imageUrl;
  int price;
  String description;
  String ?idStatetype;
  String ?idShops;


  ItemModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
    this.idStatetype,
    this.idShops,
  });
  
  factory ItemModel.fromJson(var json) => ItemModel(
    id: json["Id"],
    name: json["Name"],
    imageUrl: json["ImageURL"],
    price: json["Price"],
    description: json["Description"],
    idStatetype: json["Id_statetype"],
    idShops: json["Id_shops"],
  );

 
}
