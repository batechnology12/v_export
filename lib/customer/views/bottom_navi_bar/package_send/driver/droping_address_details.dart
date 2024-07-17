import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/constant/common_container.dart';
import 'package:v_export/customer/controller/account_controller.dart';
import 'package:v_export/customer/controller/home_controller.dart';

class DroppingAddressDetails extends StatefulWidget {
  final int index;

  const DroppingAddressDetails({super.key, required this.index});

  @override
  State<DroppingAddressDetails> createState() => _DroppingAddressDetailsState();
}

class _DroppingAddressDetailsState extends State<DroppingAddressDetails> {
  AccountController accountController = Get.find<AccountController>();
  HomeController homeController = Get.find<HomeController>();
  late GoogleMapController _controller;
  final Set<Marker> _markers = {};
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.7749, -122.4194), // San Francisco
    zoom: 12,
  );
  String fullAddress = "";
  String areapincode = "";
  String doorno = "";
  List<Placemark> placemarks = [];

  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _fetchAddress() async {
    List<Location> locations =
        await locationFromAddress(_addressController.text);
    if (locations.isNotEmpty) {
      final location = locations.first;
      placemarks =
          await placemarkFromCoordinates(location.latitude, location.longitude);
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        fullAddress =
            '${placemark.name}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}';
        areapincode = placemark.postalCode!;
        doorno = placemark.name!;

        print("7890456789054-=Location get----------66666666666");
        print(fullAddress);
        _controller.animateCamera(CameraUpdate.newLatLng(
          LatLng(location.latitude, location.longitude),
        ));
        setState(() {
          _markers.clear();
          _markers.add(Marker(
            markerId: MarkerId('enteredAddress'),
            position: LatLng(location.latitude, location.longitude),
            infoWindow: InfoWindow(title: fullAddress),
          ));
        });
      }
    }
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
          'Dropping Address Details',
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
            initialChildSize: 0.35,
            minChildSize: 0.35,
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
                    const SizedBox(height: 5),
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
                          ksizedbox20,
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
                              maxLines: 1,
                              minLines: 1,
                              controller: _addressController,
                              decoration: InputDecoration(
                                hintText: 'Enter address',
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: _fetchAddress,
                                ),
                                hintStyle: primaryfont.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: Color(0xff444444),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ksizedbox20,
                          Text(
                            "Receiver Name",
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
                              maxLines: 1,
                              minLines: 1,
                              //  controller: _addressController,
                              decoration: InputDecoration(
                                hintText: 'Enter receiver name',
                                hintStyle: primaryfont.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: Color(0xff444444),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ksizedbox20,
                          InkWell(
                              onTap: () {
                                _fetchAddress();
                              },
                              child: CommonContainer(
                                name: 'Show on Map',
                              )),
                          ksizedbox20,
                          InkWell(
                            onTap: () {
                              homeController.updateDroppingLocation(
                                  fullAddress,
                                  _markers.first.position.latitude.toString(),
                                  _markers.first.position.longitude.toString(),
                                  areapincode,
                                  doorno,
                                  widget.index);
                              Get.back();
                            },
                            child: CommonContainer(
                              name: 'Confirm',
                            ),
                          ),
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
