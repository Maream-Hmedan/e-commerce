import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:update_flutter_project_one/screens/home_screen/home_page.dart';
import 'package:update_flutter_project_one/utils/helper/app_navigation.dart';
import 'package:update_flutter_project_one/utils/ui/common_views.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final TextEditingController _noteTextEditingController =
      TextEditingController();
  List<Marker> listMarker = [
    const Marker(
        markerId: MarkerId("1"),
        position: LatLng(31.987101868879915, 35.899563678790344)),
    const Marker(
        markerId: MarkerId("2"),
        position: LatLng(31.984754077936124, 35.901398309837525)),
    const Marker(
      markerId: MarkerId("3"),
      position: LatLng(31.98761145897823, 35.90240682047165),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              CommonViews().customAppBar(
                title: "Cart Screen",
                context:context,
              ),
              Container(
                width: 100.w,
                height: 25.h,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(8),
                child: GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  markers: listMarker.toSet(),
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(
                      31.985418381468648,
                      35.8979650821469,
                    ),
                    zoom: 15,
                  ),
                ),
              ),
              TextField(
                controller: _noteTextEditingController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  label: const Text("Note"),
                  hintText: "Your Note Here",
                  icon: const Icon(Icons.note),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: CommonViews().customButton(
            textButton: "Done",
            onTap: () {
              AppNavigator.of(context, isAnimated: true)
                  .pushAndRemoveUntil(const HomePage());
            }));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
