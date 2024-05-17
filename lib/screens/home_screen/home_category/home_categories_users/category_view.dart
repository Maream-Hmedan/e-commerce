import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_category/home_categories_users/categories_provider.dart';
import '../../home_shop/home_shop_user/shop_provider.dart';
import '../../home_shop/home_shop_user/shop_view.dart';


class HomeCategory extends StatefulWidget {

  const HomeCategory({super.key});

  @override
  State<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {


  @override
  void initState() {
    super.initState();
    Provider.of<CategoryProv>( context ,listen: false).getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 5.h,
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            width: 100.w,
            height:2.h,
            padding: const EdgeInsets.all(8),
            child: Consumer<CategoryProv>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Provider.of<ShopProv>(context, listen: false).getShops(
                          idCategories: value.listCategoriesModel[index].id,
                        );
                      },
                      child: Container(
                        width: 90.w,
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        child: Text(
                          value.listCategoriesModel[index].name,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: value.listCategoriesModel.length,
                  scrollDirection: Axis.horizontal,
                );
              },
            ),
          ),
          const Expanded(
            child: HomeShop()
          ),

        ],
      )

    );
  }
}
