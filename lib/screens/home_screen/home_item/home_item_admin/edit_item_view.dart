// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:update_flutter_project_one/configuration/const_values.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_item/home_item_admin/add_admin_images.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_item/home_item_admin/item_admin_provider.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_item/home_item_users/item_model.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_item/home_item_users/items_provider.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_shop/home_shop_user/shop_model.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_shop/home_shop_user/shop_provider.dart';
import 'package:update_flutter_project_one/utils/helper/app_navigation.dart';
import 'package:update_flutter_project_one/utils/ui/common_views.dart';

class EditItemAdminScreen extends StatefulWidget {
  ItemModel itemModel;
  int index;

  EditItemAdminScreen(
      {super.key, required this.itemModel, required this.index});

  @override
  State<EditItemAdminScreen> createState() => _EditItemAdminScreenState();
}

class _EditItemAdminScreenState extends State<EditItemAdminScreen> {
  final TextEditingController _name = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();

  final TextEditingController _desc = TextEditingController();
  final FocusNode _descFocusNode = FocusNode();

  final TextEditingController _price = TextEditingController();
  final FocusNode _priceFocusNode = FocusNode();
  String stateDropdownValue = " ";
  var idStatusType;

  Shop? selectedShopValue;
  var idShop;
  var idItem;
  var name;

  @override
  void initState() {
    super.initState();
    _name.text = widget.itemModel.name;
    _desc.text = widget.itemModel.description;
    _price.text = widget.itemModel.price.toString();
    idStatusType = widget.itemModel.idStatetype;
    idShop = widget.itemModel.idShops;

    if (idStatusType == "2") {
      stateDropdownValue = "DisActive";
    } else {
      stateDropdownValue = "Active";
    }

    Provider.of<ItemImagesAdminProv>(context, listen: false).getItemImages(
      idItem: widget.itemModel.id,
    );

    Provider.of<ShopProv>(context, listen: false).getShopAdmin().then(
          (value) {
        selectedShopValue = value.firstWhere(
              (shop) => shop.id == idShop,
        );
        setState(() {});
        name = selectedShopValue!.name;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 5.h,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Select Image"),
                          actions: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Provider.of<ItemProv>(context, listen: false)
                                    .getImage(ImageSource.camera);
                              },
                              icon: const Icon(Icons.camera_alt_outlined),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Provider.of<ItemProv>(context, listen: false)
                                    .getImage(ImageSource.gallery);
                              },
                              icon: const Icon(Icons.browse_gallery),
                            ),
                          ],
                        );
                      });
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: CachedNetworkImage(
                      height: 10.h,
                      width: 60.w,
                      fit: BoxFit.fill,
                      imageUrl: ConsValues.BASEURL +
                          ConsValues.BASEURL +
                          widget.itemModel.imageUrl,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[400]!,
                            child: Container(
                              color: Colors.grey[300]!,
                              height: 10.h,
                              width: 60.w,
                            ),
                          ),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              CommonViews().createTextFormField(
                  controller: _name,
                  focusNode: _nameFocusNode,
                  onSubmitted: (value) {
                    _descFocusNode.requestFocus();
                  },
                  label: "Item Name",
                  prefixIcon: Icons.person,
                  keyboardType: TextInputType.name),
              SizedBox(
                height: 5.h,
              ),
              CommonViews().createTextFormField(
                  controller: _desc,
                  focusNode: _descFocusNode,
                  onSubmitted: (value) {
                    _priceFocusNode.requestFocus();
                  },
                  label: "Item Description",
                  prefixIcon: Icons.note_alt_sharp,
                  keyboardType: TextInputType.name),
              SizedBox(
                height: 5.h,
              ),
              CommonViews().createTextFormField(
                  controller: _price,
                  focusNode: _priceFocusNode,
                  inputAction: TextInputAction.done,
                  onSubmitted: (value) {
                    FocusManager.instance.primaryFocus!.unfocus();
                  },
                  label: "Item Price",
                  prefixIcon: Icons.money,
                  keyboardType: TextInputType.number),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    'Status: $stateDropdownValue',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  DropdownButton<String>(
                    value: stateDropdownValue,
                    items: <String>['Active', 'DisActive']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 20),
                        ),
                      );
                    }).toList(),
                    style: const TextStyle(color: Colors.black),
                    underline: Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        stateDropdownValue = newValue!;
                      });
                      if (stateDropdownValue == "DisActive") {
                        idStatusType = "2";
                      } else {
                        idStatusType = "1";
                      }
                    },
                  ),
                ],
              ),
              SizedBox(
                width: 10.w,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    'Shop Name:$name',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Consumer<ShopProv>(
                    builder: (context, value, child) {
                      return DropdownButton<Shop>(
                        value: selectedShopValue,
                        items: value.listShopAdmin
                            .map<DropdownMenuItem<Shop>>((Shop value) {
                          return DropdownMenuItem<Shop>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        onChanged: (Shop? Value) {
                          setState(() {
                            selectedShopValue = Value;
                            idShop = selectedShopValue!.id;
                            name = selectedShopValue!.name;
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Provider.of<ItemImagesAdminProv>(context, listen: false)
                        .deleteItemImages(
                      index: widget.index,
                      idItem: widget.itemModel.id,
                    );
                  },
                  child: const Text("Delete Item Images")),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  AppNavigator.of(context, isAnimated: true).push(
                      const AddAdminImages());
                },
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Center(
                      child: Text("Add Item Images ",
                          style: TextStyle(
                            fontSize: 20,
                          )),
                    ),
                    Container(
                      width: 100.w,
                      height: 20.h,
                      padding: const EdgeInsets.all(8),
                      child: Consumer<ItemImagesAdminProv>(
                        builder: (context, value, child) {
                          return ListView.builder(
                            itemCount: value.listImages.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Image.network(
                                ConsValues.BASEURL +
                                    value.listImages[index].imageURL,
                                height: (100.h * .3) - 16,
                                width: 100.w - 16,
                                fit: BoxFit.fill,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CommonViews().customButton(
            textButton: "Save",
            context: MediaQuery.of(context),
            onTap: () async {
              await Provider.of<ItemProv>(context, listen: false).
              updateItem(
                  index: widget.index,
                  id: widget.itemModel.id,
                  description: _desc.text,
                  idShop: idShop,
                  price: _price.text,
                  name: _name.text,
                  idStatusType: idStatusType);
              if (mounted) {
                Navigator.pop(context);
              }
            })
    );
  }
}
