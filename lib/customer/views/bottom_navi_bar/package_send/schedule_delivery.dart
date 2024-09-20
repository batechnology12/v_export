import 'dart:io';
import 'package:date_format/date_format.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:v_export/customer/controller/home_controller.dart';
import 'package:v_export/customer/controller/parcel_controller.dart';
import 'package:v_export/customer/model/add_booking_parcel_model.dart';
import 'package:v_export/customer/model/additional_service_model.dart';
import 'package:v_export/customer/model/delivery_type_model.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/booking_details.dart';
import '../../../../constant/app_colors.dart';
import '../../../../constant/app_font.dart';
import '../../../../constant/common_container.dart';
import 'package:intl/intl.dart';

class ScheduleDeliveryScreen extends StatefulWidget {
  String pickupAddress;
  String pickuplatitude;
  String pickuplogitude;
  List<String> droppingLatitude;
  List<String> droppingLogitude;
  List<String> droppingaddress;
  String displayTimes;
  String bookingDate;
  String deliverytype;
  int deliVerytypeID;
  List<String> length;
  List<String> width;
  List<String> height;
  List<String> kg;
  List<String> qty;
  String parcelItems;
  String senderunitIdBlockId;
  String? pickTimeFrom;
  String? pickTimeTo;
  List<String> pickTimeListFrom;
  List<String> pickTimeListTo;
  String sendername;
  String phonenumber;
  List<String> arpincode;
  List<String> doorname;
  List<String> receivername;
  List<String> receiverphone;
  List<String> receiverUnitIdBlockId;
  String totalWeight;
  List<DeliveryTypeData> selectedDeliveryTypes = [];
  TimeOfDay deliveryTimeTos;
  TimeOfDay deliveryTimeFroms;
  String roundTrip;
  String parcelKg;
  String parcelQty;
  String senderUnitId;
  List<String> receiverUnitId;
  String pickupPincode;
  List<String> dropPincode;
  String dropStopCount;
  TextEditingController notesController;
  ScheduleDeliveryScreen(
      {super.key,
      required this.notesController,
      required this.dropStopCount,
      required this.pickupPincode,
      required this.dropPincode,
      required this.senderUnitId,
      required this.receiverUnitId,
      required this.roundTrip,
      required this.parcelKg,
      required this.parcelQty,
      required this.deliveryTimeFroms,
      required this.deliveryTimeTos,
      required this.pickupAddress,
      required this.pickuplatitude,
      required this.pickuplogitude,
      required this.droppingLatitude,
      required this.droppingLogitude,
      required this.bookingDate,
      required this.deliverytype,
      required this.deliVerytypeID,
      required this.displayTimes,
      required this.length,
      required this.width,
      required this.height,
      required this.kg,
      required this.qty,
      required this.parcelItems,
      required this.pickTimeFrom,
      required this.pickTimeTo,
      required this.pickTimeListFrom,
      required this.pickTimeListTo,
      required this.senderunitIdBlockId,
      required this.sendername,
      required this.phonenumber,
      required this.droppingaddress,
      required this.arpincode,
      required this.doorname,
      required this.receivername,
      required this.receiverphone,
      required this.receiverUnitIdBlockId,
      required this.totalWeight,
      required this.selectedDeliveryTypes});

  @override
  State<ScheduleDeliveryScreen> createState() => _ScheduleDeliveryScreenState();
}

