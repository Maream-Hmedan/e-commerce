// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_category/home_categories_users/categories_provider.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_category/home_categories_users/category_model.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_shop/home_shop_user/shop_provider.dart';
import 'package:update_flutter_project_one/utils/ui/common_views.dart';


class AddShop extends StatefulWidget {
  const AddShop({Key? key}) : super(key: key);

  @override
  State<AddShop> createState() => _AddShopState();
}

class _AddShopState extends State<AddShop> {
  File ? image;


  final TextEditingController _name = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  String dropdownValue = 'DisActive';
  var idStatusType;
  var idItem;
  var name;
  var idCategory;
  CategoriesModel?  selectedValue;

  @override
  void initState() {
    super.initState();
    Provider.of<CategoryProv>(context, listen: false).getCategoriesAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 2.h,),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Select Image"),
                          actions: [
                            IconButton(onPressed: () {
                              Navigator.pop(context);
                              getImage(ImageSource.camera);
                            },
                              icon: const Icon(Icons.camera_alt_outlined),
                            ),
                            IconButton(onPressed: () {
                              Navigator.pop(context);
                              getImage(ImageSource.gallery);
                            },
                              icon: const Icon(Icons.browse_gallery),
                            ),
                          ],
                        );
                      }
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  width: 100.h,
                  height: 20.h,
                  child: image != null
                      ? Image.file(
                    image!,
                    width: 100.h,
                    height: 20.h,
                    fit: BoxFit.fill,
                  )
                      : const Icon((Icons.image),),
                ),
              ),
              const SizedBox(height: 20,),
              CommonViews().createTextFormField(
                  controller: _name,
                  focusNode: _nameFocusNode,
                  onSubmitted: (value) {
                    FocusManager.instance.primaryFocus!.unfocus();
                  },
                  label: " Shop Name",
                  hint: "ADD Name",
                  prefixIcon: Icons.shop_2_outlined,
                  keyboardType: TextInputType.name),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  SizedBox(width: 10.w,),
                  Text(
                    'Status: $dropdownValue',
                    style: const TextStyle(fontSize: 20,),
                  ),
                  const SizedBox(width: 40,),
                  DropdownButton<String>(

                    value: dropdownValue,
                    items: <String>[ 'Active', 'DisActive']
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
                        idStatusType= "2";

                      } else {
                        idStatusType ="1";

                      }
                    },

                  ),

                ],
              ),
              SizedBox(height: 10.h,),
              Row(
                children: [
                  SizedBox(width: 10.w,),
                  Text(
                    'Category Name:$name',
                    style: const TextStyle(fontSize: 20,),
                  ),
                  SizedBox(width: 10.w,),
                  Consumer<CategoryProv>(
                    builder: (context, value, child) {
                      return DropdownButton<CategoriesModel>(
                        value: selectedValue,
                        items: value.listCategoriesModelAdmin
                            .map<DropdownMenuItem<CategoriesModel>>((
                            CategoriesModel value) {
                          return DropdownMenuItem <CategoriesModel>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        onChanged: (CategoriesModel? Value) {
                          setState(() {
                            selectedValue = Value;
                            idCategory=selectedValue!.id;
                            name=selectedValue!.name;
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

      bottomNavigationBar:
      CommonViews().customButton(
          textButton: "Save",
          context: MediaQuery.of(context),
          onTap: () async {
            await Provider.of<ShopProv>(context, listen: false)
                .addNewShops(
                image: image!,
                name: _name.text,
                Id_statustypes: idStatusType,
                Id_categories: idCategory);
            if (mounted) {
              Navigator.pop(context);
            }
          }),
    );
  }
  getImage(ImageSource imageSource) async {
    ImagePicker picker = ImagePicker();
    final XFile? xImage = await picker.pickImage(source:imageSource);
    if(xImage != null){
      image=File(xImage.path);
      setState(() {

      });
    }
  }

}

