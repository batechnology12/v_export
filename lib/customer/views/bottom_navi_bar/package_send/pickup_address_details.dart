import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as loc; // Alias for location package
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:v_export/constant/common_container.dart';
import 'package:geocoding/geocoding.dart';
import 'package:v_export/customer/controller/account_controller.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/package_send_screen.dart';

class PickupAddressDetails extends StatefulWidget {
  @override
  State<PickupAddressDetails> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PickupAddressDetails> {
  AccountController accountController = Get.find<AccountController>();

  late GoogleMapController _controller;
  final Set<Marker> _markers = {};
  late loc.LocationData _currentPosition;
  loc.Location location = loc.Location(); // Use the alias

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.7749, -122.4194), // San Francisco
    zoom: 12,
  );

  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _blockUnitController = TextEditingController();
  final TextEditingController _senderNameController = TextEditingController();
  final TextEditingController _receiverNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _getLocation();
      //  await accountController.getProfile();

      _fetchAddress();
      accountController.update();
      setState(() {});
    });
  }

  void _getLocation() async {
    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    location.onLocationChanged.listen((loc.LocationData currentLocation) {
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
        _fetchAddress();
      });
    });
  }

  Future<void> _fetchAddress() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude!, _currentPosition.longitude!);
      Placemark place = placemarks[0];
      setState(() {
        _postalCodeController.text =
            "${place.name},${place.subLocality},${place.locality},${place.postalCode}" ??
                '';
        _blockUnitController.text = place.street ?? '';
        // _senderNameController.text = accountController.getUserData != null
        //     ? accountController.getUserData!.firstName
        //     : "";
        _phoneNumberController.text = place.country ?? '';

        print("------location address");
        print(place.name ?? '');
        print(place.street ?? '');
        // print(place.subAdministrativeArea ?? '');
        print(place.administrativeArea ?? '');
        // print(place.subThoroughfare ?? '');
        print(place.thoroughfare ?? '');
        print(place.subLocality ?? '');
        print(place.locality ?? '');
        print(place.administrativeArea ?? '');
        print(place.country ?? '');
      });
    } catch (e) {
      print(e);
    }
  }

  bool ischecked = false;

  // getProfileData() async {
  //   if (accountController.getUserData != null) {
  //     _senderNameController.text = accountController.getUserData!.firstName;
  //   }
  // }

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
          'Pickup Address Details',
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
            initialChildSize: 0.3,
            minChildSize: 0.3,
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
                              maxLines: 1,
                              minLines: 1,
                              controller: _postalCodeController,
                              decoration: InputDecoration(
                                hintText: 'Enter address',
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
                                controller: _blockUnitController,
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
                            "Sender Name",
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
                                controller: _senderNameController,
                                decoration: InputDecoration(
                                    hintText: 'Enter Sender Name',
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
                                controller: _receiverNameController,
                                decoration: InputDecoration(
                                    hintText: 'Enter Receiver Name',
                                    hintStyle: primaryfont.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
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
                                controller: _phoneNumberController,
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
                          ksizedbox20,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(
                                    () {
                                      ischecked = !ischecked;
                                    },
                                  );
                                },
                                child: Container(
                                  height: 20.h,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: AppColors.kblue),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: ischecked == true
                                      ? Image.asset("assets/icons/7-Check.png")
                                      : Text(""),
                                ),
                              ),
                              Ksizedboxw10,
                              Text(
                                "Save Address",
                                style: primaryfont.copyWith(
                                    fontSize: 14.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          ksizedbox20,
                          InkWell(
                              onTap: () {
                                // await _fetchAddress();
                                Get.to(PackageSendScreen(
                                  unitIdBlockID: [_blockUnitController.text],
                                  pickupAdress: _postalCodeController.text,
                                  lat: _currentPosition.latitude.toString(),
                                  long: _currentPosition.longitude.toString(),
                                ));
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
