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
import 'package:v_export/customer/views/bottom_navi_bar/package_send/package_send_screen.dart';
import 'package:google_places_flutter/google_places_flutter.dart';

class PickupAddressDetails extends StatefulWidget {
  @override
  State<PickupAddressDetails> createState() => _PickupAddressDetailsState();
}

class _PickupAddressDetailsState extends State<PickupAddressDetails> {
  AccountController accountController = Get.find<AccountController>();
  HomeController homeController = Get.find<HomeController>();

  GoogleMapController? _controller;
  final Set<Marker> _markers = {};
  loc.LocationData? _currentPosition; // Make _currentPosition nullable
  loc.Location location = loc.Location();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.7749, -122.4194), // San Francisco
    zoom: 12,
  );

  final TextEditingController _blockUnitController = TextEditingController();
  final TextEditingController _UnitController = TextEditingController();

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
      accountController.update();
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
        });
      } catch (e) {
        print(e);
      }
    }
  }

  bool ischecked = false;

  final formKey = GlobalKey<FormState>();

  void _showFullScreenAddressInput() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 50),
          child: DraggableScrollableSheet(
            initialChildSize: 1.0,
            minChildSize: 1.0,
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
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: formKey,
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
                          height: 47.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: GooglePlaceAutoCompleteTextField(
                            textEditingController: searchController,
                            googleAPIKey:
                                "AIzaSyAyygarjlqp_t2SPo7vS1oXDq1Yxs-LLNg",
                            inputDecoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10),
                              isDense: true,
                              hintText: 'Enter Your Address....',
                              hintStyle: primaryfont.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                              border: InputBorder.none,
                            ),
                            focusNode: FocusNode(),
                            debounceTime: 600,
                            isLatLngRequired: true,
                            getPlaceDetailWithLatLng: (Prediction prediction) {
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
                            },
                            itemClick: (Prediction prediction) {
                              searchController.text = prediction.description!;
                              searchController.selection =
                                  TextSelection.fromPosition(TextPosition(
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
                                      decoration: InputDecoration(
                                          hintText: 'Enter Block no',
                                          hintStyle: primaryfont.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                      controller: _UnitController,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(4),
                                        //  FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      decoration: InputDecoration(
                                          hintText: 'Enter Unit no',
                                          hintStyle: primaryfont.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[a-zA-Z ]')),
                              ],
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
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 8, top: 15),
                              child: Text(
                                "+65",
                                textAlign: TextAlign.center,
                                style: primaryfont.copyWith(
                                  fontSize:
                                      15.sp, // Font size for the prefix icon
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            fillColor: AppColors.kwhite,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical:
                                    12, // Adjusted vertical padding for better alignment
                                horizontal:
                                    10), // Adjusted horizontal padding for better alignment
                            hintText: "Enter Sender Number",
                            hintStyle: primaryfont.copyWith(
                              color: Colors.grey,
                              fontSize: 14, // Font size for hint text
                              fontWeight: FontWeight.w100,
                            ),
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
                        //  TextFormField(
                        //       keyboardType: TextInputType.phone,
                        //       inputFormatters: [
                        //         selectedValues == "+65"
                        //             ? LengthLimitingTextInputFormatter(8)
                        //             : LengthLimitingTextInputFormatter(10),
                        //         FilteringTextInputFormatter.digitsOnly,
                        //       ],
                        //       validator: selectedValues == "+65"
                        //           ? (value) {
                        //               if (value!.length < 8 || value.length > 8) {
                        //                 return 'Mobile number should be in 8 digits';
                        //               } else {
                        //                 return null;
                        //               }
                        //             }
                        //           : (value) {
                        //               if (value!.length < 10 ||
                        //                   value.length > 10) {
                        //                 return 'Mobile number should be in 10 digits';
                        //               } else {
                        //                 return null;
                        //               }
                        //             },
                        //       controller: emailOrmobileController,
                        //       decoration: InputDecoration(
                        //         prefixIcon: Row(
                        //           mainAxisSize: MainAxisSize.min,
                        //           children: [
                        //             PopupMenuButton<int>(
                        //               padding: EdgeInsets.zero,
                        //               child: Container(
                        //                 height: 30,
                        //                 width: 50,
                        //                 alignment: Alignment.center,
                        //                 child: Text(
                        //                   selectedValues,
                        //                   style: primaryfont.copyWith(
                        //                     fontSize: 14, // Adjust font size
                        //                     fontWeight: FontWeight.bold,
                        //                   ),
                        //                 ),
                        //               ),
                        //               onSelected: (value) {
                        //                 setState(() {
                        //                   selectedIndex = value;
                        //                   selectedValues =
                        //                       value == 0 ? "+65" : "+91";
                        //                 });
                        //               },
                        //               itemBuilder: (context) => [
                        //                 PopupMenuItem<int>(
                        //                   value: 0,
                        //                   child: Container(
                        //                     height: 30,
                        //                     width: 50,
                        //                     alignment: Alignment.center,
                        //                     child: Text(
                        //                       "+65",
                        //                       style: primaryfont.copyWith(
                        //                         fontSize: 14, // Adjust font size
                        //                         fontWeight: FontWeight.bold,
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 PopupMenuItem<int>(
                        //                   value: 1,
                        //                   child: Container(
                        //                     height: 30,
                        //                     width: 50,
                        //                     alignment: Alignment.center,
                        //                     child: Text(
                        //                       "+91",
                        //                       style: primaryfont.copyWith(
                        //                         fontSize: 14, // Adjust font size
                        //                         fontWeight: FontWeight.bold,
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //             SizedBox(width: 5),
                        //           ],
                        //         ),
                        //         contentPadding: EdgeInsets.only(left: 5, top: 13),
                        //         fillColor: Color(0xffF8F8F8),
                        //         filled: true,
                        //         border: OutlineInputBorder(
                        //           borderSide: BorderSide.none,
                        //           borderRadius: BorderRadius.circular(25.0),
                        //         ),
                        //         enabledBorder: OutlineInputBorder(
                        //           borderSide: BorderSide.none,
                        //           borderRadius: BorderRadius.circular(25.0),
                        //         ),
                        //         errorBorder: OutlineInputBorder(
                        //           borderSide: BorderSide.none,
                        //           borderRadius: BorderRadius.circular(25),
                        //         ),
                        //         focusedBorder: OutlineInputBorder(
                        //           borderSide: BorderSide.none,
                        //           borderRadius: BorderRadius.circular(25.0),
                        //         ),
                        //         focusedErrorBorder: OutlineInputBorder(
                        //           borderSide: BorderSide.none,
                        //           borderRadius: BorderRadius.circular(25.0),
                        //         ),
                        //       ),
                        //     ),
                        // TextFormField(
                        //   controller: _phoneNumberController,
                        //   validator: (value) {
                        //     if (value!.length != 8) {
                        //       return "Enter 8 digits phone number";
                        //     }
                        //     return null;
                        //   },
                        //   keyboardType: TextInputType.phone,
                        //   inputFormatters: [
                        //     LengthLimitingTextInputFormatter(8),
                        //     FilteringTextInputFormatter.digitsOnly,
                        //     FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        //   ],
                        //   decoration: InputDecoration(
                        //     prefixIcon: Padding(
                        //       padding: const EdgeInsets.symmetric(
                        //           vertical: 13,
                        //           horizontal: 6), // Reduced padding
                        //       child: Text(
                        //         "+65",
                        //         style: primaryfont.copyWith(
                        //           fontSize: 15.sp, // Reduced font size
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //     fillColor: AppColors.kwhite,
                        //     filled: true,
                        //     contentPadding: const EdgeInsets.symmetric(
                        //         vertical: 8, horizontal: 6), // Reduced padding
                        //     hintText: "Enter Sender Number",
                        //     hintStyle: primaryfont.copyWith(
                        //       color: Colors.grey,
                        //       fontSize: 14, // Reduced font size
                        //       fontWeight: FontWeight.w100,
                        //     ),
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //         color: Color(0xff444444),
                        //       ),
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //     focusedErrorBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //         color: Color(0xff444444),
                        //       ),
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //     errorBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //         color: Color(0xff444444),
                        //       ),
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //   ),
                        // ),
                        ksizedbox20,
                        InkWell(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                if (_senderNameController.text.isNotEmpty &&
                                    _phoneNumberController.text.isNotEmpty) {
                                  homeController.updatepickupLocation(
                                      searchController.text,
                                      _markers.first.position.latitude
                                          .toString(),
                                      _markers.first.position.longitude
                                          .toString(),
                                      _senderNameController.text,
                                      _phoneNumberController.text,
                                      _blockUnitController.text);

                                  Get.offAll(PackageSendScreen(
                                    unitIdBlockID: _blockUnitController.text,
                                    pickupAdress: searchController.text,
                                    lat: _markers.first.position.latitude
                                        .toString(),
                                    long: _markers.first.position.longitude
                                        .toString(),
                                    sendername: _senderNameController.text,
                                    mobilenumber: _phoneNumberController.text,
                                  ));
                                } else {
                                  Get.snackbar(
                                      "Fill all Fields", "Please try again!",
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
              );
            },
          ),
        );
      },
    );
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
                          GestureDetector(
                            onTap: _showFullScreenAddressInput,
                            child: Container(
                              height: 45.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(
                                    width: 1, color: Color(0xff444444)),
                              ),
                              child: TextFormField(
                                controller: searchController,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: 10, top: 7),
                                  isDense: true,
                                  // prefixIcon: Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: Image.asset(
                                  //     "assets/icons/google-maps.png",
                                  //   ),
                                  // ),
                                  hintText: 'Enter Your Address....',
                                  hintStyle: primaryfont.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  border: InputBorder.none,
                                  enabled: false,
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
                          GestureDetector(
                            onTap: _showFullScreenAddressInput,
                            child: Container(
                              height: 45,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: AppColors.kwhite,
                                  border: Border.all(
                                    color: Color(0xff444444),
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                  controller: _blockUnitController,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 10,
                                          bottom: 16),
                                      enabled: false,
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
                          GestureDetector(
                            onTap: _showFullScreenAddressInput,
                            child: Container(
                              height: 45,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: AppColors.kwhite,
                                  border: Border.all(
                                    color: Color(0xff444444),
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  controller: _senderNameController,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 10,
                                          bottom: 16),
                                      enabled: false,
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
                          GestureDetector(
                            onTap: _showFullScreenAddressInput,
                            child: TextFormField(
                              controller: _phoneNumberController,
                              validator: (value) {
                                if (value!.length < 8 || value.length > 8) {
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
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 5, top: 12),
                                  child: Text(
                                    "+65",
                                    style: primaryfont.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                fillColor: AppColors.kwhite,
                                filled: true,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(10, 4, 4, 4),
                                hintText: "Enter Mobile Number",
                                hintStyle: primaryfont.copyWith(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w100),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff444444),
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xff444444),
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff444444)),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                          ksizedbox20,
                          InkWell(
                              onTap: () {
                                if (_senderNameController.text.isNotEmpty &&
                                    _phoneNumberController.text.isNotEmpty) {
                                  homeController.updatepickupLocation(
                                      searchController.text,
                                      _markers.first.position.latitude
                                          .toString(),
                                      _markers.first.position.longitude
                                          .toString(),
                                      _senderNameController.text,
                                      _phoneNumberController.text,
                                      _blockUnitController.text);
                                  Get.to(PackageSendScreen(
                                    unitIdBlockID: _blockUnitController.text,
                                    pickupAdress: searchController.text,
                                    lat: _markers.first.position.latitude
                                        .toString(),
                                    long: _markers.first.position.longitude
                                        .toString(),
                                    sendername: _senderNameController.text,
                                    mobilenumber: _phoneNumberController.text,
                                  ));
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
