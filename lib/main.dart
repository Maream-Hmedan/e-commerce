import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:update_flutter_project_one/screens/cart_screen/cart_provider.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_banner/home_users_banner/banner_provider.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_category/home_categories_users/categories_provider.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_item/home_item_users/items_provider.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_shop/home_shop_user/shop_provider.dart';
import 'package:update_flutter_project_one/screens/order_screen/order_screen_users/order_details_provider.dart';
import 'package:update_flutter_project_one/screens/order_screen/order_screen_users/order_provider.dart';
import 'package:update_flutter_project_one/screens/splash/splash_screen.dart';

import 'configuration/app_colors.dart';
import 'screens/details/item_detail_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<BannerProv>(
            create: (_) => BannerProv(),
          ),
          ChangeNotifierProvider<CategoryProv>(
            create: (_) => CategoryProv(),
          ),
          ChangeNotifierProvider<ShopProv>(
            create: (_) => ShopProv(),
          ),
          ChangeNotifierProvider<ItemProv>(
            create: (_) => ItemProv(),
          ),
          ChangeNotifierProvider<ItemImagesProv>(
            create: (_) => ItemImagesProv(),
          ),
          ChangeNotifierProvider< CartProv>(
            create: (_) =>  CartProv(),
          ),
          ChangeNotifierProvider<OrderProv>(
            create: (_) => OrderProv(),
          ),
          ChangeNotifierProvider<OrderDetProv>(
            create: (_) => OrderDetProv(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          ),
          debugShowCheckedModeBanner: false,
          builder: EasyLoading.init(),
          home: const SplashScreen(),
        ),
      );
    });
  }
}
