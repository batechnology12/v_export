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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await parcelController.getVehicleTypes();
      initializeIsCheckList();
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
  String modifiedName = "";
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
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
              surface: Colors.white, // Calendar background color
            ),
            // textButtonTheme: TextButtonThemeData(
            //   style: TextButton.styleFrom(
            //     primary: Colors.red, // Button text color
            //   ),
            // ),
          ),
          child: child!,
        );
      },
    );

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

  GetVehicleTypeData? vehicleItems;

  String? vehicleItemsNames;
  int? vehicleItemsID;
  List<AdditionalServiceData> selectedvehicleservice = [];
  List<AdditionalServiceData> savedSelectItem = [];
  bool isDropdownOpen = false;

  List<bool> isCheck = [];

  void initializeIsCheckList() {
    if (isCheck.isEmpty) {
      isCheck = List<bool>.filled(
          parcelController.additionalServiceData.length, false);

      for (int i = 0; i < parcelController.additionalServiceData.length; i++) {
        if (savedSelectItem
            .contains(parcelController.additionalServiceData[i])) {
          isCheck[i] = true;
        }
      }
    }
  }

  int updateValue = 0;
  int maxValue = 3;
  int totalManPower = 0;

  int count = 0;
  int maxCount = 12;

  bool checkManPower = false;
  bool isItemSelected = false;

  double totalAmountVehicle = 0.0;
  double totalAmount = 0.0;
  double manPowerHelper = 0;

  void updateManpwerTotalAmount(StateSetter setState) {
    setState(() {
      if (updateValue == 1 &&
          (vehicleItems?.name == "1.7m Van" ||
              vehicleItems?.name == "2.4m Van")) {
        manPowerHelper = double.parse(vehicleItems!.driverHelp);
      } else if (updateValue == 2 &&
          (vehicleItems?.name == "1.7m Van" ||
              vehicleItems?.name == "2.4m Van")) {
        manPowerHelper = double.parse(vehicleItems!.driverHelp) +
            double.parse(vehicleItems!.helper);
      } else if (updateValue == 3 &&
          (vehicleItems?.name == "1.7m Van" ||
              vehicleItems?.name == "2.4m Van")) {
        manPowerHelper = double.parse(vehicleItems!.driverHelp) +
            double.parse(vehicleItems!.helper) +
            double.parse(vehicleItems!.helper);
      } else if (updateValue == 1 &&
          (vehicleItems?.name == "10ft Lorry" ||
              vehicleItems?.name == "14ft Lorry" ||
              vehicleItems?.name == "24ft Lorry")) {
        manPowerHelper = double.parse(vehicleItems!.driverHelp);
      } else if (updateValue == 2 &&
          (vehicleItems?.name == "10ft Lorry" ||
              vehicleItems?.name == "14ft Lorry" ||
              vehicleItems?.name == "24ft Lorry")) {
        manPowerHelper = double.parse(vehicleItems!.driverHelp) +
            double.parse(vehicleItems!.helper);
      } else if (updateValue == 3 &&
          (vehicleItems?.name == "10ft Lorry" ||
              vehicleItems?.name == "14ft Lorry" ||
              vehicleItems?.name == "24ft Lorry")) {
        manPowerHelper = double.parse(vehicleItems!.driverHelp) +
            double.parse(vehicleItems!.helper) +
            double.parse(vehicleItems!.helper);
        ;
      } else if (updateValue == 0) {
        manPowerHelper = 0;
      }
    });
  }

  void updateVehicleTotalAmount() {
    totalAmountVehicle = selectedvehicleservice.fold(0.0, (sum, item) {
      double itemAmount = double.tryParse(item.amount) ?? 0.0;
      return sum + itemAmount;
    });
    updateTotalAmount();
  }

  void updateTotalAmount() {
    for (int i = 0; i < isCheck.length; i++) {
      if (isCheck[i]) {
        double serviceAmount =
            double.tryParse(parcelController.additionalServiceData[i].amount) ??
                0.0;

        if (i == 2) {
          totalAmount += calculateStairCase(count, serviceAmount);
        } else {
          totalAmount += serviceAmount;
        }
      }
    }

    totalAmount += manPowerHelper;
    totalAmount += totalAmountVehicle;
  }

  List<String> additionalIdsArray = [];
  List<String> additionalQtyArray = [];

  void toggleServiceSelection(int index, StateSetter setState) {
    setState(() {
      isCheck[index] = !isCheck[index];

      AdditionalServiceData serviceData =
          parcelController.additionalServiceData[index];
      var serviceId = serviceData.id;

      if (isCheck[index] == true) {
        if (!additionalIdsArray.contains(serviceId.toString())) {
          additionalIdsArray.add(serviceId.toString());
          additionalQtyArray.add('1');
        }

        if (!selectedvehicleservice.contains(serviceData)) {
          selectedvehicleservice.add(serviceData);
        }
      } else {
        if (additionalIdsArray.contains(serviceId.toString())) {
          int indexArray = additionalIdsArray.indexOf(serviceId.toString());
          additionalIdsArray.removeAt(indexArray);
          additionalQtyArray.removeAt(indexArray);
        }

        selectedvehicleservice
            .removeWhere((item) => item.name == serviceData.name);
      }

      updateVehicleTotalAmount();
      updateTotalAmount();
    });
  }

  void addValue(StateSetter setState) {
    setState(() {
      if (updateValue < maxValue) {
        updateValue++;
        if (updateValue > 0) {
          checkManPower = true;
          showManpower = true;
        }
        updateManpwerTotalAmount(setState);
      }
    });
  }

  void decrementValue(StateSetter setState) {
    setState(() {
      if (updateValue > 0) {
        updateValue--;
        checkManPower = true;
        showManpower = true;
        if (updateValue == 0) {
          checkManPower = false;
          showManpower = false;
        }
        updateManpwerTotalAmount(setState);
      }
    });
  }

  double calculateStairCase(int count, double serviceAmount) {
    return count * serviceAmount;
  }

  // bool stairCheck = false;
  void addCount(StateSetter setState, int index) {
    setState(() {
      if (count < maxCount) {
        count++;
        if (count == 1) {
          // Automatically add the additional service when count becomes 1
          toggleServiceSelection(index, setState);
        }
        if (count > 0) {
          isCheck[index] = true;
        }
      }

      AdditionalServiceData serviceData2 =
          parcelController.additionalServiceData[index];
      var serviceId = serviceData2.id;

      if (additionalIdsArray.contains(serviceId.toString())) {
        int indexArray = additionalIdsArray.indexOf(serviceId.toString());
        additionalQtyArray[indexArray] = count.toString();
      }
      updateTotalAmount();
    });

    print("count----------- $count");

    print("-service stair case add-----$selectedvehicleservice");
  }

  void decrementCount(StateSetter setState, int index) {
    setState(() {
      if (count > 0) {
        count--;
        if (count == 0) {
          // Automatically remove the additional service when count becomes 0
          toggleServiceSelection(index, setState);
        }
        isCheck[index] = true;

        if (count == 0) {
          isCheck[index] = false;
        }

        manPowerCheck = false;
      }

      AdditionalServiceData serviceData1 =
          parcelController.additionalServiceData[index];
      var serviceId = serviceData1.id;

      if (additionalIdsArray.contains(serviceId.toString())) {
        int indexArray = additionalIdsArray.indexOf(serviceId.toString());
        additionalQtyArray[indexArray] = count.toString();
      }

      updateTotalAmount();
    });

    print("decrement count-------- $count");
    print("-service stair case remove-----$selectedvehicleservice");
  }

  bool manPowerCheck = false;

  bool showManpower = false;
  double totalStairCase = 0.0;
  void showListViewDialog(BuildContext context, String modifiedName) {
    initializeIsCheckList();

    parcelController.getAdditionalServices(modifiedName);

    List<AdditionalServiceData> filteredServices = [];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            updateTotalAmount();
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
                              Navigator.of(context).pop();
                            },
                            child: const Icon(
                              Icons.cancel_outlined,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            vehicleItems?.name == "Car"
                                ? Container()
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        checkManPower = !checkManPower;
                                        showManpower = true;
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
                                                    checkManPower =
                                                        !checkManPower;
                                                    showManpower = true;
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
                                                  child: checkManPower
                                                      ? Image.asset(
                                                          "assets/icons/7-Check.png")
                                                      : Text(""),
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                "Manpower (helper)",
                                                style: primaryfont.copyWith(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        decrementValue(
                                                            setState);
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey,
                                                          shape:
                                                              BoxShape.circle),
                                                      child: const Icon(
                                                          Icons.remove,
                                                          size: 16,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  SizedBox(width: 9),
                                                  Text(
                                                    "$updateValue",
                                                    style: primaryfont.copyWith(
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  SizedBox(width: 9),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        addValue(setState);
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 25,
                                                      width: 25,
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey,
                                                          shape:
                                                              BoxShape.circle),
                                                      child: const Icon(
                                                          Icons.add,
                                                          size: 16,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "+\$${manPowerHelper.toStringAsFixed(2)}",
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
                                  ),
                            GetBuilder<ParcelController>(builder: (controller) {
                              filteredServices = controller
                                  .additionalServiceData
                                  .where((serviceData) =>
                                      serviceData.type == modifiedName)
                                  .cast<AdditionalServiceData>()
                                  .toList();
                              if (isCheck.length != filteredServices.length) {
                                isCheck = List<bool>.filled(
                                    filteredServices.length, false);
                              }
                              return ListView.builder(
                                itemCount: filteredServices.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  if (index >= isCheck.length) {
                                    return Container(); // Return an empty widget if index is out of range (should not happen after syncing)
                                  }

                                  AdditionalServiceData serviceData =
                                      filteredServices[index];

                                  totalStairCase = calculateStairCase(
                                      count, double.parse(serviceData.amount));

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        toggleServiceSelection(index, setState);
                                        manPowerCheck = true;
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
                                                onTap: () {},
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
                                                "${serviceData.name}",
                                                style: primaryfont.copyWith(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              // if (index == 2)
                                              if (serviceData.name ==
                                                  "Staircase (per floor)")
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        if (serviceData.name ==
                                                            "Staircase (per floor)") {
                                                          setState(() {
                                                            decrementCount(
                                                                setState,
                                                                index);
                                                          });
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 25,
                                                        width: 25,
                                                        decoration:
                                                            BoxDecoration(
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
                                                      "$count",
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
                                                        if (serviceData.name ==
                                                            "Staircase (per floor)") {
                                                          setState(() {
                                                            addCount(setState,
                                                                index);
                                                          });
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 25,
                                                        width: 25,
                                                        decoration:
                                                            BoxDecoration(
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
                                                "+\$${serviceData.name == "Staircase (per floor)" ? totalStairCase : serviceData.amount}",
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
                      ksizedbox20,
                      TextButton(
                        onPressed: () {
                          print("-----------check2------ $isCheck");

                          bool hasStaircaseService = false;
                          for (int i = 0; i < filteredServices.length; i++) {
                            if (filteredServices[i].name ==
                                    "Staircase (per floor)" &&
                                isCheck[i]) {
                              hasStaircaseService = true;
                              break;
                            }
                          }

                          bool shouldShowAlert =
                              (checkManPower && updateValue == 0) ||
                                  (hasStaircaseService && count == 0);

                          if (shouldShowAlert) {
                            Get.snackbar(
                              "Alert",
                              "Please increase the value for the selected service!",
                              colorText: AppColors.kwhite,
                              backgroundColor: Colors.red,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          } else {
                            setState(() {
                              savedSelectItem =
                                  List.from(selectedvehicleservice);
                            });
                            print("object1234-------------- $savedSelectItem");
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
                                                              // GestureDetector(
                                                              //   onTap: () {
                                                              //     setState(() {
                                                              //       homeController
                                                              //         ..addVehicalEntry();
                                                              //     });
                                                              //   },
                                                              //   child: Icon(
                                                              //     Icons.add,
                                                              //     color: const Color(
                                                              //         0xff0072E8),
                                                              //     size: 17.sp,
                                                              //   ),
                                                              // ),
                                                              // GestureDetector(
                                                              //   onTap: () {
                                                              //     setState(() {
                                                              //       homeController
                                                              //           .addVehicalEntry();
                                                              //       // homeController
                                                              //       //     .addParcelList();
                                                              //     });
                                                              //   },
                                                              //   child: Text(
                                                              //     'Add Location',
                                                              //     style: primaryfont
                                                              //         .copyWith(
                                                              //       fontSize:
                                                              //           15.sp,
                                                              //       fontWeight:
                                                              //           FontWeight
                                                              //               .w500,
                                                              //       color: const Color(
                                                              //           0xff0072E8),
                                                              //     ),
                                                              //   ),
                                                              // ),
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
                                      Obx(() {
                                        if (parcelController
                                            .vehicleTypeLoading.value) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else if (parcelController
                                            .vehicleTypesData.isEmpty) {
                                          return Center(
                                              child: Text(
                                                  "No Vehicle types available."));
                                        } else {
                                          if (!parcelController.vehicleTypesData
                                              .contains(vehicleItems)) {
                                            vehicleItems = null;
                                          }
                                        }
                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 7),
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
                                          child: DropdownButton<
                                              GetVehicleTypeData>(
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
                                                          child:
                                                              SvgPicture.asset(
                                                            vehicleList[
                                                                parcelController
                                                                    .vehicleTypesData
                                                                    .indexOf(
                                                                        type)],
                                                            height: 25,
                                                            width: 25,
                                                          ),
                                                        ),
                                                        Ksizedboxw10,
                                                        Text(
                                                          type.name,
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xff455A64),
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        color:
                                                            Color(0xff455A64),
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

                                                selectedvehicleservice.clear();
                                                savedSelectItem.clear();
                                                isCheck = [];
                                                count = 0;
                                                checkManPower = false;
                                                showManpower = false;
                                                updateValue = 0;
                                                manPowerHelper = 0.0;
                                                additionalIdsArray.clear();
                                                additionalQtyArray.clear();
                                                List<AdditionalServiceData>
                                                    filteredServices =
                                                    parcelController
                                                        .additionalServiceData
                                                        .where((serviceData) =>
                                                            serviceData.type ==
                                                            modifiedName)
                                                        .cast<
                                                            AdditionalServiceData>()
                                                        .toList();

                                                if (isCheck.length !=
                                                    filteredServices.length) {
                                                  isCheck = List<bool>.filled(
                                                      filteredServices.length,
                                                      false);
                                                }

                                                modifiedName = vehicleItemsNames
                                                        ?.toLowerCase()
                                                        .trim() ??
                                                    ""; // Convert to lowercase and trim spaces
                                                if (modifiedName
                                                    .contains("car")) {
                                                  modifiedName = "booking_car";
                                                } else if (modifiedName
                                                    .contains("van")) {
                                                  modifiedName = "booking_van";
                                                } else if (modifiedName
                                                    .contains("lorry")) {
                                                  modifiedName =
                                                      "booking_lorry";
                                                }

                                                print(
                                                    "Vehicle type for API call: $modifiedName");

                                                parcelController
                                                    .getAdditionalServices(
                                                        modifiedName);
                                              });
                                            },
                                          ),
                                        );
                                      }),
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
                                          showListViewDialog(
                                              context, modifiedName);
                                          // if (vehicleItems?.name == "Car") {
                                          //   Get.snackbar(
                                          //       "No additional service for car",
                                          //       "",
                                          //       colorText: AppColors.kwhite,
                                          //       backgroundColor: Colors.red,
                                          //       snackPosition:
                                          //           SnackPosition.BOTTOM);
                                          // } else if (vehicleItems?.name ==
                                          //     null) {
                                          //   Get.snackbar(
                                          //       "Please select the Vehicle service",
                                          //       "",
                                          //       colorText: AppColors.kwhite,
                                          //       backgroundColor: Colors.red,
                                          //       snackPosition:
                                          //           SnackPosition.BOTTOM);
                                          // } else {

                                          // }
                                        },
                                        child: Container(
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
                                                  showListViewDialog(
                                                      context, modifiedName);
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
                                      print(
                                          "staricase------------ $totalStairCase");

                                      if (formKey.currentState!.validate()) {
                                        List<String>
                                            droppingvehivleAddressList =
                                            homeController
                                                .vehicledroppingLocations
                                                .toList();

                                        String dropLocationCount =
                                            droppingvehivleAddressList.length
                                                .toString();

                                        if (widget.vehiclepickupAdress
                                                .isNotEmpty &&
                                            homeController
                                                .vehicledroppingLocations
                                                .isNotEmpty &&
                                            pickTime != null &&
                                            vehicleItems?.name != null &&
                                            formatDateTime.isNotEmpty &&
                                            deliveryNotesController
                                                .text.isNotEmpty) {
                                          print(
                                              "Selected Services and Amounts:");
                                          calculateVehicleDistance()
                                              .then((value) {
                                            List<String> selectedServiceNames =
                                                [];
                                            List<String>
                                                selectedServiceAmounts = [];

                                            Get.find<ParcelController>()
                                                .additionalServiceData
                                                .forEach((serviceData) {
                                              if (selectedvehicleservice
                                                  .contains(serviceData)) {
                                                selectedServiceNames
                                                    .add(serviceData.name);
                                                selectedServiceAmounts
                                                    .add(serviceData.amount);
                                              }
                                            });

                                            Get.to(DriverBookingDetails(
                                              showingManPower:
                                                  showManpower == true
                                                      ? true
                                                      : false,
                                              additionalServiceID:
                                                  additionalIdsArray,
                                              additionalServicequantity:
                                                  additionalQtyArray,
                                              stairCaseTotal: totalStairCase
                                                  .toStringAsFixed(2),

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
