// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

class OrderHes {
  var id;
  var note;
  var totalPrice;
  var longitude;
  var latitude;
  var orderState;

  OrderHes({
    required this.id,
    required this.note,
    required this.totalPrice,
    required this.longitude,
    required this.latitude,
    required this.orderState,
  });

  factory OrderHes.fromJson(var json){
    return OrderHes(
      id: json['Id'],
      note: json['Note'],
      totalPrice: json['TotalPrice'],
      latitude: json['Latitude'],
      orderState: json['orderstate'],
      longitude: json['Longitude'],
    );
  }
}
