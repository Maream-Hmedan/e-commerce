import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:update_flutter_project_one/configuration/const_values.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_category/home_categories_users/category_model.dart';



class CategoryProv extends ChangeNotifier {
  List<CategoriesModel> listCategoriesModel = [];
  List<CategoriesModel> listCategoriesModelAdmin = [];
  File? image ;

  getCategories() async {
    final response = await http.get(
      Uri.parse("${ConsValues.BASEURL}getCategories.php"),
    );
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var categories = jsonBody['Categories'];
      for (Map i in categories) {
        listCategoriesModel.add(CategoriesModel.fromJson(i));
      }
      notifyListeners();
    }
  }

  Future<List<CategoriesModel>> getCategoriesAdmin() async {
    listCategoriesModelAdmin = [];
    final response = await http.get(
      Uri.parse("${ConsValues.BASEURL}getCategoriesAdmin.php"),
    );
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var categories = jsonBody['Categories'];
      for (Map i in categories) {
        listCategoriesModelAdmin.add(CategoriesModel.fromJson(i));
      }
      notifyListeners();
    }
    return listCategoriesModelAdmin;
  }

  Future addNewCategories({
    required String name,
    required String idStatusTypes,
  }) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("${ConsValues.BASEURL}addNewCategory.php"));
    var pic = await http.MultipartFile.fromPath("fileToUpload",image!.path);
    request.fields['Name'] = name;
    request.fields['Id_statustypes'] =idStatusTypes;
    request.files.add(pic);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var jsonBody = jsonDecode(responseString);
    var data = jsonBody['data'];
    listCategoriesModelAdmin.add(CategoriesModel.fromJson(data));
    notifyListeners();
  }

  Future updateCategory({
    required String id,
    required String name,
    required String idStatusTypes,
    required int index,
  }) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("${ConsValues.BASEURL}UpdateCategory.php"));
    if(image!= null){
      var pic = await http.MultipartFile.fromPath("fileToUpload",image!.path);
      request.files.add(pic);
    }
    request.fields['Name'] = name;
    request.fields['Id_statustypes'] =idStatusTypes;
    request.fields['Id'] = id;
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var jsonBody = jsonDecode(responseString);
    var data = jsonBody['data'];
    listCategoriesModelAdmin[index]=CategoriesModel.fromJson(data);
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
