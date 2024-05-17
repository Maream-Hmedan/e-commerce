// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_category/home_categories_users/categories_provider.dart';
import 'package:update_flutter_project_one/utils/ui/common_views.dart';

class AddCategoriesScreen extends StatefulWidget {
  const AddCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<AddCategoriesScreen> createState() => _AddCategoriesScreenState();
}

class _AddCategoriesScreenState extends State<AddCategoriesScreen> {
  final TextEditingController _name = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();

  String dropdownValue = 'DisActive';
  var idStatusTypes;

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
                  height: 20.h,
                  child: Consumer<CategoryProv>(
                    builder: (context, value, child) {
                      return value.image != null
                          ? Image.file(
                              value.image!,
                              width: 100.w,
                              height: 20.h,
                              fit: BoxFit.fill,
                            )
                          : const Icon(
                              (Icons.image),
                            );
                    },
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
                    FocusManager.instance.primaryFocus!.unfocus();
                  },
                  label:" Categories Name",
                  hint: "ADD Name",
                  prefixIcon: Icons.shop_2_outlined,
                  keyboardType: TextInputType.name),
              SizedBox(height: 5.h),
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
              SizedBox(
                height: 20.h,
              ),
              CommonViews().customButton(
                  textButton: "Save",
                  context: MediaQuery.of(context),
                  onTap: () async {
                    await Provider.of<CategoryProv>(context, listen: false)
                        .addNewCategories(
                        name: _name.text, idStatusTypes: idStatusTypes,);
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
