import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:update_flutter_project_one/configuration/const_values.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_shop/home_shop_admin/add_shop_view.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_shop/home_shop_admin/edit_shop_view.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_shop/home_shop_user/shop_provider.dart';
import 'package:update_flutter_project_one/utils/helper/app_navigation.dart';
import 'package:update_flutter_project_one/utils/ui/common_app_bar.dart';

class AdminShopScreen extends StatefulWidget {
  const AdminShopScreen({Key? key}) : super(key: key);

  @override
  State<AdminShopScreen> createState() => _AdminShopScreenState();
}

class _AdminShopScreenState extends State<AdminShopScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ShopProv>(context, listen: false).getShopAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAdminAppBar(
        title: 'Admin Shop',
      ),
      body: Consumer<ShopProv>(
        builder: (context, value, child) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 5.w,
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: CachedNetworkImage(
                          height: 150,
                          width: 150,
                          fit: BoxFit.fill,
                          imageUrl: ConsValues.BASEURL +
                              value.listShopAdmin[index].imageURL,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[400]!,
                            child: Container(
                              color: Colors.grey[300]!,
                              height: 150,
                              width: 150,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      value.listShopAdmin[index].name,
                      style: const TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    IconButton(
                      onPressed: () {
                        AppNavigator.of(context).push(EditShopScreen(
                          shop: value.listShopAdmin[index],
                          index: index,
                        ));
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),
              );
            },
            itemCount: value.listShopAdmin.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppNavigator.of(context).push(const AddShop());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
