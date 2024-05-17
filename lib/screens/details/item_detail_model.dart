// ignore_for_file: prefer_typing_uninitialized_variables, list_remove_unrelated_type

class Images{
  var id;
  var imageURL;

  Images({required this.id, required this.imageURL});

  factory Images.fromJson(var json) {
    return  Images(
      id: json['Id'],
      imageURL: json['ImageURL'],
    );
  }
  factory Images.delete() {
    return  Images(
      id: ['Id'].remove(['Id']),
      imageURL:['ImageURL'].remove(['ImageURL']),
    );
  }

}