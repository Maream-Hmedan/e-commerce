// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:update_flutter_project_one/configuration/const_values.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_item/home_item_users/item_model.dart';

class ItemProv extends ChangeNotifier {
  List<ItemModel> listItemModel = [];
  List<ItemModel> listItemAdmin = [];
  File? image;

  getItems({required String idShop}) async {
    listItemModel = [];
    final response = await http.post(
        Uri.parse("${ConsValues.BASEURL}getItems.php"),
        body: {"Id_shops": idShop});
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var items = jsonBody['items'];

      for (Map i in items) {
        listItemModel.add(ItemModel.fromJson(i));
      }
      notifyListeners();
    }
  }

  getItemsAdmin() async {
    listItemAdmin = [];
    final response = await http.post(
      Uri.parse("${ConsValues.BASEURL}getItemsAdmin.php"),
    );
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var items = jsonBody['items'];
      for (Map i in items) {
        listItemAdmin.add(ItemModel.fromJson(i));
      }
      notifyListeners();
    }
  }

  Future addNewItems({
    required String name,
    required String description,
    required String price,
    required String idShop,
    required String idStatusTypes,
    required List<XFile> listImages,
  }) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("${ConsValues.BASEURL}addNewItem.php"));
    var pic = await http.MultipartFile.fromPath("fileToUpload", image!.path);
    request.fields['Name'] = name;
    request.fields['Description'] = description;
    request.fields['Price'] = price;
    request.fields['Id_shops'] = idShop;
    request.fields['Id_statustypes'] = idStatusTypes;
    request.files.add(pic);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var jsonBody = jsonDecode(responseString);
    var data = jsonBody['data'];
    listItemAdmin.add(ItemModel.fromJson(data));
    var iD = data['Id'];

    for (XFile x in listImages) {
      await addNewItemImages(image: File(x.path), idItems: iD.toString());
    }

    notifyListeners();
  }

  Future addNewItemImages({
    required File image,
    required String idItems,
  }) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("${ConsValues.BASEURL}addNewItemImage.php"));
    var pic = await http.MultipartFile.fromPath("fileToUpload", image.path);
    request.fields['Id_items'] = idItems;
    request.files.add(pic);
    // var response = await request.send();
    // var responseData = await response.stream.toBytes();
    // var responseString = String.fromCharCodes(responseData);
    // var jsonBody = jsonDecode(responseString);
    // var data = jsonBody['data'];
  }

  Future updateItem({
    required int index,
    required String name,
    required String description,
    required String price,
    required String idShop,
    required String idStatusType,
    required id,
  }) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("${ConsValues.BASEURL}UpdateItem.php"));
    request.fields['Name'] = name;
    request.fields['Description'] = description;
    request.fields['Price'] = price;
    request.fields['Id_shops'] = idShop;
    request.fields['Id_statetype'] = idStatusType;
    request.fields['Id'] = id;
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var jsonBody = jsonDecode(responseString);
    var data = jsonBody['data'];
    listItemAdmin[index] = ItemModel.fromJson(data);
    notifyListeners();
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
