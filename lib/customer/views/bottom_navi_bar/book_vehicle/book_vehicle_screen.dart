import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:v_export/constant/common_container.dart';
import 'package:v_export/customer/controller/home_controller.dart';
import 'package:v_export/customer/controller/parcel_controller.dart';
import 'package:v_export/customer/model/add_booking_vehicle_model.dart';
import 'package:v_export/customer/model/additional_service_model.dart';
import 'package:v_export/customer/model/vehicle_type_model.dart';
import 'package:v_export/customer/views/bottom_navi_bar/book_vehicle/drop_screen_vehicle.dart';
import 'package:v_export/customer/views/bottom_navi_bar/book_vehicle/drop_screen_vehicle.dart';
import 'package:v_export/customer/views/bottom_navi_bar/book_vehicle/pickup_screen_vehicle.dart';
import 'package:v_export/customer/views/bottom_navi_bar/book_vehicle/vehicle_booking_details.dart';
import 'package:v_export/customer/views/bottom_navi_bar/bottomn_navi_bar.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/pickup_address_details.dart';
import 'package:intl/intl.dart';

import '../../../../constant/app_colors.dart';
import '../../../../constant/app_font.dart';

class BookVehicleScreen extends StatefulWidget {
  final String vehiclepickupAdress;
  final String vehiclepickuplat;
  final String vehiclepickuplong;
  final String vehiclepickupBlockIDs;
  final String vehiclepickupsendername;
  final String vehicleSenderMobilenumber;
  final String vehiclepickupunitId;
  final String vehiclePickupPincode;

  BookVehicleScreen({
    super.key,
    required this.vehiclepickupunitId,
    required this.vehiclepickupAdress,
    required this.vehiclepickuplat,
    required this.vehiclepickuplong,
    required this.vehiclepickupBlockIDs,
    required this.vehiclepickupsendername,
    required this.vehicleSenderMobilenumber,
    required this.vehiclePickupPincode,
  });

  @override
  State<BookVehicleScreen> createState() => _BookVehicleScreenState();
}

