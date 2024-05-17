import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:update_flutter_project_one/configuration/const_values.dart';
import 'package:url_launcher/url_launcher.dart';
import 'banner_provider.dart';

class HomeBanner extends StatefulWidget {

   const HomeBanner({super.key});

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  @override
  void initState() {
    super.initState();

    Provider.of<BannerProv>( context,listen: false).getBannerImages();
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: 100.w,
      height: 25.h,
      child: Consumer<BannerProv>(
        builder: (context, value, child) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  await launchUrl(
                      Uri.parse(value.listBannerImages[index].url));
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: CachedNetworkImage(
                      height: (3.h) - 16,
                      width: (100.w)- 16,
                      fit: BoxFit.fill,
                      imageUrl: ConsValues.BASEURL +
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
              );
            },
            itemCount: value.listBannerImages.length,
            scrollDirection: Axis.horizontal,
          );
        },
      ),
    );
  }
}
