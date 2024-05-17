import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:update_flutter_project_one/configuration/const_values.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_banner/home_admin_banner/add_banner_view.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_banner/home_admin_banner/edit_banner_view.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_banner/home_users_banner/banner_provider.dart';
import 'package:update_flutter_project_one/utils/helper/app_navigation.dart';
import 'package:update_flutter_project_one/utils/ui/common_app_bar.dart';

class AdminBannerScreen extends StatefulWidget {
  const AdminBannerScreen({Key? key}) : super(key: key);

  @override
  State<AdminBannerScreen> createState() => _AdminBannerScreenState();
}

class _AdminBannerScreenState extends State<AdminBannerScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<BannerProv>(context, listen: false).getBannerImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAdminAppBar(
        title: 'Admin Banner',
      ),
      body: Consumer<BannerProv>(
        builder: (context, value, child) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  AppNavigator.of(context, isAnimated: true)
                      .push(EditBannerScreen(
                    bannerImages: value.listBannerImages[index],
                  ));
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                       SizedBox(
                        width: 2.w,
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: CachedNetworkImage(
                            height: (3.h) - 16,
                            width: (100.w)- 16,
                            fit: BoxFit.fill,
                            imageUrl:  ConsValues.BASEURL +
                                value.listBannerImages[index].imageURL,
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[400]!,
                                  child:Container(
                                    color: Colors.grey[300]!,
                                    height: (3.h) - 16,
                                    width: 100.w - 16,
                                  ),
                                ),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),

                        ),
                      ),
                       SizedBox(
                        width: 2.w,
                      ),
                      IconButton(
                        onPressed: () {
                          AppNavigator.of(context, isAnimated: true)
                              .push(EditBannerScreen(
                            bannerImages: value.listBannerImages[index],
                          ));
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: value.listBannerImages.length,
            scrollDirection: Axis.vertical,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppNavigator.of(context, isAnimated: true)
              .push(const AddBannerScreen(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
