import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:update_flutter_project_one/configuration/const_values.dart';
import 'package:update_flutter_project_one/screens/cart_screen/cart_provider.dart';
import 'package:update_flutter_project_one/screens/google_map/google_map_screen.dart';
import 'package:update_flutter_project_one/utils/helper/app_navigation.dart';
import 'package:update_flutter_project_one/utils/ui/common_views.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CommonViews().customAppBar(
              title: "Cart Screen", context: context,

            ),
            Expanded(
              child: Consumer<CartProv>(
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: value.listCartModel.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(8),
                        width: 100.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Image.network(
                              ConsValues.BASEURL +
                                  value.listCartModel[index].ImageURL,
                              width: 60.w,
                              height: (20.h) - 16,
                              fit: BoxFit.fill,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Text(
                                  value.listCartModel[index].Name,
                                  style: const TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Provider.of<CartProv>(context,
                                                listen: false)
                                            .updateCart(
                                                index: index,
                                                count: value
                                                        .listCartModel[index]
                                                        .Count +
                                                    1);
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                      ),
                                    ),
                                    Text(
                                      value.listCartModel[index].Count
                                          .toString(),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        if (value.listCartModel[index].Count !=
                                            1) {
                                          Provider.of<CartProv>(context,
                                                  listen: false)
                                              .updateCart(
                                                  index: index,
                                                  count: value
                                                          .listCartModel[index]
                                                          .Count -
                                                      1);
                                        } else {
                                          Provider.of<CartProv>(context,
                                                  listen: false)
                                              .deleteFromCart(index: index);
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.remove,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(8),
              width: 100.w,
              height: 25.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Total Price = "),
                  Consumer<CartProv>(
                    builder: (context, value, child) {
                      return Text(
                        value.totalPrice.toString(),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar:
            CommonViews().customButton(textButton: "Next", onTap: () {
              AppNavigator.of(context,isAnimated: true).push(const MapScreen());
            }));
  }
}
