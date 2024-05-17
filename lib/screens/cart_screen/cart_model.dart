// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

class CartModel {
  var Id_items;
  var Id;
  var Count;
  var ImageURL;
  var Price;
  var Name;

  CartModel({required this.Id_items,
    required this.Id,
    required this.Count,
    required this.ImageURL,
    required this.Price,
    required this.Name
  });

  factory CartModel.fromJson(var json) {
    return CartModel(
      Id_items: json['Id_items'],
      Id: json['Id'],
      Count: json['Count'],
      ImageURL: json['ImageURL'],
      Price: json['Price'],
      Name: json['Name'],
    );
  }
}