class _BookVehicleScreenState extends State<BookVehicleScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await parcelController.getVehicleTypes();
      await parcelController.getAdditionalServices("booking_van");
      initializeIsCheckList();

      parcelController.update();

      setState(() {});
    });
  }

  List<String> vehicleList = [
    "assets/icons/car_0.svg",
    "assets/icons/van_0.svg",
    "assets/icons/van_0.svg",
    "assets/icons/lorry_0.svg",
    "assets/icons/lorry_0.svg",
    "assets/icons/lorry_0.svg"
  ];

  bool ischeck = false;
  double vehicletotalDistance = 0.0;
  bool _isLoading = false;
  double? vehicleStoredTotalDistance;
  final HomeController homeController = Get.put(HomeController());
  final ParcelController parcelController = Get.put(ParcelController());

  DateTime selectedDate = DateTime.now();
  var datebookingController = TextEditingController();
  var delivarytypeController = TextEditingController();
  var parcelsizeController = TextEditingController();
  var parcelkgController = TextEditingController();
  var numberofparcelController = TextEditingController();
  var deliveryNotesController = TextEditingController();
  var pickuptimeController = TextEditingController();

  String formatDateTime = "";
  String weekendDates = "";
  String weekendDate = "";

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formatDateTime = formatDate(selectedDate, [dd, '-', mm, '-', yyyy]);

        // Determine the weekend date based on the selected date
        if (selectedDate.weekday == DateTime.friday) {
          weekendDate = "Friday: $formatDateTime";
        } else if (selectedDate.weekday == DateTime.saturday) {
          weekendDate = "Saturday: $formatDateTime";
        } else if (selectedDate.weekday == DateTime.sunday) {
          weekendDate = "Sunday: $formatDateTime";
        } else {
          // If the selected date is not a weekend, find the next weekend
          DateTime friday = selectedDate
              .subtract(Duration(days: selectedDate.weekday - DateTime.friday));
          weekendDate =
              "Friday: ${formatDate(friday, [dd, '-', mm, '-', yyyy])}";
        }
      });
    }
  }

  bool isWeekend(DateTime date) {
    return date.weekday == DateTime.friday ||
        date.weekday == DateTime.saturday ||
        date.weekday == DateTime.sunday;
  }

  TimeOfDay? pickTime;

  void _selectpickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: pickTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != pickTime) {
      setState(() {
        pickTime = picked;
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

  File? images;
  bool imageHiding = false;
  final ImagePicker _picker = ImagePicker();
  String _imagePath = "";
  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      print('Picked file path: ${pickedFile?.path}');

      if (pickedFile != null) {
        setState(() {
          images = File(pickedFile.path);
          _imagePath = pickedFile.path;
          imageHiding = true;
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  var vehicleItems;
  String? vehicleItemsNames;
  int? vehicleItemsID;

  void initializeIsCheckList() {
    isCheck =
        List<bool>.filled(parcelController.additionalServiceData.length, false);
    for (int i = 0; i < parcelController.additionalServiceData.length; i++) {
      if (savedSelectItem.contains(parcelController.additionalServiceData[i])) {
        isCheck[i] = true;
      }
    }
    updateVehicleTotalAmount();
  }

  int updateValue = 0;
  int maxValue = 3;
  int count = 0;
  int maxCount = 12;

  List<AdditionalServiceData> selectedvehicleservice = [];
  List<AdditionalServiceData> savedSelectItem = [];

  List<bool> isCheck = [];
  bool isItemSelected = false;
  bool isDropdownOpen = false;

  double totalAmountVehicle = 0.0;
  double totalAmount = 0.0;

  void updateVehicleTotalAmount() {
    totalAmountVehicle = selectedvehicleservice.fold(0.0, (sum, item) {
      double itemAmount = double.tryParse(item.amount) ?? 0.0;
      return sum + itemAmount;
    });
    updateTotalAmount();
  }

  void updateTotalAmount() {
    totalAmount = 0.0;
    for (int i = 0; i < isCheck.length; i++) {
      if (isCheck[i]) {
        double serviceAmount =
            double.tryParse(parcelController.additionalServiceData[i].amount) ??
                0.0;
        if (i == 0) {
          // ManPower service
          totalAmount += calculateManPower(updateValue, serviceAmount);
        } else if (i == 3) {
          // StairCase service
          totalAmount += calculateStairCase(count, serviceAmount);
        } else {
          totalAmount += serviceAmount;
        }
      }
    }
    totalAmount += totalAmountVehicle;
  }

  void addValue(StateSetter setState) {
    setState(() {
      if (updateValue < maxValue) {
        updateValue++;
        updateTotalAmount();
      }
    });
  }

  void decrementValue(StateSetter setState) {
    setState(() {
      if (updateValue > 0) {
        updateValue--;
        updateTotalAmount();
      }
    });
  }

  double calculateManPower(int updateValue, double serviceAmount) {
    return updateValue * serviceAmount;
  }

  double calculateStairCase(int count, double serviceAmount) {
    return count * serviceAmount;
  }

  void addCount(StateSetter setState) {
    setState(() {
      if (count < maxCount) {
        count++;
        updateTotalAmount();
      }
    });
  }

  void decrementCount(StateSetter setState) {
    setState(() {
      if (count > 0) {
        count--;
        updateTotalAmount();
        Get.snackbar("Fill all Fileds", "Please try again!",
            colorText: AppColors.kwhite,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.BOTTOM);
        manPowerCheck = false;
      } else if (count > 1) {
        manPowerCheck = true;
      }
    });
  }

  bool manPowerCheck = false;

  void showListViewDialog(BuildContext context) {
    initializeIsCheckList();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Center(
              child: Dialog(
                insetPadding: EdgeInsets.symmetric(horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Additional Services',
                            style: primaryfont.copyWith(
                              fontSize: 16.sp,
                              color: AppColors.kblue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.cancel_outlined,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      ksizedbox15,
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GetBuilder<ParcelController>(builder: (controller) {
                              return ListView.builder(
                                itemCount:
                                    controller.additionalServiceData.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  AdditionalServiceData serviceData =
                                      controller.additionalServiceData[index];

                                  double totalManPower = calculateManPower(
                                      updateValue,
                                      double.parse(serviceData.amount));
                                  double totalStairCase = calculateStairCase(
                                      count, double.parse(serviceData.amount));

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isCheck[index] = !isCheck[index];
                                        manPowerCheck = true;
                                        if (isCheck[index]) {
                                          selectedvehicleservice
                                              .add(serviceData);
                                        } else {
                                          selectedvehicleservice
                                              .remove(serviceData);
                                        }
                                        updateTotalAmount();
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isCheck[index] =
                                                        !isCheck[index];
                                                    manPowerCheck = true;
                                                    if (isCheck[index]) {
                                                      selectedvehicleservice
                                                          .add(serviceData);
                                                    } else {
                                                      selectedvehicleservice
                                                          .remove(serviceData);
                                                    }
                                                    updateTotalAmount();
                                                  });
                                                },
                                                child: Container(
                                                  height: 18.h,
                                                  width: 18.w,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: AppColors.kblue),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: isCheck[index]
                                                      ? Image.asset(
                                                          "assets/icons/7-Check.png")
                                                      : Text(""),
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                serviceData.name,
                                                style: primaryfont.copyWith(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Ksizedboxw10,
                                              if (index == 0 || index == 3)
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        if (index == 0) {
                                                          decrementValue(
                                                              setState);
                                                        } else if (index == 3) {
                                                          decrementCount(
                                                              setState);
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 25,
                                                        width: 25,
                                                        decoration:
                                                            const BoxDecoration(
                                                                color:
                                                                    Colors.grey,
                                                                shape: BoxShape
                                                                    .circle),
                                                        child: const Icon(
                                                            Icons.remove,
                                                            size: 16,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      index == 0
                                                          ? "$updateValue"
                                                          : "$count",
                                                      style:
                                                          primaryfont.copyWith(
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    SizedBox(width: 8),
                                                    GestureDetector(
                                                      onTap: () {
                                                        if (index == 0) {
                                                          addValue(setState);
                                                        } else if (index == 3) {
                                                          addCount(setState);
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 25,
                                                        width: 25,
                                                        decoration:
                                                            const BoxDecoration(
                                                                color:
                                                                    Colors.grey,
                                                                shape: BoxShape
                                                                    .circle),
                                                        child: const Icon(
                                                            Icons.add,
                                                            size: 16,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "+\$${index == 0 ? totalManPower : index == 3 ? totalStairCase : serviceData.amount}",
                                                style: primaryfont.copyWith(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }),
                          ],
                        ),
                      ),
                      // Text(
                      //   "Total: \$${totalAmount.toStringAsFixed(2)}",
                      //   style: primaryfont.copyWith(
                      //     fontSize: 16.sp,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      TextButton(
                        onPressed: () {
                          if (isCheck[0] && updateValue == 0 ||
                              isCheck[3] && count == 0) {
                            Get.snackbar("Alert",
                                "Please increase the value for the selected service!",
                                colorText: AppColors.kwhite,
                                backgroundColor: Colors.red,
                                snackPosition: SnackPosition.BOTTOM);
                          } else {
                            setState(() {
                              savedSelectItem =
                                  List.from(selectedvehicleservice);
                              print("savedSelectItem: $savedSelectItem");
                            });

                            Navigator.of(context).pop(savedSelectItem);
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
        );
      },
    );
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    List<int> additional_service_Id = savedSelectItem.map((e) => e.id).toList();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.kblue,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.to(BottomNavigationScreen(
              indexes: 0,
            ));
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
          'Book Vehicles',
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
                  padding: EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(17),
                      topRight: Radius.circular(17),
                    ),
                    color: AppColors.kwhite,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 8,
                          ),
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
                                    top: 7,
                                  ),
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
                                      borderRadius: BorderRadius.circular(5)),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        homeController.vehicalEntries.length,
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
                                                  Get.to(
                                                      PickupVehicleAddressDetails());
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
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.location_on,
                                                        color:
                                                            Color(0xffF74354),
                                                      ),
                                                      const VerticalDivider(
                                                        indent: 10,
                                                        thickness: 1,
                                                        width: 5,
                                                        color:
                                                            Color(0xff455A64),
                                                        endIndent: 10,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 5),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Get.to(
                                                                PickupVehicleAddressDetails());
                                                          },
                                                          child: Container(
                                                            width: 250.w,
                                                            child: Text(
                                                              widget
                                                                  .vehiclepickupAdress,
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
                                                Get.to(DropVehicleLocation(
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
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Get.to(
                                                              DropVehicleLocation(
                                                                  index:
                                                                      index));
                                                        },
                                                        child:
                                                            // Obx(
                                                            //   () =>
                                                            Container(
                                                          width: 250.w,
                                                          child: Text(
                                                            homeController
                                                                        .vehicledroppingLocations
                                                                        .length >
                                                                    index
                                                                ? homeController
                                                                        .vehicledroppingLocations[
                                                                    index]
                                                                : 'Enter Drop here...',

                                                            // widget
                                                            //     .vehicleDropAddress
                                                            //     .join(", "),
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
                                                        //  )
                                                      ),
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
                                                              .vehicalEntries
                                                              .length -
                                                          1 ==
                                                      index
                                                  ? MainAxisAlignment
                                                      .spaceBetween
                                                  : MainAxisAlignment.end,
                                              children: [
                                                if (homeController
                                                            .vehicalEntries
                                                            .length -
                                                        1 ==
                                                    index)
                                                  Row(
                                                    children: [
                                                      Checkbox(
                                                        value: homeController
                                                            .vehicalCheck.value,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            homeController
                                                                .roundCheck(
                                                                    value!);
                                                          });
                                                        },
                                                      ),
                                                      Text(
                                                        'Round Trip',
                                                        style: primaryfont
                                                            .copyWith(
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
                                                                .vehicalEntries
                                                                .length -
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
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        homeController
                                                                            .removeVehicalEntry(index);
                                                                        // homeController
                                                                        //     .removeParcelList(index);
                                                                      });
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .delete,
                                                                      color: Colors
                                                                          .red,
                                                                    ))
                                                              ],
                                                            ),
                                                          Row(
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    homeController
                                                                      ..addVehicalEntry();
                                                                  });
                                                                },
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color: const Color(
                                                                      0xff0072E8),
                                                                  size: 17.sp,
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    homeController
                                                                        .addVehicalEntry();
                                                                    // homeController
                                                                    //     .addParcelList();
                                                                  });
                                                                },
                                                                child: Text(
                                                                  'Add Location',
                                                                  style: primaryfont
                                                                      .copyWith(
                                                                    fontSize:
                                                                        15.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: const Color(
                                                                        0xff0072E8),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    : Container()
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                              ksizedbox30,
                              Container(
                                width: size.width,
                                decoration: BoxDecoration(
                                    color: AppColors.kwhite,
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          offset: Offset(0.0, 0.75),
                                          blurRadius: 2,
                                          color: AppColors.kgrey)
                                    ],
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, left: 10, right: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pickup Date',
                                        style: primaryfont.copyWith(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  formatDateTime.isEmpty
                                                      ? 'Select Date'
                                                      : formatDateTime,
                                                  style: primaryfont.copyWith(
                                                    color: Color(0xff455A64),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
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
                                      ksizedbox10,
                                      Text(
                                        'Select Vehicle',
                                        style: primaryfont.copyWith(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff455A64)),
                                      ),
                                      ksizedbox10,
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 7),
                                        height: 50.h,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Color(0xff444444)
                                                .withOpacity(.32),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child:
                                            DropdownButton<GetVehicleTypeData>(
                                          hint: Text(
                                            'Select Vehicle',
                                            style: TextStyle(
                                              color: Color(0xff455A64),
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          elevation: 16,
                                          isExpanded: true,
                                          style: TextStyle(
                                            color: Color(0xff444444)
                                                .withOpacity(.32),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          underline: Container(),
                                          value: vehicleItems,
                                          items: parcelController
                                              .vehicleTypesData
                                              .map((GetVehicleTypeData type) {
                                            return DropdownMenuItem<
                                                GetVehicleTypeData>(
                                              value: type,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 30.w,
                                                        child: SvgPicture.asset(
                                                          vehicleList[
                                                              parcelController
                                                                  .vehicleTypesData
                                                                  .indexOf(
                                                                      type)],
                                                          height: 25,
                                                          width: 25,
                                                        ),
                                                      ),
                                                      Text(
                                                        type.name,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff455A64),
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    type.description,
                                                    style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: Color(0xff455A64),
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  ksizedbox5,
                                                  if (vehicleItems != type ||
                                                      isDropdownOpen)
                                                    Container(
                                                      height: 1,
                                                      width: size.width,
                                                      color: Colors.black,
                                                    ),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                          onChanged:
                                              (GetVehicleTypeData? newValue) {
                                            setState(() {
                                              vehicleItems = newValue;
                                              vehicleItemsNames =
                                                  newValue?.name;
                                              vehicleItemsID = newValue?.id;
                                              print("object");
                                              //  vehicleItems = newValue?.id;
                                            });
                                          },
                                        ),
                                      ),
                                      ksizedbox10,
                                      Text(
                                        'Pickup Time',
                                        style: primaryfont.copyWith(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff455A64)),
                                      ),
                                      ksizedbox10,
                                      GestureDetector(
                                        onTap: () {
                                          _selectpickTime(context);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(left: 15),
                                          height: 50.h,
                                          width: size.width,
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
                                                // "${pickTime.hour < 10 ? "0${pickTime.hour}" : pickTime.hour}:${pickTime.minute.remainder(60) < 10 ? "0${pickTime.minute.remainder(60)}" : '${pickTime.minute.remainder(60)}'}:00"
                                                //     .toString(),
                                                pickTime != null
                                                    ? _formatTime(pickTime!)
                                                    : 'select time',
                                                style: primaryfont.copyWith(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff455A64)),
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
                                      ksizedbox10,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Upload Photo',
                                            style: primaryfont.copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff455A64)),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Optional',
                                                style: primaryfont.copyWith(
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff455A64)),
                                              ),
                                              ksizedbox5,
                                              Icon(
                                                Icons.help_outline,
                                                size: 20.sp,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      ksizedbox20,
                                      DottedBorder(
                                        borderType: BorderType.RRect,
                                        radius: Radius.circular(5),
                                        dashPattern: [6, 6],
                                        color: AppColors.kblue,
                                        child: InkWell(
                                          onTap: () {
                                            pickImage(ImageSource.camera);
                                          },
                                          child: Container(
                                              height: 100.h,
                                              width: size.width,
                                              decoration: BoxDecoration(
                                                  color: AppColors.kwhite),
                                              child: Center(
                                                child: imageHiding
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'Image Uploaded',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 22.sp,
                                                              color: const Color(
                                                                  0xff0080FF),
                                                            ),
                                                          ),
                                                          Ksizedboxw5,
                                                          const Icon(
                                                            Icons.check_circle,
                                                            size: 26,
                                                            color: Colors.green,
                                                          )
                                                        ],
                                                      )
                                                    : Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                            Image.asset(
                                                                'assets/icons/imageuploadicon.png'),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 2),
                                                              child: Text(
                                                                'Upload Product Picture',
                                                                style: primaryfont.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        14.sp,
                                                                    color: AppColors
                                                                        .kblue),
                                                              ),
                                                            )
                                                          ]),
                                              )),
                                        ),
                                      ),
                                      ksizedbox10,
                                      Text(
                                        'Add Delivery Notes',
                                        style: primaryfont.copyWith(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff455A64)),
                                      ),
                                      ksizedbox10,
                                      Container(
                                        height: 100.h,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                            color: AppColors.kwhite),
                                        child: TextFormField(
                                          textAlign: TextAlign.start,
                                          maxLines: 100,
                                          controller: deliveryNotesController,
                                          decoration: InputDecoration(
                                            hintText: 'Type here notes...',
                                            hintStyle: primaryfont.copyWith(
                                                fontSize: 14.h,
                                                fontWeight: FontWeight.w500),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xff444444)
                                                    .withOpacity(.32),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xff444444)
                                                    .withOpacity(.32),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      ksizedbox10,
                                      ksizedbox10,
                                      GestureDetector(
                                        onTap: () {
                                          showListViewDialog(context);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Additional Service',
                                              style: primaryfont.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16.sp,
                                                  color: AppColors.kblue),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                showListViewDialog(context);
                                              },
                                              child: Icon(
                                                Icons
                                                    .arrow_circle_right_outlined,
                                                size: 30,
                                                color: AppColors.kblue,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ksizedbox10,
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ksizedbox20,
                        Obx(
                          () {
                            return parcelController
                                    .addBookingVehicleLoading.isTrue
                                ? Container(
                                    height: 50.h,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      color: AppColors.kblue,
                                    )),
                                  )
                                : GestureDetector(
                                    onTap: () async {
                                      if (formKey.currentState!.validate()) {
                                        List<String>
                                            droppingvehivleAddressList =
                                            homeController
                                                .vehicledroppingLocations
                                                .toList();

                                        print("----------------------------s");
                                        print("droop length");
                                        print(
                                            "pickup block iD --- ${widget.vehiclepickupBlockIDs}");
                                        print(
                                            "pickup unit id --- ${widget.vehiclepickupunitId}");
                                        print(
                                            "drop block iD --- ${homeController.vehiclereceiverBlockIdUnitIDs}");
                                        print(
                                            "drop unit id --- ${homeController.vehiclereceiverUnitIDs}");

                                        String dropLocationCount =
                                            droppingvehivleAddressList.length
                                                .toString();

                                        print(widget.vehiclePickupPincode);
                                        print(
                                            homeController.vehicledroppincode);
                                        if (widget.vehiclepickupAdress
                                                .isNotEmpty &&
                                            _formatTime(pickTime!).isNotEmpty &&
                                            formatDateTime.isNotEmpty &&
                                            deliveryNotesController
                                                .text.isNotEmpty) {
                                          calculateVehicleDistance()
                                              .then((value) {
                                            Get.to(DriverBookingDetails(
                                              dropLocatiocounts:
                                                  dropLocationCount,
                                              weekEnd: isWeekend(selectedDate),
                                              manPowerQty: updateValue,
                                              helperQty: updateValue,
                                              staircaseCount: count,
                                              distance:
                                                  vehicleStoredTotalDistance
                                                      .toString(),
                                              vehicleTypeId: vehicleItemsID!,
                                              vehicleDropPincode: homeController
                                                  .vehicledroppincode,
                                              vehiclePickUppincode:
                                                  widget.vehiclePickupPincode,
                                              addtionalManpowerQty: updateValue,
                                              addtionalStairCaseQty: count,
                                              //
                                              vehiclepickupunitIdBlockID:
                                                  widget.vehiclepickupBlockIDs,
                                              unitId:
                                                  widget.vehiclepickupunitId,
                                              vehicleDropunitIdBlockId:
                                                  homeController
                                                      .vehiclereceiverBlockIdUnitIDs,
                                              vehicleUnitId: homeController
                                                  .vehiclereceiverUnitIDs,
                                              //
                                              additionalTotal: totalAmount
                                                  .toStringAsFixed(2),
                                              roundTrip: homeController
                                                  .roundChecked.value,
                                              selectedvehicleservice:
                                                  selectedvehicleservice,
                                              vehiclepickupAdress:
                                                  widget.vehiclepickupAdress,
                                              additionServiceItems:
                                                  savedSelectItem,
                                              imagePath: _imagePath == ""
                                                  ? ""
                                                  : _imagePath,
                                              notes:
                                                  deliveryNotesController.text,
                                              pickupDate: formatDateTime,
                                              pickupTime:
                                                  _formatTime(pickTime!),
                                              vehiclepickuplat:
                                                  widget.vehiclepickuplat,
                                              vehicleItemsname:
                                                  vehicleItemsNames.toString(),
                                              vehiclepickuplong:
                                                  widget.vehiclepickuplong,
                                              vehiclepickupsendername: widget
                                                  .vehiclepickupsendername,
                                              vehicleSenderMobilenumber: widget
                                                  .vehicleSenderMobilenumber,
                                              vehicleDropAddress:
                                                  droppingvehivleAddressList,
                                              vehicledroplat: homeController
                                                  .vehicledroppingLats,
                                              vehiclearpincode: ["78677"],
                                              vehicledroplong: homeController
                                                  .vehicledropLongs,
                                              vehicleDropreceivername:
                                                  homeController
                                                      .vehiclereceiverNameList,
                                              vehicleDropreceiverphone:
                                                  homeController
                                                      .vehiclereceiverNumberList,
                                            ));
                                          });
                                        } else {
                                          Get.snackbar("Fill all Fileds",
                                              "Please try again!",
                                              colorText: AppColors.kwhite,
                                              backgroundColor: Colors.red,
                                              snackPosition:
                                                  SnackPosition.BOTTOM);
                                        }
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: CommonContainer(
                                        name: "Next",
                                      ),
                                    ),
                                  );
                          },
                        ),
                        ksizedbox10,
                      ],
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

  Future<void> calculateVehicleDistance() async {
    // Check if the distance has already been calculated
    if (vehicleStoredTotalDistance == null) {
      double vehicletotalDistance = 0.0;

      // Calculate distance from pickup to the first dropping location

      await parcelController.getKiloMeterApi(
        lat1: double.parse(widget.vehiclepickuplat),
        lon1: double.parse(widget.vehiclepickuplong),
        lat2: double.parse(homeController.vehicledroppingLats[0]),
        lon2: double.parse(homeController.vehicledropLongs[0]),
        unit: "k",
      );
      vehicletotalDistance += parcelController.distance;
      print("Pick to drop location distance = $vehicletotalDistance");

      // Calculate distance for multiple dropping locations
      if (homeController.vehicledroppingLats.length > 1) {
        for (int i = 0;
            i < homeController.vehicledroppingLats.length - 1;
            i++) {
          await parcelController.getKiloMeterApi(
            lat1: double.parse(homeController.vehicledroppingLats[i]),
            lon1: double.parse(homeController.vehicledropLongs[i]),
            lat2: double.parse(homeController.vehicledroppingLats[i + 1]),
            lon2: double.parse(homeController.vehicledropLongs[i + 1]),
            unit: "k",
          );
          vehicletotalDistance += parcelController.distance;
          print("Drop to next drop location distance = $vehicletotalDistance");
        }
      }

      // Store the calculated distance
      vehicleStoredTotalDistance = vehicletotalDistance;
    } else {
      // Use the stored distance
      print("Using stored distance = $vehicleStoredTotalDistance");
    }

    // Send the storedTotalDistance to the next page
    // Pass storedTotalDistance as needed to the next page
  }
}
