import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/common_container.dart';
import 'package:v_export/customer/controller/home_controller.dart';
import 'package:v_export/customer/controller/parcel_controller.dart';
import 'package:v_export/customer/model/delivery_type_model.dart';
import 'package:v_export/customer/views/bottom_navi_bar/bottomn_navi_bar.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/droping_address_details.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/droping_address_details.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/dropping_address_details_screen.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/pickup_address_details.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/schedule_delivery.dart';
import 'package:intl/intl.dart';

import '../../../../constant/app_colors.dart';
import '../../../../constant/app_font.dart';

class PackageSendScreen extends StatefulWidget {
  String pickupAdress;
  String lat;
  String long;
  String unitIdBlockID;
  String sendername;
   String unitId;
  String mobilenumber;

  PackageSendScreen(
      {super.key,
      required this.pickupAdress,
      required this.lat,
      required this.long,
      required this.unitIdBlockID,
      required this.sendername,
     required this.unitId,
      required this.mobilenumber});

  @override
  State<PackageSendScreen> createState() => _PackageSendScreenState();
}

class _PackageSendScreenState extends State<PackageSendScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await parcelController.getDeliveryTypes();
    await  parcelController.getAdditionalServices("booking_parcel");
      parcelController.update();
      setState(() {});
    });
  }

  final ParcelController parcelController = Get.find<ParcelController>();
  final HomeController homeController = Get.find<HomeController>();
  DateTime selectedDate = DateTime.now();
  // TimeOfDay pickTime = TimeOfDay.now();
  // TimeOfDay dropTime = TimeOfDay.now();
  double containerHeight = 100.0;

