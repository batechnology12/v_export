import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/constant/common_container.dart';
import 'package:v_export/customer/controller/account_controller.dart';
import 'package:v_export/customer/controller/home_controller.dart';
import 'package:location/location.dart' as loc;
import 'package:v_export/customer/views/bottom_navi_bar/package_send/package_send_screen.dart';

class DropLocation extends StatefulWidget {
  final int index;
  DropLocation({super.key, required this.index});

  @override
  State<DropLocation> createState() => _DropLocationState();
}

class _DropLocationState extends State<DropLocation> {
  AccountController accountController = Get.put(AccountController());
  HomeController homeController = Get.put(HomeController());
  GoogleMapController? _controller;
  final Set<Marker> _markers = {};
  loc.LocationData? _currentPosition;
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.7749, -122.4194), // San Francisco
    zoom: 12,
  );
  String fullAddress = "";
  String areapincode = "";
  String doorno = "";
  String dropingpickuppincode = "";
  List<Placemark> placemarks = [];

  // final TextEditingController _addressController = TextEditingController();
  final TextEditingController receiverNameController = TextEditingController();
  final TextEditingController receiverNumberController =
      TextEditingController();
  final TextEditingController receiverBlockIdUnitIdController =
      TextEditingController();

  final TextEditingController unitIdController = TextEditingController();

  final TextEditingController _searchedController = TextEditingController();
  // List<String> dropPostalCode = [];
  String dropPostalCode = "";
  bool _isManualSelection = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _fetchAddress() async {
    if (_currentPosition != null) {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            _currentPosition!.latitude!, _currentPosition!.longitude!);
        Placemark place = placemarks[0];
        setState(() {
          _searchedController.text =
              "${place.name},${place.subLocality},${place.locality},${place.postalCode}" ??
                  '';
          //  dropPostalCode.add(place.postalCode!);
          dropPostalCode = "${place.postalCode}";
          print("dropping postal code-----------------------");
          print(dropPostalCode);
          print("=============address");
          print(_searchedController.text =
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

  void _showFullScreenAddressDetailsInput() {
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
                          //   margin: EdgeInsets.only(left: 20),
                          height: 47.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: GooglePlaceAutoCompleteTextField(
                            textEditingController: _searchedController,
                            googleAPIKey:
                                "AIzaSyAyygarjlqp_t2SPo7vS1oXDq1Yxs-LLNg",
                            inputDecoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10),
                                isDense: true,
                                // prefixIcon: Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Image.asset(
                                //     "assets/icons/google-maps.png",
                                //   ),
                                // ),
                                hintText: 'Enter Your Address....',
                                hintStyle: primaryfont.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                                border: InputBorder.none),
                            focusNode: FocusNode(),
                            debounceTime: 600,
                            isLatLngRequired: true,
                            getPlaceDetailWithLatLng: (Prediction prediction) {
                              // Extract pincode using a regular expression

                              RegExp regExp = RegExp(
                                  r'\b\d{6}\b'); // Pattern to match 6-digit pincode
                              Match? match =
                                  regExp.firstMatch(prediction.description!);

                              if (match != null) {
                                dropingpickuppincode =
                                    match.group(0)!; // Store the pincode
                              }

                              print(
                                  'Extracted Pincode: $dropingpickuppincode'); // Debugging line to check pincode
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
                              setState(() {
                                _searchedController.text =
                                    prediction.description!;
                                _searchedController.selection =
                                    TextSelection.fromPosition(TextPosition(
                                        offset:
                                            prediction.description!.length));
                              });
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
                                GestureDetector(
                                  child: Container(
                                    height: 47,
                                    width: 150.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.kwhite,
                                    ),
                                    child: TextFormField(
                                        controller:
                                            receiverBlockIdUnitIdController,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(4),
                                          // FilteringTextInputFormatter
                                          //     .digitsOnly,
                                        ],
                                        keyboardType: TextInputType.text,
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
                                GestureDetector(
                                  child: Container(
                                    height: 47,
                                    width: 150.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.kwhite,
                                    ),
                                    child: TextFormField(
                                        controller: unitIdController,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(4),
                                          // FilteringTextInputFormatter
                                          //     .digitsOnly,
                                        ],
                                        keyboardType: TextInputType.text,
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
                                ),
                              ],
                            ),
                          ],
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
                          height: 47,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.kwhite,
                          ),
                          child: TextFormField(
                            maxLines: 1,
                            minLines: 1,
                            controller: receiverNameController,
                            textCapitalization: TextCapitalization.sentences,
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
                        Text(
                          "Receiver Number",
                          style: primaryfont.copyWith(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        ksizedbox5,
                        TextFormField(
                          controller: receiverNumberController,
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
                            contentPadding: EdgeInsets.all(10),
                            prefixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(width: 10),
                                Container(
                                  // height: 30,
                                  // width: 50,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "+65",
                                    style: primaryfont.copyWith(
                                      fontSize: 14.sp, // Adjust font size
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                              ],
                            ),
                            fillColor: AppColors.kwhite,
                            filled: true,
                            hintText: 'Enter Phone Name',
                            hintStyle: primaryfont.copyWith(
                                fontSize: 14.sp, fontWeight: FontWeight.w500),
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
                        // TextFormField(
                        //   controller: receiverNumberController,
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
                        //     contentPadding: EdgeInsets.only(top: 13),
                        //     prefixIcon: Row(
                        //       mainAxisSize: MainAxisSize.min,
                        //       children: [
                        //         Container(
                        //           height: 30,
                        //           width: 50,
                        //           alignment: Alignment.center,
                        //           child: Text(
                        //             "+65",
                        //             style: primaryfont.copyWith(
                        //               fontSize: 14, // Adjust font size
                        //               fontWeight: FontWeight.bold,
                        //             ),
                        //           ),
                        //         ),
                        //         SizedBox(width: 5),
                        //       ],
                        //     ),
                        //     fillColor: AppColors.kwhite,
                        //     filled: true,
                        //     hintText: 'Enter Phone Name',
                        //     hintStyle: primaryfont.copyWith(
                        //         fontSize: 14, fontWeight: FontWeight.w500),
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
                              if (receiverNameController.text.isNotEmpty &&
                                  receiverNumberController.text.isNotEmpty) {
                                _fetchAddress();

                               

                                homeController.updateDroppingLocation(
                                  _searchedController.text,
                                  _markers.first.position.latitude.toString(),
                                  _markers.first.position.longitude.toString(),
                                  areapincode,
                                  doorno,
                                  widget.index,
                                  receiverNameController.text,
                                  receiverNumberController.text,
                                  receiverBlockIdUnitIdController.text,
                                  unitIdController.text,
                                  dropingpickuppincode,
                                );
                                // Get.back();
                                Get.offAll(PackageSendScreen(
                                  unitId: homeController.pickupunitsId.value,
                                  pickupAdress:
                                      homeController.pickupLocation.value,
                                  lat: homeController.pickuplatitude.value,
                                  long: homeController.pickuplongitude.value,
                                  unitIdBlockID:
                                      homeController.pickupblockUnitId.value,
                                  sendername:
                                      homeController.pickupSenderName.value,
                                  mobilenumber:
                                      homeController.pickupSenderNumber.value,
                                  pickUpPostalCode:
                                      homeController.pickupPostalCode.value,
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
                          ),
                        ),
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
          'Dropping Address Details',
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
                // myLocationEnabled: true,
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
                            onTap: _showFullScreenAddressDetailsInput,
                            child: Container(
                              height: 47.h,
                              width: size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: GooglePlaceAutoCompleteTextField(
                                textEditingController: _searchedController,
                                googleAPIKey:
                                    "AIzaSyAyygarjlqp_t2SPo7vS1oXDq1Yxs-LLNg",
                                inputDecoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10),
                                  isDense: true,
                                  enabled: false,
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
                                  // border: OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(10),
                                  //   borderSide: BorderSide(
                                  //     width: 1,
                                  //     color: Colors.black,
                                  //   ),
                                  // )
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
                                },
                                itemClick: (Prediction prediction) {
                                  setState(() {
                                    _searchedController.text =
                                        prediction.description!;
                                    _searchedController.selection =
                                        TextSelection.fromPosition(TextPosition(
                                            offset: prediction
                                                .description!.length));
                                  });
                                },
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
                            onTap: _showFullScreenAddressDetailsInput,
                            child: Container(
                              height: 47,
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: AppColors.kwhite,
                                  border: Border.all(
                                    color: Color(0xff444444),
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(4),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  keyboardType: TextInputType.phone,
                                  controller: receiverBlockIdUnitIdController,
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
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                      border: InputBorder.none)),
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
                          GestureDetector(
                            onTap: _showFullScreenAddressDetailsInput,
                            child: Container(
                              height: 47,
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: AppColors.kwhite,
                                  border: Border.all(
                                    color: Color(0xff444444),
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                maxLines: 1,
                                minLines: 1,
                                controller: receiverNameController,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: InputDecoration(
                                    enabled: false,
                                    hintText: 'Enter receiver name',
                                    hintStyle: primaryfont.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                    contentPadding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom: 16),
                                    border: InputBorder.none
                                    // OutlineInputBorder(
                                    //   borderRadius: BorderRadius.circular(10),
                                    //   borderSide: const BorderSide(
                                    //     width: 1,
                                    //     color: Color(0xff444444),
                                    //   ),
                                    // ),
                                    ),
                              ),
                            ),
                          ),
                          ksizedbox20,
                          Text(
                            "Receiver Number",
                            style: primaryfont.copyWith(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          ksizedbox5,
                          GestureDetector(
                            onTap: _showFullScreenAddressDetailsInput,
                            child: TextFormField(
                              controller: receiverNumberController,
                              validator: (value) {
                                if (value!.length < 8 || value.length > 8) {
                                  return "Enter 8 digits phone number";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.phone,
                              enabled: false,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(8),
                                FilteringTextInputFormatter.digitsOnly,
                                FilteringTextInputFormatter.deny(RegExp(r'\s')),
                              ],
                              decoration: InputDecoration(
                                prefixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(width: 10),
                                    Container(
                                      // height: 30,
                                      // width: 50,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "+65",
                                        style: primaryfont.copyWith(
                                          fontSize: 14.sp, // Adjust font size
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                                fillColor: AppColors.kwhite,
                                filled: true,
                                contentPadding: const EdgeInsets.all(10),
                                hintText: "Enter Receiver Number",
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
                          // GestureDetector(
                          //   onTap: _showFullScreenAddressDetailsInput,
                          //   child: TextFormField(
                          //     controller: receiverNumberController,
                          //     validator: (value) {
                          //       if (value!.length < 8 || value.length > 8) {
                          //         return "Enter 8 digits phone number";
                          //       }
                          //       return null;
                          //     },
                          //     keyboardType: TextInputType.phone,
                          //     inputFormatters: [
                          //       LengthLimitingTextInputFormatter(8),
                          //       FilteringTextInputFormatter.digitsOnly,
                          //       FilteringTextInputFormatter.deny(RegExp(r'\s')),
                          //     ],
                          //     decoration: InputDecoration(
                          //       prefixIcon: Padding(
                          //         padding: const EdgeInsets.only(
                          //             left: 10, right: 5, top: 12),
                          //         child: Text(
                          //           "+65",
                          //           style: primaryfont.copyWith(
                          //             fontSize: 15,
                          //             fontWeight: FontWeight.w500,
                          //           ),
                          //         ),
                          //       ),
                          //       fillColor: AppColors.kwhite,
                          //       filled: true,
                          //       contentPadding:
                          //           const EdgeInsets.fromLTRB(10, 4, 4, 4),
                          //       hintText: "Enter Receiver Number",
                          //       hintStyle: primaryfont.copyWith(
                          //           color: Colors.grey,
                          //           fontSize: 15,
                          //           fontWeight: FontWeight.w100),
                          //       border: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(10),
                          //       ),
                          //       focusedBorder: OutlineInputBorder(
                          //           borderSide: BorderSide(
                          //             color: Color(0xff444444),
                          //           ),
                          //           borderRadius: BorderRadius.circular(10)),
                          //       focusedErrorBorder: OutlineInputBorder(
                          //           borderSide: BorderSide(
                          //             color: Color(0xff444444),
                          //           ),
                          //           borderRadius: BorderRadius.circular(10)),
                          //       errorBorder: OutlineInputBorder(
                          //           borderSide:
                          //               BorderSide(color: Color(0xff444444)),
                          //           borderRadius: BorderRadius.circular(10)),
                          //     ),
                          //   ),
                          // ),
                          ksizedbox20,
                          InkWell(
                            onTap: () {
                              //  if (formKey.currentState!.validate()) {
                              if (receiverNameController.text.isNotEmpty &&
                                  receiverNumberController.text.isNotEmpty) {
                                homeController.updateDroppingLocation(
                                    _searchedController.text,
                                    _markers.first.position.latitude.toString(),
                                    _markers.first.position.longitude
                                        .toString(),
                                    areapincode,
                                    doorno,
                                    widget.index,
                                    receiverNameController.text,
                                    receiverNumberController.text,
                                    receiverBlockIdUnitIdController.text,
                                    unitIdController.text,
                                    dropingpickuppincode);
                                // Get.back();
                                Get.offAll(PackageSendScreen(
                                    pickUpPostalCode:
                                        homeController.pickupPostalCode.value,
                                    unitId: unitIdController.text,
                                    pickupAdress:
                                        homeController.pickupLocation.value,
                                    lat: homeController.pickuplatitude.value,
                                    long: homeController.pickuplongitude.value,
                                    unitIdBlockID:
                                        homeController.pickupblockUnitId.value,
                                    sendername:
                                        homeController.pickupSenderName.value,
                                    mobilenumber: homeController
                                        .pickupSenderNumber.value));
                              } else {
                                Get.snackbar(
                                    "Fill all Fields", "Please try again!",
                                    colorText: AppColors.kwhite,
                                    backgroundColor: Colors.red,
                                    snackPosition: SnackPosition.BOTTOM);
                              }
                              // }
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
