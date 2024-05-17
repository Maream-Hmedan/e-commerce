
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:update_flutter_project_one/configuration/const_values.dart';
import 'package:update_flutter_project_one/screens/details/item_detail_model.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_item/home_item_users/item_model.dart';

class ItemImagesProv extends ChangeNotifier {
  List<Images> listImages = [];
  List<ItemModel> listItemModel = [];

  getItemImages({required var idItem}) async {
    listImages=[];
    final response = await http.post(
        Uri.parse("${ConsValues.BASEURL}getItemImages.php"),
        body: {" Id_items": idItem }
    );
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var images = jsonBody['Images'];

      for (Map i in images) {
        listImages.add(
          Images.fromJson(i),
        );
      }

      notifyListeners();
    }
  }
  deleteItemImages({required var idItem,required int index}) async {

    final response = await http.post(
        Uri.parse("${ConsValues.BASEURL}deleteItemImages.php"),
        body: {" Id_items": idItem }
    );
    if (response.statusCode == 200) {
      listImages.removeAt(index);
      getItemImages(idItem:idItem );
    }
  }
}