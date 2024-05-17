// ignore_for_file: prefer_typing_uninitialized_variables, list_remove_unrelated_type

class AdminItem{
  var id;
  var imageURL;

  AdminItem({required this.id, required this.imageURL});

  factory AdminItem.fromJson(var json) {
    return  AdminItem(
      id: json['Id'],
      imageURL: json['ImageURL'],
    );
  }
  factory AdminItem.delete() {
    return  AdminItem(
      id: ['Id'].remove(['Id']),
      imageURL:['ImageURL'].remove(['ImageURL']),
    );
  }

}