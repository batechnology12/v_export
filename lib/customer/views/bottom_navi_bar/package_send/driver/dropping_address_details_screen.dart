// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:get/get.dart';
// import 'package:get/get_navigation/src/snackbar/snackbar.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_places_flutter/google_places_flutter.dart';
// import 'package:google_places_flutter/model/prediction.dart';
// import 'package:v_export/constant/app_colors.dart';
// import 'package:v_export/constant/common_container.dart';
// import 'package:v_export/customer/controller/account_controller.dart';
// import 'package:v_export/customer/controller/home_controller.dart';
// import 'package:v_export/customer/views/bottom_navi_bar/package_send/package_send_screen.dart';
// import 'package:location/location.dart' as loc;
// import 'package:v_export/constant/app_colors.dart';
// import 'package:v_export/constant/app_font.dart';

// class DroppingAddressDetails extends StatefulWidget {
//   final int index;
//   const DroppingAddressDetails({super.key, required this.index});

//   @override
//   State<DroppingAddressDetails> createState() =>
//       _DroppingAddressDetailsScreenState();
// }

// class _DroppingAddressDetailsScreenState extends State<DroppingAddressDetails> {
//   AccountController accountController = Get.find<AccountController>();
//   HomeController homeController = Get.find<HomeController>();
//   GoogleMapController? _controller;
//   final Set<Marker> _markers = {};
//   loc.LocationData? _currentPosition;
//   static const CameraPosition _initialPosition = CameraPosition(
//     target: LatLng(37.7749, -122.4194), // San Francisco
//     zoom: 12,
//   );
//   String fullAddress = "";
//   String areapincode = "";
//   String doorno = "";
//   List<Placemark> placemarks = [];

//   // final TextEditingController _addressController = TextEditingController();
//   final TextEditingController receiverNameController = TextEditingController();
//   final TextEditingController receiverNumberController =
//       TextEditingController();
//   final TextEditingController receiverBlockIdUnitIdController =
//       TextEditingController();
//   final TextEditingController searchedController = TextEditingController();

//   bool _isManualSelection = false;

//   @override
//   void initState() {
//     super.initState();
//   }

//   Future<void> _fetchAddress() async {
//     if (_currentPosition != null) {
//       try {
//         List<Placemark> placemarks = await placemarkFromCoordinates(
//             _currentPosition!.latitude!, _currentPosition!.longitude!);
//         Placemark place = placemarks[0];
//         setState(() {
//           searchedController.text =
//               "${place.name},${place.subLocality},${place.locality},${place.postalCode}" ??
//                   '';
//           //    _blockUnitController.text = place.name ?? place.name!;
//           print("=============address");
//           print(searchedController.text =
//               "${place.name},${place.subLocality},${place.locality},${place.postalCode}" ??
//                   '');
//         });
//       } catch (e) {
//         print(e);
//       }
//     }
//   }

//   void _showFullScreenAddressInput() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.only(top: 50),
//           child: DraggableScrollableSheet(
//             initialChildSize: 1.0,
//             minChildSize: 1.0,
//             maxChildSize: 1.0,
//             builder: (BuildContext context, ScrollController scrollController) {
//               return Container(
//                 decoration: const BoxDecoration(
//                   color: Color(0xffF4F8FF),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
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
//                         height: 45.h,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colors.white,
//                         ),
//                         child: GooglePlaceAutoCompleteTextField(
//                           textEditingController: searchedController,
//                           googleAPIKey:
//                               "AIzaSyAyygarjlqp_t2SPo7vS1oXDq1Yxs-LLNg",
//                           inputDecoration: InputDecoration(
//                               isDense: true,
//                               prefixIcon: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Image.asset(
//                                   "assets/icons/google-maps.png",
//                                 ),
//                               ),
//                               hintText: 'Enter Your Address....',
//                               hintStyle: primaryfont.copyWith(
//                                   fontSize: 14, fontWeight: FontWeight.w500),
//                               border: InputBorder.none),
//                           focusNode: FocusNode(),
//                           debounceTime: 600,
//                           isLatLngRequired: true,
//                           getPlaceDetailWithLatLng: (Prediction prediction) {
//                             if (_controller != null) {
//                               _controller!
//                                   .animateCamera(CameraUpdate.newCameraPosition(
//                                 CameraPosition(
//                                   target: LatLng(double.parse(prediction.lat!),
//                                       double.parse(prediction.lng!)),
//                                   zoom: 14.0,
//                                 ),
//                               ));
//                             }

