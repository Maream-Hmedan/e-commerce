import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:update_flutter_project_one/screens/order_screen/order_screen_users/order_details_view.dart';
import 'package:update_flutter_project_one/screens/order_screen/order_screen_users/order_provider.dart';
import 'package:update_flutter_project_one/utils/helper/app_navigation.dart';

class OrderHesScreen extends StatefulWidget {
  const OrderHesScreen({Key? key}) : super(key: key);

  @override
  State<OrderHesScreen> createState() => _OrderHesScreenState();
}

class _OrderHesScreenState extends State<OrderHesScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<OrderProv>(context, listen: false).getOrderHes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<OrderProv>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.listOrderHes.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  AppNavigator.of(context, isAnimated: true)
                      .push(OrderHesDetScreen(
                    idOrder: value.listOrderHes[index].id,
                  ));
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  width: 100.w,
                  height: 23.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        value.listOrderHes[index].note,
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        value.listOrderHes[index].totalPrice.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        value.listOrderHes[index].latitude,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        value.listOrderHes[index].longitude,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        value.listOrderHes[index].orderState,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
