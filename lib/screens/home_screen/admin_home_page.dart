import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:update_flutter_project_one/configuration/app_constant.dart';
import 'package:update_flutter_project_one/configuration/const_values.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_banner/home_admin_banner/admin_banner_view.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_category/home_categories_admin/admin_categories_view.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_item/home_item_admin/admin_item_view.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_shop/home_shop_admin/admin_shop_view.dart';
import 'package:update_flutter_project_one/screens/order_screen/order_screen_admin/order_admin_view.dart';
import 'package:update_flutter_project_one/screens/splash/splash_screen.dart';
import 'package:update_flutter_project_one/utils/helper/app_navigation.dart';
import 'package:update_flutter_project_one/utils/ui/common_app_bar.dart';
import 'package:update_flutter_project_one/utils/ui/common_views.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAdminAppBar(
        title: 'Admin Home',
      ),
      body: FadeInRight(
        delay: const Duration(milliseconds: 1000),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppConstant.spaceBetweenButtonInAdmin,
              ),
              CommonViews().customButton(
                  textButton: "Banner",
                  context: MediaQuery.of(context),
                  onTap: () {
                    AppNavigator.of(context, isAnimated: true)
                        .push(const AdminBannerScreen());
                  }),
              SizedBox(
                height: AppConstant.spaceBetweenButtonInAdmin,
              ),
              CommonViews().customButton(
                  textButton: "Item",
                  context: MediaQuery.of(context),
                  onTap: () {
                    AppNavigator.of(context, isAnimated: true)
                        .push(const ItemAdminScreen());
                  }),
              SizedBox(
                height: AppConstant.spaceBetweenButtonInAdmin,
              ),
              CommonViews().customButton(
                  textButton: "Shop",
                  context: MediaQuery.of(context),
                  onTap: () {
                    AppNavigator.of(context, isAnimated: true)
                        .push(const AdminShopScreen());
                  }),
              SizedBox(
                height: AppConstant.spaceBetweenButtonInAdmin,
              ),
              CommonViews().customButton(
                  textButton: "Categories",
                  context: MediaQuery.of(context),
                  onTap: () {
                    AppNavigator.of(context, isAnimated: true)
                        .push(const  CategoriesAdminScreen());
                  }),
              SizedBox(
                height: AppConstant.spaceBetweenButtonInAdmin,
              ),
              CommonViews().customButton(
                  textButton: "Orders",
                  context: MediaQuery.of(context),
                  onTap: () {
                    AppNavigator.of(context, isAnimated: true)
                        .push(const OrdersAdmin());
                  }),
              SizedBox(
                height: AppConstant.spaceBetweenButtonInAdmin,
              ),
              CommonViews().customButton(
                  textButton: "LogOut",
                  context: MediaQuery.of(context),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          icon: const Icon(Icons.logout_sharp),
                          content:
                              const Text("Are You Sure You Want To LogOut"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () async {
                                await CommonViews.remove(ConsValues.ID);
                                if (mounted) {
                                  Navigator.pop(context);
                                  AppNavigator.of(context, isAnimated: true)
                                      .pushAndRemoveUntil(const SplashScreen());
                                }
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