//  HomeController homeController = Get.find<HomeController>();
  var datebookingController = TextEditingController();
  var delivarytypeController = TextEditingController();
  // var parcellengthController = TextEditingController();
  // var parcelwidthController = TextEditingController();
  // var parcelheightController = TextEditingController();

  // var parcelkgController = TextEditingController();
  // var numberofparcelController = TextEditingController();
  var parcelitemController = TextEditingController();
  // var pickuptimeController = TextEditingController();
  // var droptimeController = TextEditingController();
  // var quantityController = TextEditingController();

  String formatDateTime = "";
  String pickingTime = "";
  String dropingTime = "";
  List<DeliveryTypeData> selectedDeliveryTypes = [];

  Future<Null> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        formatDateTime = formatDate(selectedDate, [dd, '-', mm, '-', yyyy]);
      });
  }

  var time;

  TimeOfDay? _updatedTime;
  TimeOfDay? updatedroptime2;
  TimeOfDay? updatedroptime3;
  TimeOfDay? pickTime;
  TimeOfDay? dropTime;

  // void _selectpickTime(BuildContext context) async {
  //   final TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: pickTime ?? TimeOfDay.now(),
  //   );

  //   if (picked != null) {

  //     setState(() {
  //       pickTime = picked;
  //       _updateDropTime();
  //     });
  //   }
  // }

  void _selectpickTime(BuildContext context) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: pickTime ?? TimeOfDay.now(),
  );

  if (picked != null) {
    final selectedDeliveryType = selectedDeliveryTypes.first.name;
    if (selectedDeliveryType == "Same day delivery") {
      // Convert TimeOfDay to DateTime to compare times
      final now = DateTime.now();
      final pickedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );

      final morning8am = DateTime(now.year, now.month, now.day, 8, 0);
      final afternoon4pm = DateTime(now.year, now.month, now.day, 16, 0);

      if (pickedDateTime.isBefore(morning8am) || pickedDateTime.isAfter(afternoon4pm)) {
        Get.snackbar(
          "Invalid time selection",
          "Please select a time between 8:00 AM and 4:00 PM",
          colorText: AppColors.kwhite,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
    }

    setState(() {
      pickTime = picked;
      _updateDropTime();
    });
  }
}


  void _selectdropTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: dropTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      final now = DateTime.now();
      final pickedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );

      if (selectedDeliveryTypes.first.name == "Specific Time") {
        final fourHoursLater = now.add(Duration(hours: 4));
        if (pickedDateTime.isBefore(fourHoursLater)) {
          Get.snackbar(
              "Please select a time at least 4 hours from current Time",
              "Please try again!",
              colorText: AppColors.kwhite,
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.BOTTOM);
          return;
        }
      }

      setState(() {
        dropTime = picked;
      });
    }
  }



  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final formattedTime = DateFormat('h:mma')
        .format(DateTime(
          now.year,
          now.month,
          now.day,
          time.hour,
          time.minute,
        ))
        .toLowerCase();
    return formattedTime;
  }

  TimeOfDay _addMinutes(TimeOfDay pickerTime, int minutes) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, pickerTime.hour, pickerTime.minute);
    final updatedDateTime = dateTime.add(Duration(minutes: minutes));
    return TimeOfDay(
        hour: updatedDateTime.hour, minute: updatedDateTime.minute);
  }



  void _updateDropTime() {
    if (selectedDeliveryTypes.isNotEmpty) {
      final selectedDeliveryType = selectedDeliveryTypes.first.name;
      if (selectedDeliveryType == "Express Delivery") {
        _updatedTime = _addMinutes(pickTime!, 120);
        dropTime = _updatedTime;
      } else if (selectedDeliveryType == "4 Hours Delivery") {
        updatedroptime2 = _addMinutes(pickTime!, 240);
        dropTime = updatedroptime2;
      } else if (selectedDeliveryType == "Same day delivery") {
       // pickTime =  TimeOfDay(hour: 8, minute: 0);
        dropTime = TimeOfDay(hour: 20, minute: 0);
      } else if (selectedDeliveryType == "Specific Time") {
        dropTime =
            null; 
      } else if (selectedDeliveryType == "Next day delivery") {
        pickTime = TimeOfDay(hour: 8, minute: 0);
        dropTime = TimeOfDay(hour: 21, minute: 0);
      }
      setState(() {});
    }
  }

  DeliveryTypeData? deliveryItems;

  // DeliveryTypeData? deliveryName;

  // DeliveryTypeData? deliveryItems;
  // String? deliveryName;
  // int? deliveryId;

  // List<String> deliveryItemsList = [
  //   "Express Delvery - 24/7 (1 Hour)",
  //   "4 Hours Delivery",
  //   "Specific Time",
  //   "Same Day Delivery",
  //   "Next Day Delivery"
  // ];

  bool checkParcelorMulti = false;
  bool hideDeleteButton = false;

  String _getLocationSuffix(int number) {
    if (number % 10 == 1 && number != 11) return "st";
    if (number % 10 == 2 && number != 12) return "nd";
    if (number % 10 == 3 && number != 13) return "rd";
    return "th";
  }

  final formKey = GlobalKey<FormState>();
  String formatTime(String time) {
    DateTime parsedTime = DateFormat("HH:mm:ss").parse(time);
    String formattedTime = DateFormat("h a").format(parsedTime);
    return formattedTime;
  }

  double totalWeight = 0.0;

  void updateTotalWeight() {
    setState(() {
      totalWeight = calculateTotalWeight();
    });
  }

  double calculateTotalWeight() {
    double totalWeight = 0.0;
    // for (var controller in homeController.parcelKgControllers) {
    //   double value = double.tryParse(controller.text) ?? 0.0;
    //   totalWeight += value;
    // }
    return totalWeight;
  }

  @override
  void dispose() {
    // for (var controller in homeController.parcelKgControllers) {
    //   controller.removeListener(updateTotalWeight);
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.kblue,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.to(BottomNavigationScreen());
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.arrow_back_ios_new_sharp,
              color: AppColors.kwhite,
            ),
          ),
        ),
        title: GestureDetector(
          onTap: () {},
          child: Text(
            'Parcel Booking',
            style: primaryfont.copyWith(
                fontSize: 21.sp,
                color: Color(0xffF4F8FF),
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Container(
          width: double.infinity,
          height: size.height,
          decoration: const BoxDecoration(
            color: AppColors.kblue,
            gradient: LinearGradient(
              colors: [
                AppColors.kblue,
                AppColors.kwhite,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  height: size.height,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Color(0xffF4F8FF),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 5,
                              right: 5,
                              top: 5,
                            ),
                            child: AnimatedContainer(
                              padding: const EdgeInsets.only(top: 10),
                              duration: const Duration(milliseconds: 300),
                              width: size.width,
                              decoration: BoxDecoration(
                                color: AppColors.kwhite,
                                boxShadow: const <BoxShadow>[
                                  BoxShadow(
                                      offset: Offset(0.0, 0.75),
                                      blurRadius: 1,
                                      color: AppColors.kgrey)
                                ],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Obx(
                                () => ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: homeController.entries.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        if (index == 0)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10, left: 10),
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.to(PickupAddressDetails());
                                              },
                                              child: Container(
                                                padding:
                                                    EdgeInsets.only(right: 5),
                                                height: 50.h,
                                                width: size.width,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey
                                                          .withOpacity(.32),
                                                      width: 1),
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.location_on,
                                                        color:
                                                            Color(0xffF74354)),
                                                    const VerticalDivider(
                                                      indent: 10,
                                                      thickness: 1,
                                                      width: 5,
                                                      color: Color(0xff455A64),
                                                      endIndent: 10,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                              PickupAddressDetails());
                                                        },
                                                        child: Container(
                                                          width: 250.w,
                                                          child: Text(
                                                            widget.pickupAdress,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: primaryfont
                                                                .copyWith(
                                                              fontSize: 13.sp,
                                                              color: Color(
                                                                  0xff455A64),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.to(
                                                  DropLocation(index: index));
                                            },
                                            child: Container(
                                              height: 50.h,
                                              width: size.width,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey
                                                        .withOpacity(.32),
                                                    width: 1),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.location_on,
                                                      color: Color(0xff038484)),
                                                  const VerticalDivider(
                                                    indent: 10,
                                                    thickness: 1,
                                                    width: 5,
                                                    color: Color(0xff455A64),
                                                    endIndent: 10,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Get.to(DropLocation(
                                                            index: index));
                                                      },
                                                      child:
                                                          Obx(() => Container(
                                                                width: 250.w,
                                                                child: Text(
                                                                  homeController
                                                                              .droppingLocations
                                                                              .length >
                                                                          index
                                                                      ? homeController
                                                                              .droppingLocations[
                                                                          index]
                                                                      : 'Enter Drop here...',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: primaryfont
                                                                      .copyWith(
                                                                    fontSize:
                                                                        13.sp,
                                                                    color: const Color(
                                                                        0xff455A64),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                // homeController
                                                //         .isRoundTripVisible.value
                                                //     ?
                                                MainAxisAlignment.spaceBetween,
                                            // : MainAxisAlignment.end,
                                            children: [
                                              if (homeController
                                                          .entries.length -
                                                      1 ==
                                                  index)
                                                // homeController
                                                //         .isRoundTripVisible.value
                                                //   ?
                                                Row(
                                                  children: [
                                                    Obx(() => Checkbox(
                                                          value: homeController
                                                              .isCheck.value,
                                                          onChanged: (value) {
                                                            homeController
                                                                .toggleCheck(
                                                                    value!);
                                                          },
                                                        )),
                                                    Text(
                                                      'Round Trip',
                                                      style:
                                                          primaryfont.copyWith(
                                                        fontSize: 17.sp,
                                                        color:
                                                            Color(0xff455A64),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    // Obx(
                                                    //   () => Text(
                                                    //     homeController
                                                    //         .roundTrip.value,
                                                    //     style: primaryfont
                                                    //         .copyWith(
                                                    //       fontSize: 17.sp,
                                                    //       color:
                                                    //           Color(0xff455A64),
                                                    //       fontWeight:
                                                    //           FontWeight.w500,
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              // : Container(),
                                              index ==
                                                      homeController
                                                              .entries.length -
                                                          1
                                                  ? Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        if (index != 0)
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              IconButton(
                                                                onPressed: () {
                                                                  homeController
                                                                      .removeEntry(
                                                                          index);
                                                                  homeController
                                                                      .removeParcelList(
                                                                          index);
                                                                  // homeController
                                                                  //     .deleteLocation(
                                                                  //         index);
                                                                  homeController
                                                                      .removeSecondContainer(
                                                                          index);
                                                                  // homeController
                                                                  //         .isCheckedParcel =
                                                                  //     true;
                                                                  hideDeleteButton =
                                                                      true;
                                                                },
                                                                icon: const Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                            ],
                                                          ),
                                                        Row(
                                                          children: [
                                                            // GestureDetector(
                                                            //   onTap: () {
                                                            //     homeController
                                                            //         .addEntry();
                                                            //     homeController
                                                            //         .addParcelList();
                                                            //     homeController
                                                            //         .addSecondContainer();
                                                            //   },
                                                            //   child: Icon(
                                                            //     Icons.add,
                                                            //     color: const Color(
                                                            //         0xff0072E8),
                                                            //     size: 17.sp,
                                                            //   ),
                                                            // ),
                                                            homeController
                                                                        .entries
                                                                        .length <
                                                                    20
                                                                ? GestureDetector(
                                                                    onTap: () {
                                                                      // homeController
                                                                      //     .addLocation();
                                                                      if (homeController
                                                                              .entries
                                                                              .length <
                                                                          10) {
                                                                        homeController
                                                                            .addEntry();
                                                                        homeController
                                                                            .addParcelList();
                                                                        homeController
                                                                            .addSecondContainer();
                                                                      } else {
                                                                        // Optionally show a message to the user that the limit has been reached
                                                                        print(
                                                                            'Cannot add more locations. The maximum limit is 10.');
                                                                      }
                                                                      // hideDeleteButton =
                                                                      //     false;
                                                                    },
                                                                    child: Text(
                                                                      '+Add Location',
                                                                      style: primaryfont
                                                                          .copyWith(
                                                                        fontSize:
                                                                            15.sp,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        color: const Color(
                                                                            0xff0072E8),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Container(),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          ksizedbox30,
                          Container(
                            width: size.width,
                            decoration: BoxDecoration(
                                color: AppColors.kwhite,
                                boxShadow: const <BoxShadow>[
                                  BoxShadow(
                                      offset: Offset(0.0, 0.75),
                                      blurRadius: 1.5,
                                      color: AppColors.kgrey)
                                ],
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 10, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Booking Date',
                                        style: primaryfont.copyWith(
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff000000)),
                                      ),
                                      Text(
                                        '*',
                                        style: primaryfont.copyWith(
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.red),
                                      ),
                                    ],
                                  ),
                                  ksizedbox10,
                                  GestureDetector(
                                    onTap: () {
                                      selectDate(context);
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        height: 50.h,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            width: 1,
                                            color: Color(0xff444444)
                                                .withOpacity(.32),
                                          ),
                                          color: AppColors.kwhite,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              formatDateTime.isEmpty
                                                  ? 'Select Date'
                                                  : formatDateTime,
                                              style: primaryfont.copyWith(
                                                  color: Color(0xff455A64),
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  selectDate(context);
                                                },
                                                child: Image.asset(
                                                    "assets/icons/date.png")),
                                          ],
                                        )),
                                  ),
                                  ksizedbox20,
                                  Row(
                                    children: [
                                      Text(
                                        'Select Delivery types',
                                        style: primaryfont.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff000000)),
                                      ),
                                      Text(
                                        '*',
                                        style: primaryfont.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.red),
                                      ),
                                    ],
                                  ),
                                  ksizedbox10,
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    height: 50,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color:
                                            Color(0xff444444).withOpacity(.32),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: DropdownButton<DeliveryTypeData>(
                                      hint: const Text(
                                        'Select Delivery Item',
                                        style: TextStyle(
                                          color: Color(0xff455A64),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      elevation: 16,
                                      isExpanded: true,
                                      style: TextStyle(
                                        color:
                                            Color(0xff444444).withOpacity(.32),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      underline: Container(),
                                      value: parcelController.deliveryTypesData.isEmpty ? null : deliveryItems,
                                      items: parcelController.deliveryTypesData
                                          .map((DeliveryTypeData type) {
                                        return DropdownMenuItem<
                                            DeliveryTypeData>(
                                          value: type,
                                          child: Text(
                                            type.name,
                                            style: TextStyle(
                                              color: Color(0xff455A64),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (DeliveryTypeData? newValue) {
                                        setState(() {
                                          deliveryItems = newValue;
                                          if (newValue != null) {
                                            selectedDeliveryTypes.clear();
                                            selectedDeliveryTypes.add(newValue);
                                            pickTime = TimeOfDay.now();
                                            _updateDropTime();
                                          }
                                          print(
                                              "-----------------------------eere---------------------------");
                                          print(selectedDeliveryTypes);
                                          // deliveryName = newValue!.id;
                                          pickTime = TimeOfDay.now();
                                          _updateDropTime();
                                        });
                                      },
                                    ),
                                  ),
                                  ksizedbox20,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Parcel Size ",
                                        style: primaryfont.copyWith(
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff000000)),
                                      ),
                                      Text(
                                        "(LxWxH CM)",
                                        style: primaryfont.copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.red,
                                        ),
                                      )
                                    ],
                                  ),
                                  ksizedbox5,
                                  Obx(() => ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: homeController
                                            .secondContainers.length,
                                        itemBuilder: (context, index) {
                                          return AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 300),
                                            padding: EdgeInsets.only(top: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ksizedbox5,
                                                if (homeController
                                                        .isCheckedLocation ==
                                                    true)
                                                  Text(
                                                    "${index + 1}${_getLocationSuffix(index + 1)} location",
                                                    style: primaryfont.copyWith(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: const Color(
                                                          0xff0072E8),
                                                    ),
                                                  ),

                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        height: 35,
                                                        width: 180,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          border: Border.all(
                                                              width: 1,
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.32)),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            _buildTextField(
                                                                homeController
                                                                        .parcelLengthControllers[
                                                                    index],
                                                                'L',
                                                                "cm"),
                                                            const Text(
                                                              "X",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            _buildTextField(
                                                                homeController
                                                                        .parcelWidthControllers[
                                                                    index],
                                                                'W',
                                                                "cm"),
                                                            const Text(
                                                              "X",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            _buildTextField(
                                                                homeController
                                                                        .parcelHeightControllers[
                                                                    index],
                                                                'H',
                                                                "cm"),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 35,
                                                        width: 65,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          border: Border.all(
                                                              width: 1,
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.32)),
                                                        ),
                                                        child: TextFormField(
                                                          controller: homeController
                                                                  .parcelKgControllers[
                                                              index],
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          cursorColor:
                                                              Colors.black,
                                                          style: TextStyle(
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.black,
                                                          ),
                                                          decoration:
                                                              InputDecoration(
                                                            suffixText: "Kg",
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    top: 5,
                                                                    left: 5,
                                                                    bottom: 10,
                                                                    right: 5),
                                                            hintText: "Kg",
                                                            hintStyle:
                                                                TextStyle(
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Color(
                                                                  0xff455A64),
                                                            ),
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 35,
                                                        width: 65,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          border: Border.all(
                                                              width: 1,
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.32)),
                                                        ),
                                                        //  width: 50,
                                                        child: TextFormField(
                                                          controller: homeController
                                                                  .quantityControllers[
                                                              index],
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          cursorColor:
                                                              Colors.black,
                                                          style: TextStyle(
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.black,
                                                          ),
                                                          decoration:
                                                              InputDecoration(
                                                            suffixText: "Qty",
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    top: 5,
                                                                    left: 5,
                                                                    bottom: 10,
                                                                    right: 5),
                                                            hintText: "Qty",
                                                            hintStyle:
                                                                TextStyle(
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Color(
                                                                  0xff455A64),
                                                            ),
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              
                                              ],
                                            ),
                                          );
                                        },
                                      )),
                                  ksizedbox10,
                                  Row(
                                    children: [
                                      Text(
                                        'Parcel Items',
                                        style: primaryfont.copyWith(
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff000000)),
                                      ),
                                      Text(
                                        '*',
                                        style: primaryfont.copyWith(
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.red),
                                      ),
                                    ],
                                  ),
                                  ksizedbox10,
                                  Container(
                                    height: 50.h,
                                    width: size.width,
                                    decoration:
                                        BoxDecoration(color: AppColors.kwhite),
                                    child: TextFormField(
                                      controller: parcelitemController,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.only(left: 10),
                                        hintText: 'Items',
                                        hintStyle: primaryfont.copyWith(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey.withOpacity(.32),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey.withOpacity(.32),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: const BorderSide(
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 1),
                                    child: Text(
                                      'ex. Food/parcel/medicine',
                                      style: primaryfont.copyWith(
                                          color: Color(0xff455A64),
                                          fontSize: 15.sp),
                                    ),
                                  ),
                                  ksizedbox20,
                                  Row(
                                    children: [
                                      Text(
                                        'Pickup Time',
                                        style: primaryfont.copyWith(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff455A64)),
                                      ),
                                      Text(
                                        '*',
                                        style: primaryfont.copyWith(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.red),
                                      ),
                                    ],
                                  ),
                                  ksizedbox20,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _selectpickTime(context);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(left: 15),
                                          height: 50.h,
                                          width: 160.w,
                                          decoration: BoxDecoration(
                                              color: AppColors.kwhite,
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.grey
                                                      .withOpacity(.32)),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                pickTime != null
                                                    ? _formatTime(pickTime!)
                                                    : 'select time',
                                                style: primaryfont.copyWith(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: const Color.fromARGB(
                                                        255, 2, 3, 3)),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    _selectpickTime(context);
                                                  },
                                                  icon: Image.asset(
                                                      "assets/icons/mylisticon.png",
                                                      color: Colors.grey))
                                            ],
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'To',
                                        style: primaryfont.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff000000)),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (selectedDeliveryTypes
                                                      .first.name ==
                                                  "Specific Time" ||
                                              (selectedDeliveryTypes
                                                          .first.name !=
                                                      "Same day delivery" &&
                                                  selectedDeliveryTypes
                                                          .first.name !=
                                                      "Next day delivery") ||
                                              selectedDeliveryTypes.isEmpty) {
                                            _selectdropTime(context);
                                          }
                                          // _selectdropTime(context);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(left: 15),
                                          height: 50.h,
                                          width: 160.w,
                                          decoration: BoxDecoration(
                                              color: AppColors.kwhite,
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.grey
                                                      .withOpacity(.32)),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                dropTime != null
                                                    ? _formatTime(dropTime!)
                                                    : 'select time',
                                                style: primaryfont.copyWith(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: const Color.fromARGB(
                                                        255, 2, 3, 3)),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    //  dropTimePicker(context);
                                                    //   _selectdropTime(context);
                                                    if (selectedDeliveryTypes
                                                                .first.name ==
                                                            "Specific Time" ||
                                                        (selectedDeliveryTypes
                                                                    .first
                                                                    .name !=
                                                                "Same day delivery" &&
                                                            selectedDeliveryTypes
                                                                    .first
                                                                    .name !=
                                                                "Next day delivery") ||
                                                        selectedDeliveryTypes
                                                            .isEmpty) {
                                                      _selectdropTime(context);
                                                    }
                                                  },
                                                  icon: Image.asset(
                                                    "assets/icons/mylisticon.png",
                                                    color: Colors.grey,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ksizedbox20,
                                  ksizedbox10,
                                ],
                              ),
                            ),
                          ),
                          ksizedbox10,
                          ksizedbox20,
                          InkWell(
                              onTap: () {
                                List<String> droppingAddressList =
                                    homeController.droppingLocations.toList();
                                if (widget.pickupAdress.isNotEmpty &&
                                    widget.lat.isNotEmpty &&
                                    widget.long.isNotEmpty &&
                                    homeController.droppingLats.isNotEmpty &&
                                    homeController.dropLongs.isNotEmpty &&
                                    _formatTime(pickTime!).isNotEmpty &&
                                    _formatTime(dropTime!).isNotEmpty &&
                                    formatDateTime.isNotEmpty &&
                                    selectedDeliveryTypes.first.id
                                        .toString()
                                        .isNotEmpty &&
                                    homeController
                                        .parcelLengthControllers.isNotEmpty &&
                                    homeController
                                        .parcelWidthControllers.isNotEmpty &&
                                    homeController
                                        .parcelHeightControllers.isNotEmpty &&
                                    homeController
                                        .quantityControllers.isNotEmpty &&
                                    homeController
                                        .parcelKgControllers.isNotEmpty &&
                                    parcelitemController.text.isNotEmpty &&
                                    widget.unitIdBlockID.isNotEmpty &&
                                    widget.sendername.isNotEmpty &&
                                    widget.mobilenumber.isNotEmpty &&
                                    droppingAddressList.isNotEmpty &&
                                    homeController.pincodes.isNotEmpty &&
                                    homeController.doornames.isNotEmpty) {
                                  Get.to(ScheduleDeliveryScreen(
senderUnitId: widget.unitId,
                                    parcelKg: homeController
                                        .calculateSum()
                                        .toStringAsFixed(2),
                                    parcelQty: homeController
                                        .calculateQty()
                                        .toStringAsFixed(2),
                                    roundTrip: homeController.roundTrip.value,
                                    deliveryTimeTos: dropTime!,
                                    deliveryTimeFroms: pickTime!,
                                    totalWeight: totalWeight.toString(),
                                    displayTimes: "Select Time",
                                    pickupAddress: widget.pickupAdress,
                                    pickuplatitude: widget.lat,
                                    pickuplogitude: widget.long,
                                    droppingLatitude:
                                        homeController.droppingLats,
                                    droppingLogitude: homeController.dropLongs,
                                    bookingDate: formatDateTime,
                                    deliverytype:
                                        selectedDeliveryTypes.first.name,
                                    deliVerytypeID:
                                        selectedDeliveryTypes.first.id,
                               
                                    length: homeController
                                        .parcelLengthControllers
                                        .map((controller) => controller.text)
                                        .toList(),
                            
                                    width: homeController
                                        .parcelHeightControllers
                                        .map((controller) => controller.text)
                                        .toList(),
                                

                                    height: homeController
                                        .parcelHeightControllers
                                        .map((controller) => controller.text)
                                        .toList(),
                              
                                    qty: homeController.quantityControllers
                                        .map((controller) => controller.text)
                                        .toList(),
                            
                                    kg: homeController.parcelKgControllers
                                        .map((controller) => controller.text)
                                        .toList(),
                               
                                    parcelItems: parcelitemController.text,
                                    senderunitIdBlockId: widget.unitIdBlockID,

                                    pickTimeListFrom: [
                                      _formatTime(pickTime!),
                                    ],
                                    pickTimeListTo: [_formatTime(dropTime!)],
                                    pickTimeFrom: _formatTime(pickTime!),
                                    pickTimeTo: _formatTime(dropTime!),
                                    sendername: widget.sendername,
                                    phonenumber: widget.mobilenumber,
                                    droppingaddress: droppingAddressList,
                                    arpincode:
                                        homeController.receiverBlockIdUnitIDs,
                                    doorname: homeController.doornames,
                                    receivername:
                                        homeController.receiverNameList,
                                    receiverphone:
                                        homeController.receiverNumberList,
                                    receiverUnitIdBlockId: homeController.receiverUnitID,
                                    receiverUnitId: homeController.receiverUnitID,
                                    selectedDeliveryTypes:
                                        selectedDeliveryTypes,
                                    
                                  ));
                                } else {
                                  Get.snackbar(
                                      "Fill all Fileds", "Please try again!",
                                      colorText: AppColors.kwhite,
                                      backgroundColor: Colors.red,
                                      snackPosition: SnackPosition.BOTTOM);
                                }
                              },
                              child: CommonContainer(
                                name: "Next",
                              )),
                          ksizedbox10,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hintText, String joinText) {
    return Container(
      // height: 35,
      // width: 60,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(4),
      //   border: Border.all(width: 1, color: Colors.grey.withOpacity(0.32)),
      // ),
      width: 50,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        cursorColor: Colors.black,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          suffixText: joinText,
          contentPadding:
              EdgeInsets.only(top: 5, left: 5, bottom: 10, right: 5),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xff455A64),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