class _ScheduleDeliveryScreenState extends State<ScheduleDeliveryScreen> {
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    getData();
  }

  double totalAmount = 0.0;
  double totalDistance = 0.0;
  TimeOfDay spselectedTime = TimeOfDay.now();
  TimeOfDay spselectedT0Time = TimeOfDay.now();
  double? storedTotalDistance; // Variable to store the calculated distance
  List<String> dropLocationDistances = [];
  double totalkmDistance = 0.0;
  void getData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      parcelController.getAdditionalServices("booking_parcel");
      initializeIsCheckList();
      // parcelController.update();
      if (widget.deliverytype == "Next day delivery") {
        selectedDate = DateTime.now().add(Duration(days: 1));
      } else {
        selectedDate = DateTime.now();
      }
      formatDateTime = formatDate(selectedDate, [dd, '-', mm, '-', yyyy]);
      // selectDate(context);
      // setState(() {});
    });
  }

  List<AdditionalServiceData> selectedparcelServiceItems = [];
  List<AdditionalServiceData> savedSelectItem1 = [];
  List<bool> isCheck = [];

  void initializeIsCheckList() {
    isCheck =
        List<bool>.filled(parcelController.additionalServiceData.length, false);
    for (int i = 0; i < parcelController.additionalServiceData.length; i++) {
      if (savedSelectItem1
          .contains(parcelController.additionalServiceData[i])) {
        isCheck[i] = true;
      }
    }
    updateTotalAmount();
  }

  void updateTotalAmount() {
    totalAmount = selectedparcelServiceItems.fold(0.0, (sum, item) {
      double itemAmount = double.tryParse(item.amount) ?? 0.0;
      return sum + itemAmount;
    });
  }

  void showListViewDialog(BuildContext context) {
    initializeIsCheckList();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Center(
              child: Dialog(
                insetPadding: EdgeInsets.symmetric(horizontal: 25),
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
                          Row(
                            children: [
                              Text(
                                'Additional Services',
                                style: primaryfont.copyWith(
                                    fontSize: 16.sp,
                                    color: AppColors.kblue,
                                    fontWeight: FontWeight.w600),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 2),
                              //   child: Image.asset(
                              //     'assets/icons/support_icon.png',
                              //   ),
                              // )
                            ],
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
                                itemBuilder: ((context, index) {
                                  AdditionalServiceData serviceData =
                                      controller.additionalServiceData[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(
                                          () {
                                            isCheck[index] = !isCheck[index];
                                            if (isCheck[index] == true) {
                                              selectedparcelServiceItems
                                                  .add(serviceData);
                                            } else {
                                              selectedparcelServiceItems
                                                  .remove(serviceData);
                                            }
                                            updateTotalAmount();
                                          },
                                        );
                                      },
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(
                                                      () {
                                                        isCheck[index] =
                                                            !isCheck[index];

                                                        if (isCheck[index] ==
                                                            true) {
                                                          selectedparcelServiceItems
                                                              .add(serviceData);
                                                        } else {
                                                          selectedparcelServiceItems
                                                              .remove(
                                                                  serviceData);
                                                        }
                                                        updateTotalAmount();
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    height: 18.h,
                                                    width: 18.w,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color: AppColors
                                                                .kblue),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: isCheck[index]
                                                        ? Image.asset(
                                                            "assets/icons/7-Check.png")
                                                        : Text(""),
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  controller
                                                      .additionalServiceData[
                                                          index]
                                                      .name,
                                                  style: primaryfont.copyWith(
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                    "+\$${controller.additionalServiceData[index].amount}",
                                                    style: primaryfont.copyWith(
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              );
                            }),
                          ],
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              savedSelectItem1 =
                                  List.from(selectedparcelServiceItems);
                            });
                            Navigator.of(context).pop(savedSelectItem1);
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
        );
      },
    );
  }

  ParcelController parcelController = Get.put(ParcelController());

  TimeOfDay deliveryFromTime = TimeOfDay.now();
  TimeOfDay deliveryToTime = TimeOfDay.now();

  Future<void> _selectFromTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: widget.deliveryTimeFroms,
    );
    if (picked != null) {
      setState(() {
        widget.deliveryTimeFroms = picked;
      });
    }
  }

  void _selectToTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context, initialTime: widget.deliveryTimeTos);
    if (picked != null) {
      setState(() {
        widget.deliveryTimeTos = picked;
      });
      print("-------------------");
      print(widget.deliveryTimeTos);
    }
  }

  TimeOfDay _addMinutesToTimeOfDay(TimeOfDay time, int minutesToAdd) {
    final now = DateTime.now();
    final currentTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final newTime = currentTime.add(Duration(minutes: minutesToAdd));
    return TimeOfDay(hour: newTime.hour, minute: newTime.minute);
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

  String times = "";
  var deliverydateController = TextEditingController();
  var delivarytypeController = TextEditingController();
  var parcelsizeController = TextEditingController();
  var parcelkgController = TextEditingController();
  var numberofparcelController = TextEditingController();
  var notesController = TextEditingController();
  var pickuptimeController = TextEditingController();
  var fromtimeController = TextEditingController();
  var totimeController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String formatDateTime = "";

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formatDateTime = formatDate(selectedDate, [dd, '-', mm, '-', yyyy]);
        // if (widget.deliverytype == "Next day delivery") {
        //   formatDateTime = formatDate(
        //       selectedDate.add(Duration(days: 1)), [dd, '-', mm, '-', yyyy]);
        // } else {
        //   formatDateTime = formatDate(selectedDate, [dd, '-', mm, '-', yyyy]);
        // }
      });
    }
  }

  File? image;
  bool imageHide = false;
  final ImagePicker _picker = ImagePicker();
  String imagePath = "";

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      print('Picked file path: ${pickedFile?.path}');

      if (pickedFile != null) {
        setState(() {
          image = File(pickedFile.path);
          imagePath = pickedFile.path;
          imageHide = true;
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  var signageItems;

  final formKey = GlobalKey<FormState>();

  bool isChecked = false;

  String _getFromTimeDisplayText() {
    print("sakdksaduasd--------------------weiutwiwgted");
    print(widget.deliveryTimeFroms);
    if (widget.deliverytype == "4 Hours Delivery" ||
        widget.deliverytype == "Express Delivery") {
      return _formatTime(_addMinutesToTimeOfDay(widget.deliveryTimeFroms, 60));
    } else if (widget.deliverytype == "Same day delivery" ||
        widget.deliverytype == "Next day delivery") {
      return _formatTime(const TimeOfDay(hour: 8, minute: 0));
    } else {
      return widget.deliveryTimeFroms == TimeOfDay.now()
          ? "Select time"
          : _formatTime(widget.deliveryTimeFroms);
    }
  }

  String _getToTimeDisplayText() {
    print(_formatTime(TimeOfDay.now()));
    if (widget.deliverytype == "4 Hours Delivery" ||
        widget.deliverytype == "Express Delivery") {
      return _formatTime(_addMinutesToTimeOfDay(widget.deliveryTimeTos, 60));
    } else if (widget.deliverytype == "Same day delivery") {
      return _formatTime(const TimeOfDay(hour: 20, minute: 0));
    } else if (widget.deliverytype == "Next day delivery") {
      return _formatTime(const TimeOfDay(hour: 21, minute: 0));
    } else {
      return "Select time";
    }
  }

  Future<void> _selectTimeforspcipc(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: spselectedTime,
    );

    if (pickedTime != null && pickedTime != spselectedTime) {
      setState(() {
        spselectedTime = pickedTime;
      });
    }
  }

  Future<void> _selectTimeforspT0(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: spselectedT0Time,
    );

    if (pickedTime != null && pickedTime != spselectedT0Time) {
      setState(() {
        spselectedT0Time = pickedTime;
      });
    }
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
            Get.back();
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
                              left: 10,
                              right: 10,
                              top: 15,
                            ),
                            child: Container(
                              padding:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                              margin: EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                  color: AppColors.kwhite,
                                  boxShadow: const <BoxShadow>[
                                    BoxShadow(
                                        offset: Offset(0.0, 0.75),
                                        blurRadius: 2,
                                        color: AppColors.kgrey)
                                  ],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ksizedbox5,

                                  Text(
                                    'Delivery Details',
                                    style: primaryfont.copyWith(
                                        fontSize: 17.sp,
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w700),
                                  ),

                                  ksizedbox20,
                                  Row(
                                    children: [
                                      Text(
                                        'Delivery Date',
                                        style: primaryfont.copyWith(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff455A64)),
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
                                  GestureDetector(
                                    onTap: () {
                                      if (widget.deliverytype ==
                                              "Next day delivery" ||
                                          widget.deliverytype ==
                                              "Specific Time") {
                                        selectDate(context);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(
                                                "Date cannot be changed for this delivery"),
                                          ),
                                        );
                                      }
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
                                                  ? (widget.deliverytype ==
                                                          "Next day delivery"
                                                      ? formatDate(
                                                          DateTime.now().add(
                                                              Duration(
                                                                  days: 0)),
                                                          [
                                                              dd,
                                                              '-',
                                                              mm,
                                                              '-',
                                                              yyyy
                                                            ])
                                                      : formatDate(
                                                          DateTime.now(), [
                                                          dd,
                                                          '-',
                                                          mm,
                                                          '-',
                                                          yyyy
                                                        ]))
                                                  : formatDateTime,
                                              style: primaryfont.copyWith(
                                                color: Color(0xff455A64),
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  if (widget.deliverytype ==
                                                      "Next day delivery") {
                                                    // Show Snackbar if the delivery type is "Next day delivery"
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        backgroundColor:
                                                            Colors.red,
                                                        content: Text(
                                                            "Date cannot be changed for Next day delivery"),
                                                      ),
                                                    );
                                                  } else {
                                                    selectDate(context);
                                                  }
                                                },
                                                child: Image.asset(
                                                    "assets/icons/date.png")),
                                          ],
                                        )),
                                  ),
                                  ksizedbox10,
                                  Text(
                                    'Delivery Timing',
                                    style: primaryfont.copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff455A64)),
                                  ),
                                  ksizedbox10,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      widget.deliverytype == "Specific Time"
                                          ? GestureDetector(
                                              onTap: () {
                                                _selectTimeforspcipc(context);
                                                //   _selectFromTime(context);
                                              },
                                              child: Container(
                                                padding:
                                                    EdgeInsets.only(left: 15),
                                                height: 50.h,
                                                width: 130.w,
                                                decoration: BoxDecoration(
                                                    color: AppColors.kwhite,
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.grey
                                                            .withOpacity(.32)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      spselectedTime ==
                                                              TimeOfDay.now()
                                                          ? "Select Time"
                                                          : _formatTime(
                                                              spselectedTime),
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    backgroundColor: Colors.red,
                                                    content: Text(
                                                        "Date cannot be changed for Delivery timings"),
                                                  ),
                                                );
                                                // if ((widget.deliverytype !=
                                                //         "Same day delivery" &&
                                                //     widget.deliverytype !=
                                                //         "Next day delivery")) {
                                                //   _selectFromTime(context);
                                                // }
                                                //   _selectFromTime(context);
                                              },
                                              child: Container(
                                                padding:
                                                    EdgeInsets.only(left: 15),
                                                height: 50.h,
                                                width: 130.w,
                                                decoration: BoxDecoration(
                                                    color: AppColors.kwhite,
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.grey
                                                            .withOpacity(.32)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      _getFromTimeDisplayText(),
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.black),
                                                    ),
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
                                      widget.deliverytype == "Specific Time"
                                          ? GestureDetector(
                                              onTap: () {
                                                _selectTimeforspT0(context);
                                                //   _selectFromTime(context);
                                              },
                                              child: Container(
                                                padding:
                                                    EdgeInsets.only(left: 15),
                                                height: 50.h,
                                                width: 130.w,
                                                decoration: BoxDecoration(
                                                    color: AppColors.kwhite,
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.grey
                                                            .withOpacity(.32)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      spselectedT0Time ==
                                                              TimeOfDay.now()
                                                          ? "Select Time"
                                                          : _formatTime(
                                                              spselectedT0Time),
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    backgroundColor: Colors.red,
                                                    content: Text(
                                                        "Date cannot be changed for Delivery timings"),
                                                  ),
                                                );
                                                // if ((widget.deliverytype !=
                                                //         "Same day delivery" &&
                                                //     widget.deliverytype !=
                                                //         "Next day delivery")) {
                                                //   _selectToTime(context);
                                                // }
                                                //   _selectToTime(context);
                                              },
                                              child: Container(
                                                padding:
                                                    EdgeInsets.only(left: 15),
                                                height: 50.h,
                                                width: 130.w,
                                                decoration: BoxDecoration(
                                                    color: AppColors.kwhite,
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.grey
                                                            .withOpacity(.32)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      _getToTimeDisplayText(),
                                                      style:
                                                          primaryfont.copyWith(
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: Color(
                                                                  0xff000000)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                  ksizedbox10,
                                  ksizedbox5,
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
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff455A64)),
                                          ),
                                          Icon(
                                            Icons.help_outline,
                                            size: 20,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  ksizedbox15,
                                  DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(10),
                                    dashPattern: [6, 6],
                                    color: Color(0xff0080FF),
                                    child: InkWell(
                                      onTap: () {
                                        //  showPickerDialog(context);
                                        pickImage(ImageSource.camera);
                                        // Navigator.of(context).pop();
                                      },
                                      child: Container(
                                          height: 100.h,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                              color: AppColors.kwhite),
                                          child: Center(
                                            child: imageHide
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Image Uploaded',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 22.sp,
                                                          color:
                                                              Color(0xff0080FF),
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
                                                                  .only(top: 2),
                                                          child: Text(
                                                            'Upload Product Picture',
                                                            style: primaryfont.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14.sp,
                                                                color: AppColors
                                                                    .kblue),
                                                          ),
                                                        )
                                                      ]),
                                          )),
                                    ),
                                  ),
                                  ksizedbox10,
                                  Row(
                                    children: [
                                      Text(
                                        'Add Delivery Notes',
                                        style: primaryfont.copyWith(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
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
                                  ksizedbox10,
                                  Container(
                                    height: 100.h,
                                    width: MediaQuery.of(context).size.width,
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: TextFormField(
                                      textAlign: TextAlign.start,
                                      maxLines: 100,
                                      controller: widget.notesController,
                                      decoration: InputDecoration(
                                        hintText: 'Type here notes...',
                                        hintStyle: TextStyle(
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
                                  ksizedbox20,
                                  ///
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
                                          onTap: () {
                                            showListViewDialog(context);
                                          },
                                          child: const Icon(
                                            Icons.arrow_circle_right_outlined,
                                            color: AppColors.kblue,
                                            size: 30,
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
                          ksizedbox20,
                          // Obx(() {
                          //   return
                          GestureDetector(
                            onTap: () async {
                              print("services data............");
                              print(selectedparcelServiceItems);
                              print("checkTime");
                              print(
                                _getFromTimeDisplayText(),
                              );
                              print(_getToTimeDisplayText());
                              print("checckfdate");
                              print(
                                formatDateTime.isEmpty
                                    ? (widget.deliverytype ==
                                            "Next day delivery"
                                        ? formatDate(
                                            DateTime.now()
                                                .add(Duration(days: 1)),
                                            [dd, '-', mm, '-', yyyy])
                                        : formatDate(DateTime.now(),
                                            [dd, '-', mm, '-', yyyy]))
                                    : formatDateTime,
                              );
                              if (widget.notesController.text.isNotEmpty &&
                                  _getFromTimeDisplayText().isNotEmpty &&
                                  _getToTimeDisplayText().isNotEmpty) {
                                calculateDistance().then(
                                  (value) {
                                    Get.to(() => BookingDetailsScreen(
                                          kilometers: dropLocationDistances,
                                          totalKMDistance: totalkmDistance,
                                          dropStopCounts: widget.dropStopCount,
                                          pickupPOSTALCODE:
                                              widget.pickupPincode,
                                          dropPOSTALCODE: widget.dropPincode,
                                          receiverunitId: widget.receiverUnitId,
                                          unitId: widget.senderUnitId,
                                          parcelofKg: widget.parcelKg,
                                          parcelofQty: widget.parcelQty,
                                          roundtrip: widget.roundTrip,
                                          totalWeights: widget.totalWeight,
                                          additionalservicetotalAmount:
                                              totalAmount.toString(),
                                          distance:
                                              storedTotalDistance.toString(),
                                          selectedParcelservice:
                                              selectedparcelServiceItems,
                                          pickupADDRESS: widget.pickupAddress,
                                          pickpLATITUDE: widget.pickuplatitude,
                                          pickupLOGITUDE: widget.pickuplogitude,
                                          droppingLATITUDE:
                                              widget.droppingLatitude,
                                          droppingLOGITUDE:
                                              widget.droppingLogitude,
                                          droppingADDRESS:
                                              widget.droppingaddress,
                                          bookingDATE: widget.bookingDate,
                                          deliveryTYPE: widget.deliverytype,
                                          deliveryTypeID: widget.deliVerytypeID,
                                          parcelLengtH: widget.length,
                                          parcelWidth: widget.width,
                                          parcelHeight: widget.height,
                                          parcelKg: widget.kg,
                                          parcelQty: widget.qty,
                                          parcelITEMS: widget.parcelItems,
                                          senderunitIdBlockID:
                                              widget.senderunitIdBlockId,
                                          pickTimeFROM: widget.pickTimeFrom!,
                                          pickTimeTO: widget.pickTimeTo!,
                                          pickTimeListFROM:
                                              widget.pickTimeListFrom,
                                          pickTimeListTO: widget.pickTimeListTo,
                                          senderNAME: widget.sendername,
                                          phoneNUMBER: widget.phonenumber,
                                          arpinCODE: widget.arpincode,
                                          doorNAME: homeController.doornames,
                                          receiverNAME:
                                              homeController.receiverNameList,
                                          receiverPHONE:
                                              homeController.receiverNumberList,
                                          receiverUnitIdBlockID: homeController
                                              .receiverBlockIdUnitIDs,
                                          deliveyDate: formatDateTime.isEmpty
                                              ? (widget.deliverytype ==
                                                      "Next day delivery"
                                                  ? formatDate(
                                                      DateTime.now().add(
                                                          Duration(days: 1)),
                                                      [dd, '-', mm, '-', yyyy])
                                                  : formatDate(DateTime.now(),
                                                      [dd, '-', mm, '-', yyyy]))
                                              : formatDateTime,
                                          deliveryTimeFROM:
                                              widget.deliverytype ==
                                                      "Specific Time"
                                                  ? _formatTime(spselectedTime)
                                                  : _getFromTimeDisplayText(),
                                          deliveryTimeTO: widget.deliverytype ==
                                                  "Specific Time"
                                              ? _formatTime(spselectedT0Time)
                                              : _getToTimeDisplayText(),
                                          imagePath:
                                              imagePath == "" ? "" : imagePath,
                                          notes: widget.notesController.text,
                                          selectedDeliveryTypes:
                                              widget.selectedDeliveryTypes,
                                        ));
                                  },
                                );

                                print(widget.pickupPincode);
                                print(widget.dropPincode);
                              } else {
                                Get.snackbar(
                                  "Fill all Fields",
                                  "Please try again!",
                                  colorText: AppColors.kwhite,
                                  backgroundColor: Colors.red,
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              }
                            },
                            child: CommonContainer(
                              name: "Booking Review",
                            ),
                          ),

                          //  }),
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

  Future<void> calculateDistance() async {
    // List<String> dropLocationDistances = [];

    // Check if the distance has already been calculated
    if (storedTotalDistance == null) {
      double totalDistance = 0.0;

      // Calculate distance from pickup to the first dropping location
      await parcelController.getKiloMeterApi(
        lat1: double.parse(widget.pickuplatitude),
        lon1: double.parse(widget.pickuplogitude),
        lat2: double.parse(widget.droppingLatitude[0]),
        lon2: double.parse(widget.droppingLogitude[0]),
        unit: "k",
      );
      totalDistance += parcelController.distance;

      String firstDistanceString = parcelController.distance.toString();
      print(
          "Pickup to first drop location distance = ${parcelController.distance}");
      print("distancepickupString------ $firstDistanceString");
      dropLocationDistances.add(firstDistanceString);

      // Calculate distance between each pair of dropping locations
      if (widget.droppingLatitude.length > 1) {
        for (int i = 0; i < widget.droppingLatitude.length - 1; i++) {
          await parcelController.getKiloMeterApi(
            lat1: double.parse(widget.droppingLatitude[i]),
            lon1: double.parse(widget.droppingLogitude[i]),
            lat2: double.parse(widget.droppingLatitude[i + 1]),
            lon2: double.parse(widget.droppingLogitude[i + 1]),
            unit: "k",
          );
          totalDistance += parcelController.distance;

          String distanceString =
              "${i + 1} to Drop location ${i + 2} distance = ${parcelController.distance}";
          distanceString = parcelController.distance.toString();
          print("distanceDropString----- $distanceString");
          dropLocationDistances.add(distanceString);
        }
      }
      totalkmDistance = dropLocationDistances
          .map((distance) => double.parse(distance))
          .reduce((a, b) => a + b);
      // Store the calculated total distance
      storedTotalDistance = totalDistance;
      print("Total distance = $totalDistance");
    } else {
      // Use the stored distance
      print("Using stored distance = $storedTotalDistance");
    }

    // Optional: Print the list of distances between each drop location
    print("List of drop location distances: $dropLocationDistances");
  }
}
