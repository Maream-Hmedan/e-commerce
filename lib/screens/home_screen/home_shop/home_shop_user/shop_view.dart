import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:update_flutter_project_one/configuration/const_values.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_item/home_item_users/items_view.dart';
import 'package:update_flutter_project_one/utils/helper/app_navigation.dart';
import 'shop_provider.dart';

class HomeShop extends StatefulWidget {

  const HomeShop({super.key,});

  @override
  State<HomeShop> createState() => _HomeShopState();
}

class _HomeShopState extends State<HomeShop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Consumer<ShopProv>(
        builder: (context, value, child) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  AppNavigator.of(context, isAnimated: true)
                      .push(  ItemsPage(
                    idShop: value.listShop[index].id,
                  ));
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.deepPurpleAccent[200]!,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CachedNetworkImage(
                        height:180 ,
                        width: 150,
                        fit: BoxFit.fill,
                        imageUrl: ConsValues.BASEURL +
                            value.listShop[index].imageURL,
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[400]!,
                              child:Container(
                                color: Colors.grey[300]!,
                                height: (3.h) - 16,
                                width: (100.w) - 16,
                              ),
                            ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                      Text(
                        value.listShop[index].name,
                        style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 19),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: value.listShop.length,
          );
        },
      ),
    );
  }
}
