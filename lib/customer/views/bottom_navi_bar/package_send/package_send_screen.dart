import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/common_container.dart';
import 'package:v_export/customer/controller/home_controller.dart';
import 'package:v_export/customer/controller/parcel_controller.dart';
import 'package:v_export/customer/model/delivery_type_model.dart';
import 'package:v_export/customer/views/bottom_navi_bar/bottomn_navi_bar.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/driver/droping_address_details.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/pickup_address_details.dart';
import 'package:v_export/customer/views/bottom_navi_bar/schedule_delivery.dart';

import '../../../../constant/app_colors.dart';
import '../../../../constant/app_font.dart';

class PackageSendScreen extends StatefulWidget {
  String pickupAdress;
  String lat;
  String long;
  List unitIdBlockID;
  String sendername;
  String receivername;
  String mobilenumber;

  PackageSendScreen(
      {super.key,
      required this.pickupAdress,
      required this.lat,
      required this.long,
      required this.unitIdBlockID,
      required this.sendername,
      required this.receivername,
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
      await parcelController.getAdditionalServices();
      // if (parcelController.deliveryTypesData.isNotEmpty) {
      //   deliveryItems = parcelController.deliveryTypesData[0];
      //   deliveryId = deliveryItems?.id;
      // }
      parcelController.update();
      setState(() {});
    });
  }

  final ParcelController parcelController = Get.find<ParcelController>();
  final HomeController homeController = Get.find<HomeController>();
  DateTime selectedDate = DateTime.now();
  TimeOfDay pickTime = TimeOfDay.now();
  TimeOfDay dropTime = TimeOfDay.now();
  double containerHeight = 100.0;

