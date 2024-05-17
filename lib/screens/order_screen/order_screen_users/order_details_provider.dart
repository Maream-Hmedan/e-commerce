import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:update_flutter_project_one/configuration/const_values.dart';
import 'package:update_flutter_project_one/screens/order_screen/order_screen_users/order_details_model.dart';


class OrderDetProv extends ChangeNotifier {
  List<OrderHesDet> listOrderHesDet = [];

  getOrderHesDet({required var idOrders}) async {
    listOrderHesDet = [];
    final response = await http.post(
      Uri.parse(
        "${ConsValues.BASEURL}getOrderHesDet.php",
      ),
      body: {
        "Id_orders": idOrders,
      },
    );
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);

      var ordersDet = jsonBody['OrdersDet'];
      for (Map i in ordersDet) {
        listOrderHesDet.add(
          OrderHesDet(
            count: i['Count'],
            name: i['Name'],
            price: i['Price'],
            imageUrl: i['ImageURL'],
          ),
        );
        notifyListeners();
      }
    }
  }
}
