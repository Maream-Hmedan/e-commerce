// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_item/home_item_users/items_provider.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_shop/home_shop_user/shop_model.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_shop/home_shop_user/shop_provider.dart';
import 'package:update_flutter_project_one/utils/ui/common_views.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFiles = [];

  openImages() async {
    try {
      var pickedFiles = await imagePicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedFiles != null) {
        pickedFiles = pickedFiles;
        setState(() {});
      } else {
        if (kDebugMode) {
          print("No image is selected.");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("error while picking file.");
      }
    }
  }

  File? image;
  final TextEditingController _name = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();

  final TextEditingController _desc = TextEditingController();
  final FocusNode _descFocusNode = FocusNode();

  final TextEditingController _price = TextEditingController();
  final FocusNode _priceFocusNode = FocusNode();
  String dropdownValue = 'DisActive';
  var idStatusType;
  Shop? selectedValue;
  var idShop;
  var idItem;
  var name;

  @override
  void initState() {
    super.initState();
    Provider.of<ShopProv>(context, listen: false).getShopAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
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
                  padding: const EdgeInsets.all(8),
                  width: 100.w,
                  height: 20.h,
                  child: image != null
                      ? Image.file(
                          image!,
                          width: 100.w,
                          height: 20.h,
                          fit: BoxFit.fill,
                        )
                      : const Icon(
                          (Icons.image),
                        ),
                ),
              ),

              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    //open button ----------------
                    ElevatedButton(
                        onPressed: () {
                          openImages();
                        },
                        child: const Text("Open Images")),
                    SizedBox(height: 2.h,),
                    const Divider(),
                    const Text("Picked Files:"),
                    const Divider(),
                    SizedBox(height: 2.h,),
                    imageFiles != null
                        ? Wrap(
                            children: imageFiles.map((imageOne) {
                              return SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.file(File(imageOne.path)),
                              );
                            }).toList(),
                          )
                        : Container()
                  ],
                ),
              ),
              CommonViews().createTextFormField(
                  controller: _name,
                  focusNode: _nameFocusNode,
                  onSubmitted: (value) {
                    _descFocusNode.requestFocus();
                  },
                  label: "Item Name",
                  prefixIcon: Icons.insert_invitation_outlined,
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
              DropdownButton<String>(
                value: dropdownValue,
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
                    dropdownValue = newValue!;
                  });
                  if (dropdownValue == "DisActive") {
                    idStatusType = "2";
                  } else {
                    idStatusType = "1";
                  }
                },
              ),
              SizedBox(
                width: 10.w,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 5.h,
                  ),
                  Text(
                    'Shop Name:$name',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Consumer<ShopProv>(
                    builder: (context, value, child) {
                      return DropdownButton<Shop>(
                        value: selectedValue,
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
                            selectedValue = Value;
                            idShop = selectedValue!.id;
                            name = selectedValue!.name;
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CommonViews().customButton(
          textButton: "Save",
          context: MediaQuery.of(context),
          onTap: () async {
            await Provider.of<ItemProv>(context, listen: false).addNewItems(
              name: _name.text,
              description: _desc.text,
              price: _price.text,
              idStatusTypes: idStatusType,
              idShop: idShop,
              listImages: imageFiles,
            );
            if (mounted) {
              Navigator.pop(context);
            }
          }),
    );
  }
}
