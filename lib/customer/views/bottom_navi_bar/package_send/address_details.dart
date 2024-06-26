import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:v_export/constant/common_container.dart';

class AddressDetails extends StatefulWidget {
  @override
  State<AddressDetails> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AddressDetails> {
  late GoogleMapController _controller;
  final Set<Marker> _markers = {};
  late LocationData _currentPosition;
  Location location = Location();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.7749, -122.4194), // San Francisco
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  void _getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }


    _currentPosition = await location.getLocation();
    location.onLocationChanged.listen((LocationData currentLocation) {
      _currentPosition = currentLocation;
      _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target:
              LatLng(_currentPosition.latitude!, _currentPosition.longitude!),
          zoom: 14.0,
        ),
      ));
      setState(() {
        _markers.add(Marker(
          markerId: MarkerId('currentLocation'),
          position:
              LatLng(_currentPosition.latitude!, _currentPosition.longitude!),
          infoWindow: InfoWindow(title: 'Your Location'),
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.kblue,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.kblue,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: AppColors.kwhite,
          ),
        ),
        title: Text(
          'Address Details',
          style: primaryfont.copyWith(
              fontSize: 20.sp,
              color: AppColors.kwhite,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Container(
              height: size.height,
              width: size.width,
              color: Colors.yellow,
              child: GoogleMap(
                initialCameraPosition: _initialPosition,
                markers: _markers,
                myLocationEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                },
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.4,
            maxChildSize: 1.0,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Color(0xffF4F8FF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 5,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView(
                        physics: AlwaysScrollableScrollPhysics(),
                        controller: scrollController,
                        children: [
                          Text(
                            "Enter Address",
                            style: primaryfont.copyWith(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          ksizedbox5,
                          Container(
                            height: 45,
                            width: size.width,
                            decoration: BoxDecoration(
                              color: AppColors.kwhite,
                            ),
                            child: TextFormField(
                                // controller: parcelitemController,
                                decoration: InputDecoration(
                                    hintText: 'Enter postal code',
                                    hintStyle: primaryfont.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Color(0xff444444),
                                      ),
                                    ))),
                          ),
                          ksizedbox20,
                          Text(
                            "Enter Block no / Unit no",
                            style: primaryfont.copyWith(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          ksizedbox5,
                          Container(
                            height: 45,
                            width: size.width,
                            decoration: BoxDecoration(
                              color: AppColors.kwhite,
                            ),
                            child: TextFormField(
                                // controller: parcelitemController,
                                decoration: InputDecoration(
                                    hintText: 'Enter Block no / Unit no',
                                    hintStyle: primaryfont.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Color(0xff444444),
                                      ),
                                    ))),
                          ),
                          ksizedbox20,
                          Text(
                            "Customer Name",
                            style: primaryfont.copyWith(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          ksizedbox5,
                          Container(
                            height: 45,
                            width: size.width,
                            decoration: BoxDecoration(
                              color: AppColors.kwhite,
                            ),
                            child: TextFormField(
                                // controller: parcelitemController,
                                decoration: InputDecoration(
                                    hintText: 'Enter postal code',
                                    hintStyle: primaryfont.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Color(0xff444444),
                                      ),
                                    ))),
                          ),
                          ksizedbox20,
                          Text(
                            "Enter Phone Number",
                            style: primaryfont.copyWith(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          ksizedbox5,
                          Container(
                            height: 45,
                            width: size.width,
                            decoration: BoxDecoration(
                              color: AppColors.kwhite,
                            ),
                            child: TextFormField(
                                // controller: parcelitemController,
                                decoration: InputDecoration(
                                    hintText: 'Enter Phone Number',
                                    hintStyle: primaryfont.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Color(0xff444444),
                                      ),
                                    ))),
                          ),
                          ksizedbox30,
                          InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: CommonContainer(
                                name: 'Confirm',
                              )),
                        ],
                      ),
                    )),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
