// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:update_flutter_project_one/configuration/const_values.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_category/home_categories_users/categories_provider.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_category/home_categories_users/category_model.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_shop/home_shop_user/shop_model.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_shop/home_shop_user/shop_provider.dart';
import 'package:update_flutter_project_one/utils/ui/common_views.dart';


class EditShopScreen extends StatefulWidget {
  Shop shop;

  int index;

  EditShopScreen({super.key, required this.shop, required this.index});

  @override
  State<EditShopScreen> createState() => _EditShopScreenState();
}

class _EditShopScreenState extends State<EditShopScreen> {

  String dropdownValue = '';
  var idStatusTypes;
  var idCategory;
  var name;
  var NAME;
  var idCategories;


  CategoriesModel? selectedCategoriesValue;


  final TextEditingController _name = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _name.text = widget.shop.name;
    idStatusTypes = widget.shop.idStateType;
    idCategories = widget.shop.idCategories;
    if (idStatusTypes == "2") {
      dropdownValue = "DisActive";
    } else {
      dropdownValue = "Active";
    }
    Provider.of<CategoryProv>(context, listen: false).
    getCategoriesAdmin().then((value) {
      selectedCategoriesValue = value.firstWhere(
            (category) => category.id == idCategories,
      );
      setState(() {

      });
      name = selectedCategoriesValue!.name;
      idCategory = selectedCategoriesValue!.id;
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
            SizedBox(height: 10.h,),
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
                              Provider.of<ShopProv>(context, listen: false).
                              getImage(ImageSource.camera);
                            },
                            icon: const Icon(Icons.camera_alt_outlined),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Provider.of<ShopProv>(context, listen: false).
                              getImage(ImageSource.gallery);
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
                child: Consumer<ShopProv>(
                  builder: (context, value, child) {
                    return value.image != null
                        ? Image.file(
                      value.image!,
                      width: 100.w,
                      height: 20.h,
                      fit: BoxFit.fill,
                    )
                        :
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: CachedNetworkImage(
                          height: (3.h) - 16,
                          width: 100.w - 16,
                          fit: BoxFit.fill,
                          imageUrl: ConsValues.BASEURL + widget.shop.imageURL,
                          progressIndicatorBuilder: (context, url,
                              downloadProgress) =>
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[400]!,
                                child: Container(
                                  color: Colors.grey[300]!,
                                  height: (3.h) - 16,
                                  width: 100.w - 16,
                                ),
                              ),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),

                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 60,),
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
            Row(
              children: [
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  'Status: $dropdownValue',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  width: 10.w,
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
                      idStatusTypes = "2";
                    } else {
                      idStatusTypes = "1";
                    }
                  },
                ),
              ],
            ),
            Row(
              children: [
                 SizedBox(width: 20.w,),
                Text(
                  'Category Name:$name',
                  style: const TextStyle(fontSize: 20,),
                ),
                SizedBox(width: 20.w,),
                Consumer<CategoryProv>(
                  builder: (context, value, child) {
                    value.listCategoriesModelAdmin.length;
                    return DropdownButton<CategoriesModel>(
                      value: selectedCategoriesValue,
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
                          selectedCategoriesValue = Value;
                          idCategory = selectedCategoriesValue!.id;
                          name = selectedCategoriesValue!.name;

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
      bottomNavigationBar:
      CommonViews().customButton(
          textButton: "Save",
          context: MediaQuery.of(context),
          onTap: () async {
            await Provider.of<ShopProv>(context, listen: false)
                .UpdateShop(
                Id_categories: idCategory,
                index: widget.index,
                Id: widget.shop.id,
                name: _name.text,
                Id_statustypes: idStatusTypes);
            if (mounted) {
              Navigator.pop(context);
            }
          }),
    );
  }

}
