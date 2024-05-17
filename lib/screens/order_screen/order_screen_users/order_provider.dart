import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:update_flutter_project_one/configuration/const_values.dart';
import 'package:update_flutter_project_one/screens/order_screen/order_screen_users/order_model.dart';
import 'package:update_flutter_project_one/utils/ui/common_views.dart';

class OrderProv extends ChangeNotifier {
  List<OrderHes> listOrderHes = [];

  getOrderHes() async {
    listOrderHes = [];
    CommonViews.getPrefString(ConsValues.ID, "").then(
      (idUser) async {
        final response = await http.post(
          Uri.parse(
            "${ConsValues.BASEURL}getOrderHes.php",
          ),
          body: {
            "Id_users": idUser,
          },
        );
        if (response.statusCode == 200) {
          var jsonBody = jsonDecode(response.body);

          var orders = jsonBody['orders'];
          for (Map i in orders) {
            listOrderHes.add(
              OrderHes.fromJson(i),
            );
            notifyListeners();
          }
        }
      },
    );
  }

  getOrderHesAdmin() async {
    listOrderHes = [];

    final response = await http.post(
      Uri.parse(
        "${ConsValues.BASEURL}getOrderHesAdmin.php",
      ),
    );
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);

      var orders = jsonBody['orders'];
      for (Map i in orders) {
        listOrderHes.add(
          OrderHes.fromJson(i),
        );
        notifyListeners();
      }
    }
  }

  updateOrderState({required int index, required String idOrderState}) async {
    final response = await http.post(
      Uri.parse("${ConsValues.BASEURL}updateOrderState.php"),
      body: {
        "Id_orderstate": idOrderState,
        "Id": listOrderHes[index].id,
      },
    );
    if (response.statusCode == 200) {
      idOrderState == "1"
          ? listOrderHes[index].orderState = "waiting"
          : idOrderState == "2"
              ? listOrderHes[index].orderState = "approve"
              : listOrderHes[index].orderState = "cancel";
      notifyListeners();
    }
  }
}
