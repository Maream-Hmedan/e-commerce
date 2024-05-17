// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:update_flutter_project_one/configuration/const_values.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_category/home_categories_users/categories_provider.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_category/home_categories_users/category_model.dart';
import 'package:update_flutter_project_one/utils/ui/common_views.dart';

class EditCategoriesScreen extends StatefulWidget {
  CategoriesModel categoriesModel;
  int index;

  EditCategoriesScreen(
      {super.key, required this.categoriesModel, required this.index});

  @override
  State<EditCategoriesScreen> createState() => _EditCategoriesScreenState();
}

class _EditCategoriesScreenState extends State<EditCategoriesScreen> {
  File? image;
  final TextEditingController _name = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();

  String dropdownValue = "";
  var idStatusTypes;

  @override
  void initState() {
    super.initState();
    _name.text = widget.categoriesModel.name;
    idStatusTypes= widget.categoriesModel.iDStateType;
    if (idStatusTypes == "2") {
      dropdownValue = "DisActive";
    } else {
      dropdownValue = "Active";
    }
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
                              Provider.of<CategoryProv>(context, listen: false)
                                  .getImage(ImageSource.camera);
                            },
                            icon: const Icon(Icons.camera_alt_outlined),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Provider.of<CategoryProv>(context, listen: false)
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
                height: 40.h,
                child: Consumer<CategoryProv>(
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
                          height: 200,
                          width: 200,
                          fit: BoxFit.fill,
                          imageUrl: ConsValues.BASEURL +
                              widget.categoriesModel.imageURL,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[400]!,
                                child: Container(
                                  color: Colors.grey[300]!,
                                  height: 200,
                                  width: 200,
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
            SizedBox(
              height: 20.h,
            ),
            CommonViews().createTextFormField(
                controller: _name,
                focusNode: _nameFocusNode,
                onSubmitted: (value) {
                  FocusManager.instance.primaryFocus!.unfocus();
                },
                label:" Categories Name",
                hint: "ADD Name",
                prefixIcon: Icons.shop_2_outlined,
                keyboardType: TextInputType.name),

            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20.w,
                ),
                Text(
                  'Status: $dropdownValue',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  width: 20.w,
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
          ],
        ),
      ),
      bottomNavigationBar:    CommonViews().customButton(
          textButton: "Save",
          context: MediaQuery.of(context),
          onTap: () async {
            await Provider.of<CategoryProv>(context, listen: false)
                .updateCategory(
                index: widget.index,
                name: _name.text,
                id:  widget.categoriesModel.id,
                idStatusTypes: idStatusTypes);
            if (mounted) {
              Navigator.pop(context);
            }
          }),
    );
  }
}
