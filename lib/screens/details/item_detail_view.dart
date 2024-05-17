import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:update_flutter_project_one/configuration/const_values.dart';
import 'package:update_flutter_project_one/screens/cart_screen/cart_provider.dart';
import 'package:update_flutter_project_one/screens/cart_screen/cart_screen.dart';
import 'package:update_flutter_project_one/screens/details/item_detail_provider.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_item/home_item_users/item_model.dart';
import 'package:update_flutter_project_one/utils/helper/app_navigation.dart';
import 'package:update_flutter_project_one/utils/ui/common_views.dart';

class ItemDetails extends StatefulWidget {
   final ItemModel itemModel;
  const ItemDetails({super.key,required this.itemModel});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  void initState() {
    super.initState();
    Provider.of<ItemImagesProv>(context, listen: false).getItemImages(
      idItem: widget.itemModel.id,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CommonViews().customAppBar(
              title: "Item Details Screen",
              context: context,
            ),
            Container(
              width: 100.w,
              height:30.h,
              padding: const EdgeInsets.all(8),
              child: Consumer<ItemImagesProv>(
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: value.listImages.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Image.network(
                        ConsValues.BASEURL +
                            value.listImages[index].imageURL,
                        height: (30.h) - 16,
                        width:(100.w)- 16,
                        fit: BoxFit.fill,
                      );
                    },
                  );
                },
              ),
            ),
            Text(widget.itemModel.name),
            Text(widget.itemModel.price.toString()),
            Text(widget.itemModel.description),
          ],
        ),
      ),
      bottomNavigationBar:
          CommonViews().customButton(textButton: "Add To Cart",
              onTap: () async {
                await Provider.of<CartProv>(context, listen: false).addToCart(
                          idItem: widget.itemModel.id,
                        );
                if(mounted){
                AppNavigator.of(context,isAnimated: true).push(const CartScreen());
              }}),
    );
  }
}