//                             setState(() {
//                               _markers.add(Marker(
//                                 markerId: MarkerId(prediction.placeId!),
//                                 position: LatLng(double.parse(prediction.lat!),
//                                     double.parse(prediction.lng!)),
//                                 infoWindow:
//                                     InfoWindow(title: prediction.description!),
//                               ));
//                             });
//                           },
//                           itemClick: (Prediction prediction) {
//                             setState(() {
//                               searchedController.text = prediction.description!;
//                               searchedController.selection =
//                                   TextSelection.fromPosition(TextPosition(
//                                       offset: prediction.description!.length));
//                             });
//                           },
//                         ),
//                       ),
//                       ksizedbox20,
//                       Text(
//                         "Enter Block no / Unit no",
//                         style: primaryfont.copyWith(
//                             fontSize: 17,
//                             color: Colors.black,
//                             fontWeight: FontWeight.w600),
//                       ),
//                       ksizedbox5,
//                       Container(
//                         height: 45,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color: AppColors.kwhite,
//                         ),
//                         child: TextFormField(
//                             controller: receiverBlockIdUnitIdController,
//                             decoration: InputDecoration(
//                                 hintText: 'Enter Block no / Unit no',
//                                 hintStyle: primaryfont.copyWith(
//                                     fontSize: 14, fontWeight: FontWeight.w500),
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
//                         "Receiver Name",
//                         style: primaryfont.copyWith(
//                             fontSize: 17,
//                             color: Colors.black,
//                             fontWeight: FontWeight.w600),
//                       ),
//                       ksizedbox5,
//                       Container(
//                         height: 45,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color: AppColors.kwhite,
//                         ),
//                         child: TextFormField(
//                           maxLines: 1,
//                           minLines: 1,
//                           controller: receiverNameController,
//                           textCapitalization: TextCapitalization.sentences,
//                           decoration: InputDecoration(
//                             hintText: 'Enter receiver name',
//                             hintStyle: primaryfont.copyWith(
//                                 fontSize: 14, fontWeight: FontWeight.w500),
//                             contentPadding:
//                                 const EdgeInsets.symmetric(horizontal: 10),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: const BorderSide(
//                                 width: 1,
//                                 color: Color(0xff444444),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       ksizedbox20,
//                       Text(
//                         "Receiver Number",
//                         style: primaryfont.copyWith(
//                             fontSize: 17,
//                             color: Colors.black,
//                             fontWeight: FontWeight.w600),
//                       ),
//                       ksizedbox5,
//                       Container(
//                         height: 45,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color: AppColors.kwhite,
//                         ),
//                         child: TextFormField(
//                           maxLines: 1,
//                           minLines: 1,
//                           controller: receiverNumberController,
//                           keyboardType: TextInputType.number,
//                           inputFormatters: [
//                             FilteringTextInputFormatter.digitsOnly,
//                             LengthLimitingTextInputFormatter(8),
//                           ],
//                           decoration: InputDecoration(
//                             hintText: 'Enter receiver name',
//                             hintStyle: primaryfont.copyWith(
//                                 fontSize: 14, fontWeight: FontWeight.w500),
//                             contentPadding:
//                                 const EdgeInsets.symmetric(horizontal: 10),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10),
//                               borderSide: const BorderSide(
//                                 width: 1,
//                                 color: Color(0xff444444),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       ksizedbox20,
//                       InkWell(
//                         onTap: () {
//                           _fetchAddress();
//                           homeController.updateDroppingLocation(
//                             searchedController.text,
//                             _markers.first.position.latitude.toString(),
//                             _markers.first.position.longitude.toString(),
//                             areapincode,
//                             doorno,
//                             widget.index,
//                             receiverNameController.text,
//                             receiverNumberController.text,
//                             receiverBlockIdUnitIdController.text,
//                           );
//                           Get.back();
//                         },
//                         child: CommonContainer(
//                           name: 'Confirm',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: AppColors.kblue,
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         backgroundColor: AppColors.kblue,
//         centerTitle: true,
//         leading: GestureDetector(
//           onTap: () {
//             Get.back();
//           },
//           child: const Icon(
//             Icons.arrow_back_ios_new_sharp,
//             color: AppColors.kwhite,
//           ),
//         ),
//         title: Text(
//           'Dropping Address Details',
//           style: primaryfont.copyWith(
//               fontSize: 20.sp,
//               color: AppColors.kwhite,
//               fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: Stack(
//         children: <Widget>[
//           ClipRRect(
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//             ),
//             child: Container(
//               height: size.height,
//               width: size.width,
//               child: GoogleMap(
//                 initialCameraPosition: _initialPosition,
//                 markers: _markers,
//                 // myLocationEnabled: true,
//                 onMapCreated: (GoogleMapController controller) {
//                   _controller = controller;
//                 },
//               ),
//             ),
//           ),
//           DraggableScrollableSheet(
//             initialChildSize: 0.3,
//             minChildSize: 0.3,
//             maxChildSize: 1.0,
//             builder: (BuildContext context, ScrollController scrollController) {
//               return Container(
//                 decoration: const BoxDecoration(
//                   color: Color(0xffF4F8FF),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 5),
//                     Container(
//                       height: 5,
//                       width: 100,
//                       decoration: BoxDecoration(
//                           color: Colors.grey,
//                           borderRadius: BorderRadius.circular(5)),
//                     ),
//                     Expanded(
//                         child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: ListView(
//                         physics: AlwaysScrollableScrollPhysics(),
//                         controller: scrollController,
//                         children: [
//                           ksizedbox20,
//                           Text(
//                             "Enter Address",
//                             style: primaryfont.copyWith(
//                                 fontSize: 17,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                           ksizedbox5,
//                           GestureDetector(
//                             onTap: _showFullScreenAddressInput,
//                             child:
//                              Container(
                            
