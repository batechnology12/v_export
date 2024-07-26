import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:location/location.dart' as loc; // Alias for location package
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:v_export/constant/common_container.dart';
import 'package:geocoding/geocoding.dart';
import 'package:v_export/customer/controller/account_controller.dart';
import 'package:v_export/customer/views/bottom_navi_bar/book_vehicle/book_vehicle_screen.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/package_send_screen.dart';
import 'package:google_places_flutter/google_places_flutter.dart';

class PickupVehicleAddressDetails extends StatefulWidget {
  @override
  State<PickupVehicleAddressDetails> createState() =>
      _PickupVehicleAddressDetailsState();
}

class _PickupVehicleAddressDetailsState
    extends State<PickupVehicleAddressDetails> {
  AccountController accountController = Get.find<AccountController>();

  GoogleMapController? _controller;
  final Set<Marker> _markers = {};
  loc.LocationData? _currentPosition; // Make _currentPosition nullable
  loc.Location location = loc.Location();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.7749, -122.4194), // San Francisco
    zoom: 12,
  );

  // final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _blockUnitController = TextEditingController();
  final TextEditingController _senderNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  bool _isManualSelection = false; // Flag to track manual selection

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //   _getLocation();
      accountController.update();
      //  setState(() {});
    });
  }

  // void _getLocation() async {
  //   bool _serviceEnabled;
  //   loc.PermissionStatus _permissionGranted;

  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return;
  //     }
  //   }

  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == loc.PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != loc.PermissionStatus.granted) {
  //       return;
  //     }
  //   }

  //   _currentPosition = await location.getLocation();
  //   location.onLocationChanged.listen((loc.LocationData currentLocation) {
  //     _currentPosition = currentLocation;
  //     if (!_isManualSelection) {
  //       _controller.animateCamera(CameraUpdate.newCameraPosition(
  //         CameraPosition(
  //           target: LatLng(
  //               _currentPosition!.latitude!, _currentPosition!.longitude!),
  //           zoom: 14.0,
  //         ),
  //       ));
  //       setState(() {
  //         _fetchAddress();
  //       });
  //     }
  //   });
  // }

  Future<void> _fetchAddress() async {
    if (_currentPosition != null) {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            _currentPosition!.latitude!, _currentPosition!.longitude!);
        Placemark place = placemarks[0];
        setState(() {
          searchController.text =
              "${place.name},${place.subLocality},${place.locality},${place.postalCode}" ??
                  '';
          //    _blockUnitController.text = place.name ?? place.name!;
          print("=============address");
          print(searchController.text =
              "${place.name},${place.subLocality},${place.locality},${place.postalCode}" ??
                  '');
        });
      } catch (e) {
        print(e);
      }
    }
  }

  // Future<void> _fetchPlaceName(double lat, double lng) async {
  //   try {
  //     List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
  //     Placemark place = placemarks[0];
  //     setState(() {
  //       //   _blockUnitController.text = place.name ?? '';
  //       print("-----------------street name");
  //       print(_blockUnitController.text = place.name ?? '');
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  bool ischecked = false;

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
              fontSize: 19.sp,
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
                            //   margin: EdgeInsets.only(left: 20),
                            height: 45.h,
                            width: size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: GooglePlaceAutoCompleteTextField(
                              textEditingController: searchController,
                              googleAPIKey:
                                  "AIzaSyAyygarjlqp_t2SPo7vS1oXDq1Yxs-LLNg",
                              inputDecoration: InputDecoration(
                                  isDense: true,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      "assets/icons/google-maps.png",
                                    ),
                                  ),
                                  // suffixIcon: Padding(
                                  //   padding: const EdgeInsets.all(5.0),
                                  //   child: Image.asset(
                                  //     "assets/icons/search.png",
                                  //   ),
                                  // ),
                                  hintText: 'Enter Your Address....',
                                  hintStyle: primaryfont.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  border: InputBorder.none
                                  // border: OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(10),
                                  //   borderSide: BorderSide(
                                  //     width: 1,
                                  //     color: Color(0xff444444),
                                  //   ),
                                  // ),
                                  ),
                              focusNode: FocusNode(),
                              debounceTime: 600,
                              isLatLngRequired: true,
                              getPlaceDetailWithLatLng:
                                  (Prediction prediction) {
                                if (_controller != null) {
                                  _controller!.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                      target: LatLng(
                                          double.parse(prediction.lat!),
                                          double.parse(prediction.lng!)),
                                      zoom: 14.0,
                                    ),
                                  ));
                                }

                                setState(() {
                                  _markers.add(Marker(
                                    markerId: MarkerId(prediction.placeId!),
                                    position: LatLng(
                                        double.parse(prediction.lat!),
                                        double.parse(prediction.lng!)),
                                    infoWindow: InfoWindow(
                                        title: prediction.description!),
                                  ));
                                });

                                // Fetch place name using the coordinates
                                // _fetchPlaceName(
                                //   double.parse(prediction.lat!),
                                //   double.parse(prediction.lng!),
                                // );
                              },
                              itemClick: (Prediction prediction) {
                                searchController.text = prediction.description!;
                                searchController.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset:
                                            prediction.description!.length));
                              },
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
                                textCapitalization:
                                    TextCapitalization.sentences,
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
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(8),
                              ],
                              decoration: InputDecoration(
                                hintText: 'Enter Phone Number',
                                hintStyle: primaryfont.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0xff444444),
                                  ),
                                ),
                              ),
                            ),
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
                                if (_senderNameController.text.isNotEmpty &&
                                    _phoneNumberController.text.isNotEmpty) {
                                  Get.to(BookVehicleScreen(
                                      vehiclepickupAdress:
                                          searchController.text,
                                      vehiclepickuplat: _markers
                                          .first.position.latitude
                                          .toString(),
                                      vehiclepickuplong: _markers
                                          .first.position.latitude
                                          .toString(),
                                      vehiclepickupunitIdBlockID:
                                          _blockUnitController.text,
                                      vehiclepickupsendername:
                                          _senderNameController.text,
                                      vehicleSenderMobilenumber:
                                          _phoneNumberController.text,
                                      vehicleDropAddress: [],
                                      vehicledroplat: [],
                                      vehicledroplong: [],
                                      vehicleDropunitIdBlockId: [],
                                      vehicleDropreceivername: [],
                                      vehiclearpincode: [],
                                      vehicledoorname: [],
                                      vehicleDropreceiverphone: []));
                                } else {
                                  Get.snackbar(
                                      "Fill all Fields", "Please try again!",
                                      colorText: AppColors.kwhite,
                                      backgroundColor: Colors.red,
                                      snackPosition: SnackPosition.BOTTOM);
                                }
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
