import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:update_flutter_project_one/configuration/const_values.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_item/home_item_admin/add_item_view.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_item/home_item_admin/edit_item_view.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_item/home_item_users/items_provider.dart';
import 'package:update_flutter_project_one/utils/helper/app_navigation.dart';
import 'package:update_flutter_project_one/utils/ui/common_app_bar.dart';

class ItemAdminScreen extends StatefulWidget {
  const ItemAdminScreen({Key? key}) : super(key: key);

  @override
  State<ItemAdminScreen> createState() => _ItemAdminScreenState();
}

class _ItemAdminScreenState extends State<ItemAdminScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ItemProv>(context, listen: false).getItemsAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAdminAppBar(
        title: 'Admin Items',
      ),
      body: Consumer<ItemProv>(
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
                  child: Column(
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: CachedNetworkImage(
                                height: 200,
                                width: 270,
                                fit: BoxFit.fill,
                                imageUrl: ConsValues.BASEURL +
                                    value.listItemAdmin[index].imageUrl,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[400]!,
                                  child: Container(
                                    color: Colors.grey[300]!,
                                    height: 200,
                                    width: 270,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return EditItemAdminScreen(
                                      itemModel: value.listItemAdmin[index],
                                      index: index,
                                    );
                                  },
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(value.listItemAdmin[index].name),
                    ],
                  ),
                );
              },
              itemCount: value.listItemAdmin.length,
              scrollDirection: Axis.vertical);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppNavigator.of(context, isAnimated: true)
              .push(const AddItemScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