//                               height: 45.h,
//                               width: size.width,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.white,
//                               ),
//                               child: GooglePlaceAutoCompleteTextField(
//                                 textEditingController: searchedController,
//                                 googleAPIKey:
//                                     "AIzaSyAyygarjlqp_t2SPo7vS1oXDq1Yxs-LLNg",
//                                 inputDecoration: InputDecoration(
//                                     isDense: true,
//                                     prefixIcon: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Image.asset(
//                                         "assets/icons/google-maps.png",
//                                       ),
//                                     ),
//                                     hintText: 'Enter Your Address....',
//                                     hintStyle: primaryfont.copyWith(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500),
//                                     border: InputBorder.none),
//                                 focusNode: FocusNode(),
//                                 debounceTime: 600,
//                                 isLatLngRequired: true,
//                                 getPlaceDetailWithLatLng:
//                                     (Prediction prediction) {
//                                   if (_controller != null) {
//                                     _controller!.animateCamera(
//                                         CameraUpdate.newCameraPosition(
//                                       CameraPosition(
//                                         target: LatLng(
//                                             double.parse(prediction.lat!),
//                                             double.parse(prediction.lng!)),
//                                         zoom: 14.0,
//                                       ),
//                                     ));
//                                   }

//                                   setState(() {
//                                     _markers.add(Marker(
//                                       markerId: MarkerId(prediction.placeId!),
//                                       position: LatLng(
//                                           double.parse(prediction.lat!),
//                                           double.parse(prediction.lng!)),
//                                       infoWindow: InfoWindow(
//                                           title: prediction.description!),
//                                     ));
//                                   });
//                                 },
//                                 itemClick: (Prediction prediction) {
//                                   setState(() {
//                                     searchedController.text =
//                                         prediction.description!;
//                                     searchedController.selection =
//                                         TextSelection.fromPosition(TextPosition(
//                                             offset: prediction
//                                                 .description!.length));
//                                   });
//                                 },
//                               ),
//                             ),
//                           ),
//                           ksizedbox20,
//                           Text(
//                             "Enter Block no / Unit no",
//                             style: primaryfont.copyWith(
//                                 fontSize: 17,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                           ksizedbox5,
//                           Container(
//                             height: 45,
//                             width: size.width,
//                             decoration: BoxDecoration(
//                               color: AppColors.kwhite,
//                             ),
//                             child: TextFormField(
//                                 controller: receiverBlockIdUnitIdController,
//                                 decoration: InputDecoration(
//                                     hintText: 'Enter Block no / Unit no',
//                                     hintStyle: primaryfont.copyWith(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500),
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                       borderSide: BorderSide(
//                                         width: 1,
//                                         color: Color(0xff444444),
//                                       ),
//                                     ))),
//                           ),
//                           ksizedbox20,
//                           Text(
//                             "Receiver Name",
//                             style: primaryfont.copyWith(
//                                 fontSize: 17,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                           ksizedbox5,
//                           Container(
//                             height: 45,
//                             width: size.width,
//                             decoration: BoxDecoration(
//                               color: AppColors.kwhite,
//                             ),
//                             child: TextFormField(
//                               maxLines: 1,
//                               minLines: 1,
//                               controller: receiverNameController,
//                               textCapitalization: TextCapitalization.sentences,
//                               decoration: InputDecoration(
//                                 hintText: 'Enter receiver name',
//                                 hintStyle: primaryfont.copyWith(
//                                     fontSize: 14, fontWeight: FontWeight.w500),
//                                 contentPadding:
//                                     const EdgeInsets.symmetric(horizontal: 10),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: const BorderSide(
//                                     width: 1,
//                                     color: Color(0xff444444),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           ksizedbox20,
//                           Text(
//                             "Receiver Number",
//                             style: primaryfont.copyWith(
//                                 fontSize: 17,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                           ksizedbox5,
//                           Container(
//                             height: 45,
//                             width: size.width,
//                             decoration: BoxDecoration(
//                               color: AppColors.kwhite,
//                             ),
//                             child: TextFormField(
//                               maxLines: 1,
//                               minLines: 1,
//                               controller: receiverNumberController,
//                               keyboardType: TextInputType.number,
//                               inputFormatters: [
//                                 FilteringTextInputFormatter.digitsOnly,
//                                 LengthLimitingTextInputFormatter(8),
//                               ],
//                               decoration: InputDecoration(
//                                 hintText: 'Enter receiver name',
//                                 hintStyle: primaryfont.copyWith(
//                                     fontSize: 14, fontWeight: FontWeight.w500),
//                                 contentPadding:
//                                     const EdgeInsets.symmetric(horizontal: 10),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: const BorderSide(
//                                     width: 1,
//                                     color: Color(0xff444444),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           ksizedbox20,
//                           InkWell(
//                             onTap: () {
//                               _fetchAddress();
//                               homeController.updateDroppingLocation(
//                                 searchedController.text,
//                                 _markers.first.position.latitude.toString(),
//                                 _markers.first.position.longitude.toString(),
//                                 areapincode,
//                                 doorno,
//                                 widget.index,
//                                 receiverNameController.text,
//                                 receiverNumberController.text,
//                                 receiverBlockIdUnitIdController.text,
//                               );
//                               Get.back();
//                             },
//                             child: CommonContainer(
//                               name: 'Confirm',
//                             ),
//                           ),
//                         ],
//                       ),
//                     )),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