//  HomeController homeController = Get.find<HomeController>();
  var datebookingController = TextEditingController();
  var delivarytypeController = TextEditingController();
  var parcellengthController = TextEditingController();
  var parcelwidthController = TextEditingController();
  var parcelheightController = TextEditingController();

  var parcelkgController = TextEditingController();
  var numberofparcelController = TextEditingController();
  var parcelitemController = TextEditingController();
  var pickuptimeController = TextEditingController();
  var droptimeController = TextEditingController();
  var quantityController = TextEditingController();

  String formatDateTime = "";
  String pickingTime = "";
  String dropingTime = "";
  TimeOfDay? _updatedTime;
  TimeOfDay? updatedroptime1;
  TimeOfDay? updatedroptime2;
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

  Future displayTimePicker(BuildContext context) async {
    var time = await showTimePicker(
      context: context,
      initialTime: pickTime,
      initialEntryMode: TimePickerEntryMode.input,
    );

    if (time != null) {
      setState(() {
        pickTime = time;
        _updatedTime = _addMinutes(pickTime, 60);
      });
      print("-----picktime");
      print(pickTime);
      print(
          "${pickTime.hour < 10 ? "0${pickTime.hour}" : pickTime.hour}:${pickTime.minute.remainder(60) < 10 ? "0${pickTime.minute.remainder(60)}" : '${pickTime.minute.remainder(60)}:00'} - ${_updatedTime!.hour < 10 ? "0${_updatedTime!.hour}" : _updatedTime!.hour}:${_updatedTime!.minute.remainder(60) < 10 ? "0${_updatedTime!.minute.remainder(60)}" : '${_updatedTime!.minute.remainder(60)}:00'}"
              .toString());
    }
  }

  TimeOfDay _addMinutes(TimeOfDay time, int minutes) {
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final updatedDateTime = dateTime.add(Duration(minutes: minutes));
    return TimeOfDay(
        hour: updatedDateTime.hour, minute: updatedDateTime.minute);
  }

  Future dropTimePicker(BuildContext context) async {
    var times = await showTimePicker(
      context: context,
      initialTime: pickTime,
      initialEntryMode: TimePickerEntryMode.input,
    );

    if (times != null) {
      setState(() {
        dropTime = times;
        updatedroptime1 = _addMinutes(dropTime, 60);
        updatedroptime2 = _addMinutes(dropTime, 120);
      });

      print(dropTime);
    }
  }

  var deliveryItems;
  int? deliveryId;

  List<String> deliveryItemsList = [
    "Express Delvery - 24/7 (1 Hour)",
    "4 Hours Delivery",
    "Specific Time",
    "Same Day Delivery",
    "Next Day Delivery"
  ];

  bool checkParcelorMulti = false;

  final formKey = GlobalKey<FormState>();

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
        title: Text(
          'Parcel Booking',
          style: primaryfont.copyWith(
              fontSize: 21.sp,
              color: Color(0xffF4F8FF),
              fontWeight: FontWeight.w600),
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
                              padding: const EdgeInsets.only(
                                top: 10,
                              ),
                              duration: const Duration(milliseconds: 300),
                              width: size.width,
                              decoration: BoxDecoration(
                                  // color: Colors.yellow,
                                  color: AppColors.kwhite,
                                  boxShadow: const <BoxShadow>[
                                    BoxShadow(
                                        offset: Offset(0.0, 0.75),
                                        blurRadius: 1,
                                        color: AppColors.kgrey)
                                  ],
                                  borderRadius: BorderRadius.circular(5)),
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
                                              right: 10,
                                              left: 10,
                                            ),
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
                                                      color: Color(0xffF74354),
                                                    ),
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
                                              Get.to(DroppingAddressDetails(
                                                  index: index));
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
                                                  const Icon(
                                                    Icons.location_on,
                                                    color: Color(0xff038484),
                                                  ),
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
                                                          Get.to(
                                                              DroppingAddressDetails(
                                                                  index:
                                                                      index));
                                                        },
                                                        child: Obx(
                                                          () => Container(
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
                                                                fontSize: 13.sp,
                                                                color: const Color(
                                                                    0xff455A64),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 10,
                                          ),
                                          child: Row(
                                            mainAxisAlignment: homeController
                                                            .entries.length -
                                                        1 ==
                                                    index
                                                ? MainAxisAlignment.spaceBetween
                                                : MainAxisAlignment.end,
                                            children: [
                                              if (homeController
                                                          .entries.length -
                                                      1 ==
                                                  index)
                                                Row(
                                                  children: [
                                                    Checkbox(
                                                      value: homeController
                                                          .isCheck.value,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          homeController
                                                              .toggleCheck(
                                                                  value!);
                                                        });
                                                      },
                                                    ),
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
                                                  ],
                                                ),
                                              index ==
                                                      homeController
                                                              .entries.length -
                                                          1
                                                  ? Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              homeController
                                                                  .addEntry();
                                                            });
                                                          },
                                                          child: Icon(
                                                            Icons.add,
                                                            color: Color(
                                                                0xff0072E8),
                                                            size: 19.sp,
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              homeController
                                                                  .addEntry();
                                                              homeController
                                                                  .addParcelList();
                                                            });
                                                          },
                                                          child: Text(
                                                            'Add Location',
                                                            style: primaryfont
                                                                .copyWith(
                                                              fontSize: 17.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: const Color(
                                                                  0xff0072E8),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Row(
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                homeController
                                                                    .removeEntry(
                                                                        index);
                                                                homeController
                                                                    .removeParcelList(
                                                                        index);
                                                              });
                                                            },
                                                            icon: const Icon(
                                                              Icons.delete,
                                                              color: Colors.red,
                                                            ))
                                                      ],
                                                    ),
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
                                  Text(
                                    'Booking Date',
                                    style: primaryfont.copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff455A64)),
                                  ),
                                  ksizedbox10,
                                  GestureDetector(
                                    onTap: () {
                                      selectDate(context);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
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
                                  Text(
                                    'Select Delivery types',
                                    style: primaryfont.copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff000000)),
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
                                      value: deliveryItems,
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
                                          deliveryId = newValue?.id;
                                          if (deliveryItems?.name ==
                                              "Express Delivery") {
                                            _updatedTime =
                                                _addMinutes(pickTime, 60);
                                            // updatedroptime1 =
                                            //     _addMinutes(pickTime, 60);
                                            // updatedroptime2 =
                                            //     _addMinutes(pickTime, 120);
                                          } else if (deliveryItems?.name ==
                                              "Standard Delivery") {
                                            updatedroptime2 =
                                                _addMinutes(pickTime, 240);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  ksizedbox20,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        homeController.entries.length > 1
                                            ? "Multi Size"
                                            : "Parcel Size",
                                        style: primaryfont.copyWith(
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff000000)),
                                      ),
                                      Text(
                                        "LxWxH in cm*",
                                        style: primaryfont.copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.red,
                                        ),
                                      )
                                    ],
                                  ),
                                  ksizedbox5,
                                  AnimatedContainer(
                                    duration: Duration(microseconds: 300),
                                    padding: EdgeInsets.only(top: 5),
                                    //  height: 100.h * homeController.addParcels.length,
                                    child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            homeController.addParcels.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              index == 0
                                                  ? Text(
                                                      "${index + 1}st Location",
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: AppColors
                                                                  .kblue),
                                                    )
                                                  : index == 1
                                                      ? Text(
                                                          "${index + 1}nd Location",
                                                          style: primaryfont
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: AppColors
                                                                      .kblue),
                                                        )
                                                      : index == 2
                                                          ? Text(
                                                              "${index + 1}rd Location",
                                                              style: primaryfont.copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: AppColors
                                                                      .kblue),
                                                            )
                                                          : index == 3
                                                              ? Text(
                                                                  "${index + 1}th Location",
                                                                  style: primaryfont.copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: AppColors
                                                                          .kblue),
                                                                )
                                                              : index == 4
                                                                  ? Text(
                                                                      "${index + 1}th Location",
                                                                      style: primaryfont.copyWith(
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          color:
                                                                              AppColors.kblue),
                                                                    )
                                                                  : index > 5
                                                                      ? Text(
                                                                          "${index + 1}th Location",
                                                                          style: primaryfont.copyWith(
                                                                              fontWeight: FontWeight.w600,
                                                                              color: AppColors.kblue),
                                                                        )
                                                                      // : index ==
                                                                      //         6
                                                                      //     ? Text(
                                                                      //         "${index + 1}th Location",
                                                                      //         style: primaryfont.copyWith(fontWeight: FontWeight.w600, color: AppColors.kblue),
                                                                      //       )
                                                                      //     : index == 7
                                                                      //         ? Text(
                                                                      //             "${index + 1}th Location",
                                                                      //             style: primaryfont.copyWith(fontWeight: FontWeight.w600, color: AppColors.kblue),
                                                                      //           )
                                                                      //         : index == 8
                                                                      //             ? Text(
                                                                      //                 "${index + 1}th Location",
                                                                      //                 style: primaryfont.copyWith(fontWeight: FontWeight.w600, color: AppColors.kblue),
                                                                      //               )
                                                                      //             : index == 9
                                                                      //                 ? Text(
                                                                      //                     "${index + 1}th Location",
                                                                      //                     style: primaryfont.copyWith(fontWeight: FontWeight.w600, color: AppColors.kblue),
                                                                      //                   )
                                                                      //                 : index == 10
                                                                      //                     ? Text(
                                                                      //                         "${index + 1}th Location",
                                                                      //                         style: primaryfont.copyWith(fontWeight: FontWeight.w600, color: AppColors.kblue),
                                                                      //                       )
                                                                      //                     : index == 11
                                                                      //                         ? Text(
                                                                      //                             "${index + 1}th Location",
                                                                      //                             style: primaryfont.copyWith(fontWeight: FontWeight.w600, color: AppColors.kblue),
                                                                      //                           )
                                                                      : Text(
                                                                          "data"),
                                              ksizedbox5,
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    _buildTextField(
                                                        parcellengthController,
                                                        'L'),
                                                    Text("X"),
                                                    _buildTextField(
                                                        parcelwidthController,
                                                        'W'),
                                                    Text("X"),
                                                    _buildTextField(
                                                        parcelheightController,
                                                        'H'),
                                                    _buildTextField(
                                                        parcelkgController,
                                                        'Kg'),
                                                    _buildTextField(
                                                        quantityController,
                                                        'Qty'),
                                                  ],
                                                ),
                                              ),
                                              ksizedbox5,
                                            ],
                                          );
                                        }),
                                  ),
                                  ksizedbox10,
                                  Text(
                                    'Parcel Items',
                                    style: primaryfont.copyWith(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff000000)),
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
                                  Text(
                                    'Pickup Time',
                                    style: primaryfont.copyWith(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff455A64)),
                                  ),
                                  ksizedbox20,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          dropTimePicker(context);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(left: 5),
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
                                              //   if (_updatedTime != null)
                                              Text(
                                                // deliveryItems == null
                                                //     ? 'Select time'
                                                //     : deliveryItems ==
                                                //             "Express Delvery - 24/7 (1 Hour)"
                                                //         ? "${pickTime.format(context)} - ${_updatedTime!.format(context)}"
                                                //         : "${pickTime.format(context)}",
                                                deliveryId == null
                                                    ? 'Select time'
                                                    : deliveryId == 2
                                                        ? "${pickTime.hour < 10 ? "0${pickTime.hour}" : pickTime.hour}:${pickTime.minute.remainder(60) < 10 ? "0${pickTime.minute.remainder(60)}" : '${pickTime.minute.remainder(60)}:00'}"
                                                            .toString()
                                                        : "${pickTime.hour < 10 ? "0${pickTime.hour}" : pickTime.hour}:${pickTime.minute.remainder(60) < 10 ? "0${pickTime.minute.remainder(60)}" : '${pickTime.minute.remainder(60)}:00'}"
                                                            .toString(),
                                                style: primaryfont.copyWith(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: const Color.fromARGB(
                                                        255, 2, 3, 3)),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    displayTimePicker(context);
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
                                          dropTimePicker(context);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(left: 5),
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
                                                deliveryId == null
                                                    ? 'Select time'
                                                    : deliveryId == 2
                                                        ? "${_updatedTime!.hour < 10 ? "0${_updatedTime!.hour}" : _updatedTime!.hour}:${_updatedTime!.minute.remainder(60) < 10 ? "0${_updatedTime!.minute.remainder(60)}" : '${_updatedTime!.minute.remainder(60)}:00'}"
                                                            .toString()
                                                        : deliveryId == 1
                                                            ? "${updatedroptime2!.hour < 10 ? "0${updatedroptime2!.hour}" : updatedroptime2!.hour}:${updatedroptime2!.minute.remainder(60) < 10 ? "0${updatedroptime2!.minute.remainder(60)}" : '${updatedroptime2!.minute.remainder(60)}:00'}"
                                                            : "${dropTime.hour < 10 ? "0${dropTime.hour}" : dropTime.hour}:${dropTime.minute.remainder(60) < 10 ? "0${dropTime.minute.remainder(60)}" : '${dropTime.minute.remainder(60)}:00'}"
                                                                .toString(),
                                                // deliveryItems == null
                                                //     ? 'Select time'
                                                //     : deliveryItems ==
                                                //             "Express Delvery - 24/7 (1 Hour)"
                                                //         ? "${updatedroptime1!.format(context)} - ${updatedroptime2!.format(context)}"
                                                //         : deliveryItems ==
                                                //                 "4 Hours Delivery"
                                                //             ? updatedroptime2!
                                                //                 .format(context)
                                                //             : "${dropTime.format(context)}",
                                                // "${dropTime.hour < 10 ? "0${dropTime.hour}" : dropTime.hour}:${dropTime.minute.remainder(60) < 10 ? "0${dropTime.minute.remainder(60)}" : '${dropTime.minute.remainder(60)}'} - ${dropTime.hour < 10 ? "0${dropTime.hour}" : dropTime.hour}:${dropTime.minute.remainder(60) < 10 ? "0${dropTime.minute.remainder(60)}" : '${dropTime.minute.remainder(60)}'}"
                                                //     .toString(),
                                                style: primaryfont.copyWith(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: const Color.fromARGB(
                                                        255, 2, 3, 3)),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    dropTimePicker(context);
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
                                Get.to(ScheduleDeliveryScreen(
                                  pickuplatitude: widget.lat,
                                  pickuplogitude: widget.long,
                                  droppingLatitude: homeController.droppingLats,
                                  droppingLogitude: homeController.dropLongs,
                                  bookingDate: formatDateTime,
                                  deliverytype: deliveryId.toString(),
                                  length: parcellengthController.text,
                                  width: parcelwidthController.text,
                                  height: parcelheightController.text,
                                  qty: int.parse(quantityController.text),
                                  kg: parcelkgController.text,
                                  parcelItems: parcelitemController.text,
                                  unitIdBlockId: [
                                    widget.unitIdBlockID.toString()
                                  ],
                                  pickTimeListFrom: [
                                    pickTime.toString(),
                                    _updatedTime.toString()
                                  ],
                                  pickTimeListTo: [
                                    updatedroptime1.toString(),
                                    updatedroptime2.toString()
                                  ],
                                  pickTimeFrom: pickTime.toString(),
                                  pickTimeTo: dropTime.toString(),
                                  sendername: widget.sendername,
                                  phonenumber: widget.mobilenumber,
                                  droppingaddress: droppingAddressList,
                                  arpincode: homeController.pincodes,
                                  doorname: homeController.doornames,
                                ));
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

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return Container(
      height: 35,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(width: 1, color: Colors.grey.withOpacity(0.32)),
      ),
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
          contentPadding: EdgeInsets.only(top: 0, left: 5, bottom: 15),
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


// Padding(
                                              //   padding:
                                              //       EdgeInsets.only(bottom: 10),
                                              //   child: Row(
                                              //     mainAxisAlignment:
                                              //         MainAxisAlignment
                                              //             .spaceBetween,
                                              //     children: [
                                              //       Container(
                                              //         height: 45.h,
                                              //         width: 60.w,
                                              //         decoration: BoxDecoration(
                                              //           borderRadius:
                                              //               BorderRadius
                                              //                   .circular(4),
                                              //         ),
                                              //         child: TextFormField(
                                              //           controller:
                                              //               parcellengthController,
                                              //           keyboardType:
                                              //               TextInputType
                                              //                   .number,
                                              //           cursorColor:
                                              //               Colors.black,
                                              //           style: primaryfont
                                              //               .copyWith(
                                              //             fontSize: 14.sp,
                                              //             fontWeight:
                                              //                 FontWeight.w500,
                                              //             color: Colors
                                              //                 .black, // Ensure the text color is visible
                                              //           ),
                                              //           decoration:
                                              //               InputDecoration(
                                              //             contentPadding:
                                              //                 const EdgeInsets
                                              //                     .only(
                                              //                     top: 5,
                                              //                     left: 5),
                                              //             hintText: 'L',
                                              //             hintStyle: primaryfont
                                              //                 .copyWith(
                                              //               fontSize: 14.sp,
                                              //               fontWeight:
                                              //                   FontWeight.w500,
                                              //               color: Color(
                                              //                   0xff455A64),
                                              //             ),
                                              //             border:
                                              //                 InputBorder.none,
                                              //             enabledBorder:
                                              //                 OutlineInputBorder(
                                              //               borderRadius:
                                              //                   BorderRadius
                                              //                       .circular(
                                              //                           4),
                                              //               borderSide:
                                              //                   BorderSide(
                                              //                 width: 1,
                                              //                 color: Colors.grey
                                              //                     .withOpacity(
                                              //                         .32),
                                              //               ),
                                              //             ),
                                              //             focusedBorder:
                                              //                 OutlineInputBorder(
                                              //               borderRadius:
                                              //                   BorderRadius
                                              //                       .circular(
                                              //                           4),
                                              //               borderSide:
                                              //                   BorderSide(
                                              //                 width: 1,
                                              //                 color: Colors.grey
                                              //                     .withOpacity(
                                              //                         .32),
                                              //               ),
                                              //             ),
                                              //           ),
                                              //         ),
                                              //       ),
                                              //       Text("X"),
                                              //       Container(
                                              //         height: 45.h,
                                              //         width: 60.w,
                                              //         decoration: BoxDecoration(
                                              //           borderRadius:
                                              //               BorderRadius
                                              //                   .circular(4),
                                              //         ),
                                              //         child: TextFormField(
                                              //           controller:
                                              //               parcelwidthController,
                                              //           keyboardType:
                                              //               TextInputType
                                              //                   .number,
                                              //           cursorColor:
                                              //               Colors.black,
                                              //           style: primaryfont
                                              //               .copyWith(
                                              //             fontSize: 14.sp,
                                              //             fontWeight:
                                              //                 FontWeight.w500,
                                              //             color: Colors.black,
                                              //           ),
                                              //           decoration:
                                              //               InputDecoration(
                                              //             // suffixIcon: Padding(
                                              //             //   padding: const EdgeInsets.only(
                                              //             //       left: 16, top: 12),
                                              //             //   child: Text(
                                              //             //     "cm",
                                              //             //     style: primaryfont.copyWith(
                                              //             //       fontSize: 14.sp,
                                              //             //       fontWeight: FontWeight.w500,
                                              //             //       color: Color(0xff455A64),
                                              //             //     ),
                                              //             //   ),
                                              //             // ),
                                              //             contentPadding:
                                              //                 const EdgeInsets
                                              //                     .only(
                                              //                     top: 5,
                                              //                     left: 5),
                                              //             hintText: 'W',
                                              //             hintStyle: primaryfont
                                              //                 .copyWith(
                                              //               fontSize: 14.sp,
                                              //               fontWeight:
                                              //                   FontWeight.w500,
                                              //               color: Color(
                                              //                   0xff455A64),
                                              //             ),
                                              //             border:
                                              //                 InputBorder.none,
                                              //             enabledBorder:
                                              //                 OutlineInputBorder(
                                              //               borderRadius:
                                              //                   BorderRadius
                                              //                       .circular(
                                              //                           4),
                                              //               borderSide:
                                              //                   BorderSide(
                                              //                 width: 1,
                                              //                 color: Colors.grey
                                              //                     .withOpacity(
                                              //                         .32),
                                              //               ),
                                              //             ),
                                              //             focusedBorder:
                                              //                 OutlineInputBorder(
                                              //               borderRadius:
                                              //                   BorderRadius
                                              //                       .circular(
                                              //                           4),
                                              //               borderSide:
                                              //                   BorderSide(
                                              //                 width: 1,
                                              //                 color: Colors.grey
                                              //                     .withOpacity(
                                              //                         .32),
                                              //               ),
                                              //             ),
                                              //           ),
                                              //         ),
                                              //       ),
                                              //       Text("X"),
                                              //       Container(
                                              //         height: 45.h,
                                              //         width: 60.w,
                                              //         decoration: BoxDecoration(
                                              //           borderRadius:
                                              //               BorderRadius
                                              //                   .circular(4),
                                              //         ),
                                              //         child: TextFormField(
                                              //           controller:
                                              //               parcelheightController,
                                              //           keyboardType:
                                              //               TextInputType
                                              //                   .number,
                                              //           cursorColor:
                                              //               Colors.black,
                                              //           style: primaryfont
                                              //               .copyWith(
                                              //             fontSize: 14.sp,
                                              //             fontWeight:
                                              //                 FontWeight.w500,
                                              //             color: Colors.black,
                                              //           ),
                                              //           decoration:
                                              //               InputDecoration(
                                              //             contentPadding:
                                              //                 const EdgeInsets
                                              //                     .only(
                                              //                     top: 5,
                                              //                     left: 5),
                                              //             hintText: 'h',
                                              //             hintStyle: primaryfont
                                              //                 .copyWith(
                                              //               fontSize: 14.sp,
                                              //               fontWeight:
                                              //                   FontWeight.w500,
                                              //               color: const Color(
                                              //                   0xff455A64),
                                              //             ),
                                              //             border:
                                              //                 InputBorder.none,
                                              //             enabledBorder:
                                              //                 OutlineInputBorder(
                                              //               borderRadius:
                                              //                   BorderRadius
                                              //                       .circular(
                                              //                           4),
                                              //               borderSide:
                                              //                   BorderSide(
                                              //                 width: 1,
                                              //                 color: Colors.grey
                                              //                     .withOpacity(
                                              //                         .32),
                                              //               ),
                                              //             ),
                                              //             focusedBorder:
                                              //                 OutlineInputBorder(
                                              //               borderRadius:
                                              //                   BorderRadius
                                              //                       .circular(
                                              //                           4),
                                              //               borderSide:
                                              //                   BorderSide(
                                              //                 width: 1,
                                              //                 color: Colors.grey
                                              //                     .withOpacity(
                                              //                         .32),
                                              //               ),
                                              //             ),
                                              //           ),
                                              //         ),
                                              //       ),
                                              //       Container(
                                              //         height: 45.h,
                                              //         width: 60.w,
                                              //         decoration:
                                              //             const BoxDecoration(
                                              //                 color: AppColors
                                              //                     .kwhite),
                                              //         child: TextFormField(
                                              //           controller:
                                              //               parcelkgController,
                                              //           decoration:
                                              //               InputDecoration(
                                              //             contentPadding:
                                              //                 const EdgeInsets
                                              //                     .only(
                                              //                     top: 5,
                                              //                     left: 10),
                                              //             hintText: 'Kg',
                                              //             hintStyle: primaryfont
                                              //                 .copyWith(
                                              //                     fontSize:
                                              //                         14.sp,
                                              //                     fontWeight:
                                              //                         FontWeight
                                              //                             .w500,
                                              //                     color: Color(
                                              //                         0xff455A64)),
                                              //             border:
                                              //                 OutlineInputBorder(
                                              //               borderRadius:
                                              //                   BorderRadius
                                              //                       .circular(
                                              //                           4),
                                              //               borderSide:
                                              //                   BorderSide(
                                              //                 width: 1,
                                              //                 color: Colors.grey
                                              //                     .withOpacity(
                                              //                         .32),
                                              //               ),
                                              //             ),
                                              //             enabledBorder:
                                              //                 OutlineInputBorder(
                                              //               borderRadius:
                                              //                   BorderRadius
                                              //                       .circular(
                                              //                           4),
                                              //               borderSide:
                                              //                   BorderSide(
                                              //                 width: 1,
                                              //                 color: Colors.grey
                                              //                     .withOpacity(
                                              //                         .32),
                                              //               ),
                                              //             ),
                                              //             focusedBorder:
                                              //                 OutlineInputBorder(
                                              //               borderRadius:
                                              //                   BorderRadius
                                              //                       .circular(
                                              //                           4),
                                              //               borderSide:
                                              //                   const BorderSide(
                                              //                 width: 1,
                                              //               ),
                                              //             ),
                                              //           ),
                                              //         ),
                                              //       ),
                                              //       Container(
                                              //         height: 45.h,
                                              //         width: 60.w,
                                              //         decoration:
                                              //             const BoxDecoration(
                                              //                 color: AppColors
                                              //                     .kwhite),
                                              //         child: TextFormField(
                                              //           controller:
                                              //               quantityController,
                                              //           decoration:
                                              //               InputDecoration(
                                              //             contentPadding:
                                              //                 const EdgeInsets
                                              //                     .only(
                                              //                     top: 5,
                                              //                     left: 10),
                                              //             hintText: 'Qty',
                                              //             hintStyle: primaryfont
                                              //                 .copyWith(
                                              //                     fontSize:
                                              //                         14.sp,
                                              //                     fontWeight:
                                              //                         FontWeight
                                              //                             .w500,
                                              //                     color: Color(
                                              //                         0xff455A64)),
                                              //             border:
                                              //                 OutlineInputBorder(
                                              //               borderRadius:
                                              //                   BorderRadius
                                              //                       .circular(
                                              //                           4),
                                              //               borderSide:
                                              //                   BorderSide(
                                              //                 width: 1,
                                              //                 color: Colors.grey
                                              //                     .withOpacity(
                                              //                         .32),
                                              //               ),
                                              //             ),
                                              //             enabledBorder:
                                              //                 OutlineInputBorder(
                                              //               borderRadius:
                                              //                   BorderRadius
                                              //                       .circular(
                                              //                           4),
                                              //               borderSide:
                                              //                   BorderSide(
                                              //                 width: 1,
                                              //                 color: Colors.grey
                                              //                     .withOpacity(
                                              //                         .32),
                                              //               ),
                                              //             ),
                                              //             focusedBorder:
                                              //                 OutlineInputBorder(
                                              //               borderRadius:
                                              //                   BorderRadius
                                              //                       .circular(
                                              //                           4),
                                              //               borderSide:
                                              //                   const BorderSide(
                                              //                 width: 1,
                                              //               ),
                                              //             ),
                                              //           ),
                                              //         ),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),