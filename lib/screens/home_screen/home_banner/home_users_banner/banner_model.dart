// ignore_for_file: prefer_typing_uninitialized_variables

class BannerImages {
  String id;
  String url;
  String imageURL;

  BannerImages({required this.id, required this.url, required this.imageURL});

  factory BannerImages.fromJson(var json) {
    return BannerImages(
      id: json['Id'],
      url: json['URL'],
      imageURL: json['ImageURL'],
    );
  }
}
