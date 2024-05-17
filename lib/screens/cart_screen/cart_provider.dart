import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:update_flutter_project_one/configuration/const_values.dart';
import 'package:update_flutter_project_one/screens/cart_screen/cart_model.dart';
import 'package:update_flutter_project_one/utils/ui/common_views.dart';

class CartProv extends ChangeNotifier {
  List<CartModel> listCartModel = [];
  double totalPrice = 0;

  addToCart({required var idItem}) async {
    CommonViews.getPrefString(ConsValues.ID, "").then(
          (idUser) async {
        await http.post(Uri.parse("${ConsValues.BASEURL}addToCart.php"), body: {
          "Id_users": idUser,
          "Id_items": idItem,
        });
      },
    );
  }

  getCart() async {
    listCartModel = [];
    CommonViews.getPrefString(ConsValues.ID, "").then(
          (idUser) async {
        final response = await http.post(
          Uri.parse(
            "${ConsValues.BASEURL}getCart.php",
          ),
          body: {
            "Id_users": idUser,
          },
        );
        if (response.statusCode == 200) {
          var jsonBody = jsonDecode(response.body);
          var cart = jsonBody["cart"];
          for (Map i in cart) {
            listCartModel.add(
              CartModel.fromJson(i),
            );
            getTotalPrice();
          }
        }
      },
    );
  }
  updateCart({required var index,required var count}) async {
    await http.post(
        Uri.parse("${ConsValues.BASEURL}updateCart.php"),
        body: {"Id":listCartModel[index].Id,"Count":count.toString(),}
    );
    listCartModel[index].Count=count;
    getTotalPrice();
  }
  deleteFromCart({required var index}) async {
    await http.post(
        Uri.parse("${ConsValues.BASEURL}deleteFromCart"),
        body: {"Id":listCartModel[index].Id}

    );
    listCartModel.removeAt(index);
    getTotalPrice();
  }
  getTotalPrice(){
    totalPrice=0;
    for(CartModel cartModal in listCartModel){
      totalPrice=totalPrice+(cartModal.Price*cartModal.Count);
    }
    notifyListeners();
  }
}

