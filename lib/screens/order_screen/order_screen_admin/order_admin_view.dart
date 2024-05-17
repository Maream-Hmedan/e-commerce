import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:update_flutter_project_one/screens/order_screen/order_screen_users/order_details_view.dart';
import 'package:update_flutter_project_one/screens/order_screen/order_screen_users/order_provider.dart';
import 'package:update_flutter_project_one/utils/ui/common_app_bar.dart';
import 'package:update_flutter_project_one/utils/ui/common_views.dart';

class OrdersAdmin extends StatefulWidget {
  const OrdersAdmin({Key? key}) : super(key: key);

  @override
  State<OrdersAdmin> createState() => _OrdersAdminState();
}

class _OrdersAdminState extends State<OrdersAdmin> {
  @override
  void initState() {
    super.initState();
    Provider.of<OrderProv>(context, listen: false).getOrderHesAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const CustomAdminAppBar(
        title: 'Admin Order',
      ),
      body: Consumer<OrderProv>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.listOrderHes.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return OrderHesDetScreen(
                          idOrder: value.listOrderHes[index].id,
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  width: 100.w,
                  height: 30.h,
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
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        value.listOrderHes[index].totalPrice.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        value.listOrderHes[index].latitude,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        value.listOrderHes[index].longitude,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        value.listOrderHes[index].orderState,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CommonViews().customButton(
                              textButton: "Waiting",
                              context: MediaQuery.of(context),
                              onTap: () async {
                                value.updateOrderState(
                                    index: index, idOrderState: "1");
                              }),
                          CommonViews().customButton(
                              textButton: "Approve",
                              context: MediaQuery.of(context),
                              onTap: () async {
                                value.updateOrderState(
                                    index: index, idOrderState: '2');
                              }),
                          CommonViews().customButton(
                              textButton:"Cancel",
                              context: MediaQuery.of(context),
                              onTap: () async {
                                value.updateOrderState(
                                    index: index, idOrderState: '3');
                              }),
                        ],
                      )
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
