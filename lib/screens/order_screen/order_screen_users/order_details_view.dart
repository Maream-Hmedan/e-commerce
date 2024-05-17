// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:update_flutter_project_one/configuration/const_values.dart';
import 'package:update_flutter_project_one/screens/order_screen/order_screen_users/order_details_provider.dart';


class OrderHesDetScreen extends StatefulWidget {
  var idOrder;
  OrderHesDetScreen({super.key,  required this.idOrder});
  @override
  State<OrderHesDetScreen> createState() => _OrderHesDetScreenState();
}

class _OrderHesDetScreenState extends State<OrderHesDetScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<OrderDetProv>(context, listen: false).
    getOrderHesDet(idOrders: widget.idOrder);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<OrderDetProv>(
          builder: (context, value, child) {
            return ListView.builder(
                itemCount: value.listOrderHesDet.length,
                itemBuilder: (context, index){
                  return Column(
                    children: [
                      Image.network(
                          ConsValues.BASEURL+
                              value.listOrderHesDet[index].imageUrl),
                      const SizedBox(height: 10,),
                      Text(value.listOrderHesDet[index].name,
                        style: const TextStyle(fontSize: 20,
                          color: Colors.black,),),
                      const SizedBox(height: 10,),
                      Text(value.listOrderHesDet[index].price.toString(),
                        style: const TextStyle(fontSize: 20,
                          color: Colors.black,),),
                      const SizedBox(height: 10,),
                      Text(value.listOrderHesDet[index].count,
                        style: const TextStyle(fontSize: 20,
                          color: Colors.black,),
                      ),
                    ],
                  );
                }
            );
          }),
    );
  }
}
