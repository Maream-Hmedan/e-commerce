// ignore_for_file: prefer_typing_uninitialized_variables

class OrderHesDet{
  var name;
  var price;
  var count;
  var imageUrl;

  OrderHesDet({
    required this.name,
    required this.price,
    required this.count,
    required this.imageUrl,
  });

  factory OrderHesDet.fromJson(var json){
    return OrderHesDet(
      count: json['Count'],
      name: json['Name'],
      price: json['Price'],
      imageUrl: json['ImageURL'],
    );
  }
}
