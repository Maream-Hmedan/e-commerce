import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:update_flutter_project_one/configuration/const_values.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_category/home_categories_admin/add_categories_view.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_category/home_categories_admin/edit_categories_view.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_category/home_categories_users/categories_provider.dart';
import 'package:update_flutter_project_one/utils/helper/app_navigation.dart';
import 'package:update_flutter_project_one/utils/ui/common_app_bar.dart';

class CategoriesAdminScreen extends StatefulWidget {
  const CategoriesAdminScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesAdminScreen> createState() => _CategoriesAdminScreenState();
}

class _CategoriesAdminScreenState extends State<CategoriesAdminScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CategoryProv>(context, listen: false).getCategoriesAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAdminAppBar(
        title: 'Admin Categories',
      ),
      body: Consumer<CategoryProv>(
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
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: CachedNetworkImage(
                              height: 200,
                              width: 200,
                              fit: BoxFit.fill,
                              imageUrl: ConsValues.BASEURL +
                                  value.listCategoriesModelAdmin[index]
                                      .imageURL,
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
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(value.listCategoriesModelAdmin[index].name),
                        SizedBox(
                          width: 5.w,
                        ),
                        IconButton(
                          onPressed: () {
                            AppNavigator.of(context).push(EditCategoriesScreen(
                              categoriesModel: value
                                  .listCategoriesModelAdmin[index],
                              index: index,));
                          },
                          icon: const Icon(Icons.edit),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
            itemCount: value.listCategoriesModelAdmin.length,
            scrollDirection: Axis.vertical,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppNavigator.of(context).push(const AddCategoriesScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
