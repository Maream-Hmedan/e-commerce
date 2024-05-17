import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:update_flutter_project_one/configuration/const_values.dart';
import 'package:update_flutter_project_one/screens/details/item_detail_view.dart';
import 'package:update_flutter_project_one/utils/helper/app_navigation.dart';
import 'package:update_flutter_project_one/utils/ui/common_views.dart';


import 'items_provider.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key, required this.idShop});

  final String idShop;


  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ItemProv>(context, listen: false).getItems(
       idShop: widget.idShop,
    );
  }
  dynamic idModel;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          CommonViews().customAppBar(
            title: "Item Screen",
            context:context,
          ),
          Expanded(
            child: Consumer<ItemProv>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: value.listItemModel.length,
                  itemBuilder: (context, index) {
                    idModel=value.listItemModel[index].id;
                    return GestureDetector(
                        onTap: (){
                      AppNavigator.of(context,isAnimated: true).push(ItemDetails(
                        itemModel: value.listItemModel[index],));
                    },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8,right: 8,left: 8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.deepPurpleAccent,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: CachedNetworkImage(
                                height: (3.h) - 16,
                                width: 80.w,
                                fit: BoxFit.fill,
                                imageUrl: ConsValues.BASEURL +
                                    value.listItemModel[index].imageUrl,
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[400]!,
                                      child:Container(
                                        color: Colors.grey[300]!,
                                        height: (30.h) - 16,
                                        width: 100.w- 16,
                                      ),
                                    ),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),

                            ),
                            Text(
                              value.listItemModel[index].name,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                            ),
                            Text(
                              value.listItemModel[index].price.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18)
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
