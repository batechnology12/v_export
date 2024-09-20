import 'package:date_format/date_format.dart';
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
import 'package:v_export/customer/controller/home_controller.dart';
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
  AccountController accountController = Get.put(AccountController());
  HomeController homeController = Get.put(HomeController());

  GoogleMapController? _controller;
  final Set<Marker> _markers = {};
  loc.LocationData? _currentPosition; // Make _currentPosition nullable
  loc.Location location = loc.Location();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.7749, -122.4194), // San Francisco
    zoom: 12,
  );

  final TextEditingController _unitIdController = TextEditingController();
  final TextEditingController _blockUnitController = TextEditingController();

  final TextEditingController _senderNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  String vehiclepickupincode = "";
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

  bool ischecked = false;
  final formKey = GlobalKey<FormState>();

  // void _showFullScreenvehicleAddressInput() {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     builder: (context) {
  //       return Padding(
  //         padding: const EdgeInsets.only(top: 50),
  //         child: DraggableScrollableSheet(
  //           initialChildSize: 1.0,
  //           minChildSize: 1.0,
  //           maxChildSize: 1.0,
  //           builder: (BuildContext context, ScrollController scrollController) {
  //             return
  //              Container(
  //               decoration: const BoxDecoration(
  //                 color: Color(0xffF4F8FF),
  //                 borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(20),
  //                   topRight: Radius.circular(20),
  //                 ),
  //               ),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(10.0),
  //                 child: Form(
  //                   key: formKey,
  //                   child: ListView(
  //                     physics: AlwaysScrollableScrollPhysics(),
  //                     controller: scrollController,
  //                     children: [
  //                       Text(
  //                         "Enter Address",
  //                         style: primaryfont.copyWith(
  //                             fontSize: 17,
  //                             color: Colors.black,
  //                             fontWeight: FontWeight.w600),
  //                       ),
  //                       ksizedbox5,
  //                       Container(
  //                         //   margin: EdgeInsets.only(left: 20),
  //                         height: 47.h,
  //                         width: double.infinity,
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(10),
  //                           color: Colors.white,
  //                         ),
  //                         child: GooglePlaceAutoCompleteTextField(
  //                           textEditingController: searchController,
  //                           googleAPIKey:
  //                               "AIzaSyAyygarjlqp_t2SPo7vS1oXDq1Yxs-LLNg",
  //                           inputDecoration: InputDecoration(
  //                               contentPadding: EdgeInsets.only(left: 10),
  //                               isDense: true,
  //                               hintText: 'Enter Your Address....',
  //                               hintStyle: primaryfont.copyWith(
  //                                   fontSize: 14, fontWeight: FontWeight.w500),
  //                               border: InputBorder.none),
  //                           focusNode: FocusNode(),
  //                           debounceTime: 600,
  //                           isLatLngRequired: true,
  //                           getPlaceDetailWithLatLng: (Prediction prediction) {
  //                             RegExp regExp = RegExp(
  //                                 r'\b\d{6}\b'); // Pattern to match 6-digit pincode
  //                             Match? match =
  //                                 regExp.firstMatch(prediction.description!);

  //                             if (match != null) {
  //                               vehiclepickupincode =
  //                                   match.group(0)!; // Store the pincode
  //                             }

  //                             print('Extracted Pincode: $vehiclepickupincode');
  //                             if (_controller != null) {
  //                               _controller!.animateCamera(
  //                                   CameraUpdate.newCameraPosition(
  //                                 CameraPosition(
  //                                   target: LatLng(
  //                                       double.parse(prediction.lat!),
  //                                       double.parse(prediction.lng!)),
  //                                   zoom: 14.0,
  //                                 ),
  //                               ));
  //                             }

  //                             setState(() {
  //                               _markers.add(Marker(
  //                                 markerId: MarkerId(prediction.placeId!),
  //                                 position: LatLng(
  //                                     double.parse(prediction.lat!),
  //                                     double.parse(prediction.lng!)),
  //                                 infoWindow: InfoWindow(
  //                                     title: prediction.description!),
  //                               ));
  //                             });
  //                           },
  //                           itemClick: (Prediction prediction) {
  //                             searchController.text = prediction.description!;
  //                             searchController.selection =
  //                                 TextSelection.fromPosition(TextPosition(
  //                                     offset: prediction.description!.length));
  //                           },
  //                         ),
  //                       ),
  //                       ksizedbox20,
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text(
  //                                 "Enter Block no",
  //                                 style: primaryfont.copyWith(
  //                                     fontSize: 17,
  //                                     color: Colors.black,
  //                                     fontWeight: FontWeight.w600),
  //                               ),
  //                               ksizedbox5,
  //                               Container(
  //                                 height: 47,
  //                                 width: 150.w,
  //                                 decoration: BoxDecoration(
  //                                   color: AppColors.kwhite,
  //                                 ),
  //                                 child: TextFormField(
  //                                     controller: _blockUnitController,
  //                                     inputFormatters: [
  //                                       LengthLimitingTextInputFormatter(4),
  //                                       //  FilteringTextInputFormatter.digitsOnly,
  //                                     ],
  //                                     keyboardType: TextInputType.text,
  //                                     decoration: InputDecoration(
  //                                         hintText: 'Enter Block no',
  //                                         hintStyle: primaryfont.copyWith(
  //                                             fontSize: 14,
  //                                             fontWeight: FontWeight.w500),
  //                                         border: OutlineInputBorder(
  //                                           borderRadius:
  //                                               BorderRadius.circular(10),
  //                                           borderSide: BorderSide(
  //                                             width: 1,
  //                                             color: Color(0xff444444),
  //                                           ),
  //                                         ))),
  //                               ),
  //                             ],
  //                           ),
  //                           Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text(
  //                                 "Enter Unit no",
  //                                 style: primaryfont.copyWith(
  //                                     fontSize: 17,
  //                                     color: Colors.black,
  //                                     fontWeight: FontWeight.w600),
  //                               ),
  //                               ksizedbox5,
  //                               Container(
  //                                 height: 47,
  //                                 width: 150.w,
  //                                 decoration: BoxDecoration(
  //                                   color: AppColors.kwhite,
  //                                 ),
  //                                 child: TextFormField(
  //                                     controller: _unitIdController,
  //                                     inputFormatters: [
  //                                       LengthLimitingTextInputFormatter(4),
  //                                       // FilteringTextInputFormatter.digitsOnly,
  //                                     ],
  //                                     keyboardType: TextInputType.text,
  //                                     decoration: InputDecoration(
  //                                         hintText: 'Enter Unit no',
  //                                         hintStyle: primaryfont.copyWith(
  //                                             fontSize: 14,
  //                                             fontWeight: FontWeight.w500),
  //                                         border: OutlineInputBorder(
  //                                           borderRadius:
  //                                               BorderRadius.circular(10),
  //                                           borderSide: BorderSide(
  //                                             width: 1,
  //                                             color: Color(0xff444444),
  //                                           ),
  //                                         ))),
  //                               ),
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                       ksizedbox20,
  //                       Text(
  //                         "Sender Name",
  //                         style: primaryfont.copyWith(
  //                             fontSize: 17,
  //                             color: Colors.black,
  //                             fontWeight: FontWeight.w600),
  //                       ),
  //                       ksizedbox5,
  //                       Container(
  //                         height: 47,
  //                         width: double.infinity,
  //                         decoration: BoxDecoration(
  //                           color: AppColors.kwhite,
  //                         ),
  //                         child: TextFormField(
  //                             textCapitalization: TextCapitalization.sentences,
  //                             controller: _senderNameController,
  //                             decoration: InputDecoration(
  //                                 hintText: 'Enter Sender Name',
  //                                 hintStyle: primaryfont.copyWith(
  //                                     fontSize: 14,
  //                                     fontWeight: FontWeight.w500),
  //                                 border: OutlineInputBorder(
  //                                   borderRadius: BorderRadius.circular(10),
  //                                   borderSide: BorderSide(
  //                                     width: 1,
  //                                     color: Color(0xff444444),
  //                                   ),
  //                                 ))),
  //                       ),
  //                       ksizedbox20,
  //                       Text(
  //                         "Enter Phone Number",
  //                         style: primaryfont.copyWith(
  //                             fontSize: 17,
  //                             color: Colors.black,
  //                             fontWeight: FontWeight.w600),
  //                       ),
  //                       ksizedbox5,
  //                       TextFormField(
  //                         controller: _phoneNumberController,
  //                         validator: (value) {
  //                           if (value!.length != 8) {
  //                             return "Enter 8 digits phone number";
  //                           }
  //                           return null;
  //                         },
  //                         keyboardType: TextInputType.phone,
  //                         inputFormatters: [
  //                           LengthLimitingTextInputFormatter(8),
  //                           FilteringTextInputFormatter.digitsOnly,
  //                           FilteringTextInputFormatter.deny(RegExp(r'\s')),
  //                         ],
  //                         decoration: InputDecoration(
  //                           contentPadding: EdgeInsets.only(top: 13),
  //                           prefixIcon: Row(
  //                             mainAxisSize: MainAxisSize.min,
  //                             children: [
  //                               Container(
  //                                 height: 30,
  //                                 width: 50,
  //                                 alignment: Alignment.center,
  //                                 child: Text(
  //                                   "+65",
  //                                   style: primaryfont.copyWith(
  //                                     fontSize: 14, // Adjust font size
  //                                     fontWeight: FontWeight.bold,
  //                                   ),
  //                                 ),
  //                               ),
  //                               SizedBox(width: 5),
  //                             ],
  //                           ),
  //                           fillColor: AppColors.kwhite,
  //                           filled: true,
  //                           hintText: 'Enter Phone Number',
  //                           hintStyle: primaryfont.copyWith(
  //                               fontSize: 14, fontWeight: FontWeight.w500),
  //                           border: OutlineInputBorder(
  //                             borderRadius: BorderRadius.circular(10),
  //                           ),
  //                           focusedBorder: OutlineInputBorder(
  //                             borderSide: BorderSide(
  //                               color: Color(0xff444444),
  //                             ),
  //                             borderRadius: BorderRadius.circular(10),
  //                           ),
  //                           focusedErrorBorder: OutlineInputBorder(
  //                             borderSide: BorderSide(
  //                               color: Color(0xff444444),
  //                             ),
  //                             borderRadius: BorderRadius.circular(10),
  //                           ),
  //                           errorBorder: OutlineInputBorder(
  //                             borderSide: BorderSide(
  //                               color: Color(0xff444444),
  //                             ),
  //                             borderRadius: BorderRadius.circular(10),
  //                           ),
  //                         ),
  //                       ),
  //                       ksizedbox20,
  //                       InkWell(
  //                           onTap: () async {
  //                             print(
  //                                 "block iD --- ${_blockUnitController.text}");
  //                             print("unit iD --- ${_unitIdController.text}");

  //                             if (formKey.currentState!.validate()) {
  //                               if (_senderNameController.text.isNotEmpty &&
  //                                   _blockUnitController.text.isNotEmpty &&
  //                                   _unitIdController.text.isNotEmpty &&
  //                                   searchController.text.isNotEmpty &&
  //                                   _phoneNumberController.text.isNotEmpty) {
  //                                 await homeController
  //                                     .updatevehiclePickupLocation(
  //                                   searchController.text,
  //                                   _markers.first.position.latitude.toString(),
  //                                   _markers.first.position.longitude
  //                                       .toString(),
  //                                   _senderNameController.text,
  //                                   _phoneNumberController.text,
  //                                   _blockUnitController.text,
  //                                   _unitIdController.text,
  //                                   vehiclepickupincode,
  //                                 );

  //                                 Get.offAll(BookVehicleScreen(
  //                                   vehiclePickupPincode: vehiclepickupincode,
  //                                   vehiclepickupBlockIDs:
  //                                       _blockUnitController.text,
  //                                   vehiclepickupunitId: _unitIdController.text,
  //                                   vehiclepickupAdress: searchController.text,
  //                                   vehiclepickuplat: _markers
  //                                       .first.position.latitude
  //                                       .toString(),
  //                                   vehiclepickuplong: _markers
  //                                       .first.position.longitude
  //                                       .toString(),
  //                                   vehiclepickupsendername:
  //                                       _senderNameController.text,
  //                                   vehicleSenderMobilenumber:
  //                                       _phoneNumberController.text,
  //                                 ));
  //                               } else {
  //                                 Get.snackbar(
  //                                     "Fill all Fields", "Please try again!",
  //                                     colorText: AppColors.kwhite,
  //                                     backgroundColor: Colors.red,
  //                                     snackPosition: SnackPosition.BOTTOM);
  //                               }
  //                             }
  //                           },
  //                           child: CommonContainer(
  //                             name: 'Confirm',
  //                           )),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: AppColors.kblue,
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.kblue,
              AppColors.kwhite,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: AppColors.kwhite,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: ListView(
                physics: AlwaysScrollableScrollPhysics(),
                // controller: scrollController,
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
                    height: 47.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: GooglePlaceAutoCompleteTextField(
                      textEditingController: searchController,
                      googleAPIKey: "AIzaSyAyygarjlqp_t2SPo7vS1oXDq1Yxs-LLNg",
                      inputDecoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10),
                          isDense: true,
                          hintText: 'Enter Your Address....',
                          hintStyle: primaryfont.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w500),
                          border: InputBorder.none),
                      focusNode: FocusNode(),
                      debounceTime: 600,
                      isLatLngRequired: true,
                      getPlaceDetailWithLatLng: (Prediction prediction) {
                        RegExp regExp = RegExp(
                            r'\b\d{6}\b'); // Pattern to match 6-digit pincode
                        Match? match =
                            regExp.firstMatch(prediction.description!);

                        if (match != null) {
                          vehiclepickupincode =
                              match.group(0)!; // Store the pincode
                        }

                        print('Extracted Pincode: $vehiclepickupincode');
                        if (_controller != null) {
                          _controller!
                              .animateCamera(CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: LatLng(double.parse(prediction.lat!),
                                  double.parse(prediction.lng!)),
                              zoom: 14.0,
                            ),
                          ));
                        }

                        setState(() {
                          _markers.add(Marker(
                            markerId: MarkerId(prediction.placeId!),
                            position: LatLng(double.parse(prediction.lat!),
                                double.parse(prediction.lng!)),
                            infoWindow:
                                InfoWindow(title: prediction.description!),
                          ));
                        });
                      },
                      itemClick: (Prediction prediction) {
                        searchController.text = prediction.description!;
                        searchController.selection = TextSelection.fromPosition(
                            TextPosition(
                                offset: prediction.description!.length));
                      },
                    ),
                  ),
                  ksizedbox20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Enter Block no",
                            style: primaryfont.copyWith(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          ksizedbox5,
                          Container(
                            height: 47,
                            width: 150.w,
                            decoration: BoxDecoration(
                              color: AppColors.kwhite,
                            ),
                            child: TextFormField(
                                controller: _blockUnitController,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(4),
                                  //  FilteringTextInputFormatter.digitsOnly,
                                ],
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    hintText: 'Enter Block no',
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
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Enter Unit no",
                            style: primaryfont.copyWith(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          ksizedbox5,
                          Container(
                            height: 47,
                            width: 150.w,
                            decoration: BoxDecoration(
                              color: AppColors.kwhite,
                            ),
                            child: TextFormField(
                                controller: _unitIdController,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(8),
                                  // FilteringTextInputFormatter.digitsOnly,
                                ],
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    hintText: 'Enter Unit no',
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
                        ],
                      ),
                    ],
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
                    height: 47,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.kwhite,
                    ),
                    child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        controller: _senderNameController,
                        decoration: InputDecoration(
                            hintText: 'Enter Sender Name',
                            hintStyle: primaryfont.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w500),
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
                  TextFormField(
                    controller: _phoneNumberController,
                    validator: (value) {
                      if (value!.length != 8) {
                        return "Enter 8 digits phone number";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(8),
                      FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 13),
                      prefixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 30,
                            width: 50,
                            alignment: Alignment.center,
                            child: Text(
                              "+65",
                              style: primaryfont.copyWith(
                                fontSize: 14, // Adjust font size
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                        ],
                      ),
                      fillColor: AppColors.kwhite,
                      filled: true,
                      hintText: 'Enter Phone Number',
                      hintStyle: primaryfont.copyWith(
                          fontSize: 14, fontWeight: FontWeight.w500),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff444444),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff444444),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff444444),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  ksizedbox20,
                  InkWell(
                      onTap: () async {
                        print("block iD --- ${_blockUnitController.text}");
                        print("unit iD --- ${_unitIdController.text}");

                        if (formKey.currentState!.validate()) {
                          if (_senderNameController.text.isNotEmpty &&
                              _blockUnitController.text.isNotEmpty &&
                              _unitIdController.text.isNotEmpty &&
                              searchController.text.isNotEmpty &&
                              _phoneNumberController.text.isNotEmpty) {
                            await homeController.updatevehiclePickupLocation(
                              searchController.text,
                              _markers.first.position.latitude.toString(),
                              _markers.first.position.longitude.toString(),
                              _senderNameController.text,
                              _phoneNumberController.text,
                              _blockUnitController.text,
                              _unitIdController.text,
                              vehiclepickupincode,
                            );

                            Get.offAll(BookVehicleScreen(
                              vehiclePickupPincode: vehiclepickupincode,
                              vehiclepickupBlockIDs: _blockUnitController.text,
                              vehiclepickupunitId: _unitIdController.text,
                              vehiclepickupAdress: searchController.text,
                              vehiclepickuplat:
                                  _markers.first.position.latitude.toString(),
                              vehiclepickuplong:
                                  _markers.first.position.longitude.toString(),
                              vehiclepickupsendername:
                                  _senderNameController.text,
                              vehicleSenderMobilenumber:
                                  _phoneNumberController.text,
                            ));
                          } else {
                            Get.snackbar("Fill all Fields", "Please try again!",
                                colorText: AppColors.kwhite,
                                backgroundColor: Colors.red,
                                snackPosition: SnackPosition.BOTTOM);
                          }
                        }
                      },
                      child: CommonContainer(
                        name: 'Confirm',
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
