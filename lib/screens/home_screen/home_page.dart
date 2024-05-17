import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_category/home_categories_users/category_view.dart';
import 'package:update_flutter_project_one/utils/ui/common_views.dart';

import 'home_banner/home_users_banner/banner_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeInRight(
        delay: const Duration(milliseconds: 1000),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonViews().customAppBar(
                title: "Home",
                context:context,
              ),
              const Text("  Banner",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              const HomeBanner(),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("  Category",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  Spacer(),
                  Text("View all >  ",style: TextStyle(fontSize:18,color: Colors.grey),)
                ],
              ),
              const HomeCategory(),


            ],
          ),
        ),
      ),
    );
  }
}
