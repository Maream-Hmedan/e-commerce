import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:update_flutter_project_one/configuration/const_values.dart';
import 'banner_model.dart';

class BannerProv extends ChangeNotifier {
  List<BannerImages> listBannerImages = [];
  File ?image;


  getBannerImages() async {
      final response = await http.get(
        Uri.parse("${ConsValues.BASEURL}getBannerImages.php"),
      );
      if (response.statusCode == 200) {
        var jsonBody = jsonDecode(response.body);
        var images = jsonBody["Images"];
        for (Map i in images) {
          listBannerImages.add(
              BannerImages.fromJson(i));
        }
        notifyListeners();
      }
  }

  Future addNewBanner({ required String url}) async {
    EasyLoading.show(status: 'loading...');
    var request = http.MultipartRequest(
        "POST", Uri.parse("${ConsValues.BASEURL}addNewBanner.php"));
    var pic = await http.MultipartFile.fromPath("fileToUpload", image!.path);
    request.fields['URL'] = url;
    request.files.add(pic);

    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var jsonBody = jsonDecode(responseString);
    var data = jsonBody['data'];
    listBannerImages.add(
      BannerImages.fromJson(data));
           // id: data['Id'], url: data['URL'], imageURL: data['ImageURL']),
    // );
    notifyListeners();
    EasyLoading.dismiss();
  }

  getImage(ImageSource imageSource) async {
    ImagePicker picker = ImagePicker();
    final XFile? xImage = await picker.pickImage(source: imageSource);
    if (xImage != null) {
      image = File(xImage.path);
      notifyListeners();
    }
  }
}
