import 'dart:io';
import 'package:date_format/date_format.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:v_export/customer/controller/parcel_controller.dart';
import 'package:v_export/customer/model/add_booking_parcel_model.dart';
import 'package:v_export/customer/model/additional_service_model.dart';
import 'package:v_export/customer/views/bottom_navi_bar/package_send/booking_details.dart';
import '../../../constant/app_colors.dart';
import '../../../constant/app_font.dart';
import '../../../constant/common_container.dart';
import 'package:intl/intl.dart';

class ScheduleDeliveryScreen extends StatefulWidget {
  String pickupAddress;
  String pickuplatitude;
  String pickuplogitude;
  List<String> droppingLatitude;
  List<String> droppingLogitude;
  List<String> droppingaddress;

  String bookingDate;
  String deliverytype;
  String length;
  String width;
  String height;
  String kg;
  int qty;
  String parcelItems;
  List<String> unitIdBlockId;
  String? pickTimeFrom;
  String? pickTimeTo;
  List<String> pickTimeListFrom;
  List<String> pickTimeListTo;
  String sendername;
  String phonenumber;
  List<String> arpincode;
  List<String> doorname;

  ScheduleDeliveryScreen(
      {super.key,
      required this.pickupAddress,
      required this.pickuplatitude,
      required this.pickuplogitude,
      required this.droppingLatitude,
      required this.droppingLogitude,
      required this.bookingDate,
      required this.deliverytype,
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
      required this.unitIdBlockId,
      required this.sendername,
      required this.phonenumber,
      required this.droppingaddress,
      required this.arpincode,
      required this.doorname});

  @override
  State<ScheduleDeliveryScreen> createState() => _ScheduleDeliveryScreenState();
}

class _ScheduleDeliveryScreenState extends State<ScheduleDeliveryScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      parcelController.getAdditionalServices();
      parcelController.update();
      setState(() {});
    });
  }

  int? selectedId;

  ParcelController parcelController = Get.find<ParcelController>();
  bool ischeck = false;
  bool manpowercheck = false;
  bool postinvoicecheck = false;
  bool staircase = false;
  bool otpverificationcheck = false;
  bool fragilcheck = false;
  bool noadditinalservicecheck = false;

  DateTime selectedDate = DateTime.now();

  // TimeOfDay pickTimes = TimeOfDay.now();
  // TimeOfDay dropTimes = TimeOfDay.now();
  // String pickingTimes = "";
  // String dropingTimes = "";

  // Future displayTimePicker(BuildContext context) async {
  //   var time = await showTimePicker(
  //     context: context,
  //     initialTime: pickTimes,
  //     initialEntryMode: TimePickerEntryMode.input,
  //   );

  //   if (time != null) {
  //     setState(() {
  //       pickTimes = time;
  //     });

  //     print(pickTimes);
  //   }
  // }

  // Future dropTimePicker(BuildContext context) async {
  //   var times = await showTimePicker(
  //     context: context,
  //     initialTime: pickTimes,
  //     initialEntryMode: TimePickerEntryMode.input,
  //   );

  //   if (times != null) {
  //     setState(() {
  //       dropTimes = times;
  //     });

  //     print(dropTimes);
  //   }
  // }

  TimeOfDay? deliveryFromTime;
  TimeOfDay? deliveryToTime;

  void _selectFromTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: deliveryFromTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != deliveryFromTime) {
      setState(() {
        deliveryFromTime = picked;
      });
    }
  }

  void _selectToTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: deliveryToTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != deliveryToTime) {
      setState(() {
        deliveryToTime = picked;
      });
    }
  }

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final formattedTime = DateFormat('h:mm a').format(DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    ));
    return formattedTime;
  }

  var deliverydateController = TextEditingController();
  var delivarytypeController = TextEditingController();
  var parcelsizeController = TextEditingController();
  var parcelkgController = TextEditingController();
  var numberofparcelController = TextEditingController();
  var notesController = TextEditingController();
  var pickuptimeController = TextEditingController();
  var fromtimeController = TextEditingController();
  var totimeController = TextEditingController();

  String formatDateTime = "";

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

  File? image;
  bool ImageHide = false;
  final ImagePicker _picker = ImagePicker();
  String? imagePath;

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      print('Picked file path: ${pickedFile?.path}');

      if (pickedFile != null) {
        setState(() {
          image = File(pickedFile.path);
          imagePath = pickedFile.path;
          ImageHide = true;
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  var signageItems;
  final formKey = GlobalKey<FormState>();

  bool isChecked = false;
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
                                                  ? "Select Date"
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
                                  ksizedbox10,
                                  Text(
                                    'Delivery Timing',
                                    style: primaryfont.copyWith(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff455A64)),
                                  ),
                                  ksizedbox10,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _selectFromTime(context);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(left: 5),
                                          height: 50.h,
                                          width: 130.w,
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
                                                deliveryFromTime == null
                                                    ? 'select time'
                                                    : '${_formatTime(deliveryFromTime!)}',
                                                style: primaryfont.copyWith(
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    _selectFromTime(context);
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
                                          _selectToTime(context);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(left: 5),
                                          height: 50.h,
                                          width: 130.w,
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
                                                deliveryToTime == null
                                                    ? 'select time'
                                                    : '${_formatTime(deliveryToTime!)}',
                                                style: primaryfont.copyWith(
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xff000000)),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    _selectToTime(context);
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
                                        showPickerDialog(context);
                                      },
                                      child: Container(
                                          height: 100.h,
                                          width: size.width,
                                          decoration: BoxDecoration(
                                              color: AppColors.kwhite),
                                          child: Center(
                                            child: ImageHide
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Image Picked',
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
                                                // ? Container(
                                                //     height: 140.h,
                                                //     width: size.width,
                                                //     decoration: BoxDecoration(
                                                //         color: AppColors.kblue),
                                                //     child: Text("Image Picked"),
                                                //   )
                                                // Container(
                                                //     height: 170.h,
                                                //     width: size.width,
                                                //     child: ClipRRect(
                                                //         borderRadius:
                                                //             BorderRadius
                                                //                 .circular(5),
                                                //         child: Image.file(
                                                //           image!,
                                                //           fit: BoxFit.cover,
                                                //         )))
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
                                        'Add deliver note',
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
                                    width: size.width,
                                    decoration:
                                        BoxDecoration(color: AppColors.kwhite),
                                    child: TextFormField(
                                      textAlign: TextAlign.start,
                                      maxLines: 100,
                                      controller: notesController,
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
                                  ksizedbox20,
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
                          //   return Container(
                          //       height: 50.h,
                          //       width: MediaQuery.of(context).size.width,
                          //       child: parcelController.addBookingLoading.isTrue
                          //           ? Container(
                          //               height: 50.h,
                          //               width: size.width,
                          //               decoration: BoxDecoration(
                          //                   color: Color(0xffF4F8FF),
                          //                   borderRadius:
                          //                       BorderRadius.circular(30)),
                          //               child: Center(
                          //                   child: CircularProgressIndicator(
                          //                 color: AppColors.kblue,
                          //               )),
                          //             )
                          //           :
                          GestureDetector(onTap: () {
                            List<int> selectedServiceId = [];
                            selectedServiceId.add(selectedId!);
                            List<Product> products = [
                              Product(
                                  parcelItems: widget.parcelItems,
                                  length: widget.length,
                                  width: widget.width,
                                  height: widget.height,
                                  qty: widget.qty,
                                  kg: widget.kg,
                                  pickupTimeFrom: widget.pickTimeFrom!,
                                  pickupTimeTo: widget.pickTimeTo!,
                                  deliveryDate: formatDateTime,
                                  deliveryTimeFrom:
                                      _formatTime(deliveryFromTime!),
                                  deliveryTimeTo: _formatTime(deliveryToTime!)),
                            ];

                            List<BookingAddress> bookingAddress = [
                              BookingAddress(
                                  customerName: widget.sendername,
                                  customerMobile: widget.sendername,
                                  unitNoBlockNo: widget.doorname,
                                  address: widget.droppingaddress,
                                  postalCode: widget.arpincode,
                                  latitude: widget.droppingLatitude,
                                  longitude: widget.droppingLogitude,
                                  deliveryStatus: "0",
                                  deliveryTimeFrom:
                                      _formatTime(deliveryFromTime!),
                                  deliveryTimeTo: _formatTime(deliveryToTime!)),
                            ];
                            AddBookingParcelModel addBookingParcelModel =
                                AddBookingParcelModel(
                                    pickupAddress: widget.pickupAddress,
                                    deliveryTypeid: widget.deliverytype,
                                    paymentMode: "500",
                                    bookingAmount: "500",
                                    gst: "500",
                                    additionalTotal: "500",
                                    totalAmount: "500",
                                    isRoundTrip: '1',
                                    bookingDate: widget.bookingDate,
                                    pickupTimeFrom: widget.pickTimeFrom!,
                                    pickupTimeTo: widget.pickTimeTo!,
                                    deliveryDate: formatDateTime,
                                    deliveryTimeFrom:
                                        _formatTime(deliveryFromTime!),
                                    deliveryTimeTo:
                                        _formatTime(deliveryToTime!),
                                    latitude: widget.pickuplatitude,
                                    longitude: widget.pickuplogitude,
                                    distance: "30",
                                    bookingType: "parcel",
                                    additionalDetails:
                                        selectedServiceId, ////selectid
                                    notes: "",
                                    products: products,
                                    bookingAddress: bookingAddress,
                                    parcelPhoto: imagePath!);

                            // AddBookingParcelModel(
                            //     latitude: widget.pickuplatitude,
                            //     longitude: widget.pickuplogitude,
                            //     latitudeList: widget.droppingLatitude,
                            //     logitudeList: widget.droppingLogitude,
                            //     bookingDate: widget.bookingDate,
                            //     deliveryTypeid: widget.deliverytype,
                            //     length: widget.length,
                            //     width: widget.width,
                            //     height: widget.height,
                            //     kg: widget.kg,
                            //     qty: widget.qty,
                            //     parcelItem: widget.parcelItems,
                            //     pickupTimeFrom: widget.pickTimeFrom,
                            //     pickupTimeTo: widget.pickTimeTo,
                            //     pickupTimeFromList:
                            //         widget.pickTimeListFrom,
                            //     pickupTimeToList: widget.pickTimeListTo,
                            //     deliveryDate: formatDateTime,
                            //     deliveryDateList: [formatDateTime],
                            //     deliveryTimeFrom: pickTimes.toString(),
                            //     deliveryTimeTo: [dropTimes.toString()],
                            //     deliveryTimeFromList: [pickTimes],
                            //     deliveryTimeToList: [dropTimes],
                            //     parcelPhoto: image,
                            //     notes: notesController.text,
                            //     customerName: [widget.sendername],
                            //     customerMobile: [widget.phonenumber],
                            //     blockNoUnitNo: [widget.doorname],
                            //     address: [widget.droppingaddress],
                            //     postalCode: [widget.arpincode],
                            //     distance: "30",
                            //     //     additionalDetails: "Fragile Item",
                            //     addressDeliveryTimeFromList: [
                            //       pickTimes.toString()
                            //     ],
                            //     addressDeliveryTimeToList: [
                            //       dropTimes.toString()
                            //     ],
                            //     deliveryStatus: ["Pending"],
                            //     additionalDetails: selectedId);
                            parcelController
                                .addBookingParcel(addBookingParcelModel);
                            //   Get.to(BookingDetailsScreen());
                          }, child: Obx(() {
                            return parcelController.addBookingLoading.isTrue
                                ? Container(
                                    height: 50.h,
                                    width: size.width,
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      color: AppColors.kblue,
                                    )),
                                  )
                                : CommonContainer(
                                    name: "Booking Review",
                                  );
                          }))
                          //               );
                          // })
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

  void showListViewDialog(BuildContext context) {
    List<String> list = [
      "Manpower Service",
      "Post Invoice (Ex, Stamp)",
      "Staircase",
      "OTP Verification",
      "Fragile Item",
      "Access restricted area"
    ];

    final ParcelController parcelController1 = Get.find<ParcelController>();
    // List<bool> isCheck = [false, false, false, false, false];
    List<bool> isCheck =
        List<bool>.filled(parcelController.additionalServiceData.length, false);

    int updateValue = 0;
    int maxValue = 3;

    addValue() {
      setState(() {
        if (updateValue < maxValue) {
          updateValue++;
        }
      });
    }

    decrementValue() {
      setState(() {
        if (updateValue > 0) {
          updateValue--;
        }
      });
    }

    int count = 0;
    int maxCount = 12;

    addCount() {
      setState(() {
        if (count < maxCount) {
          count++;
        }
      });
    }

    decrementCount() {
      setState(() {
        if (count > 0) {
          count--;
        }
      });
    }

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
                              Ksizedboxw10,
                              Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Image.asset(
                                  'assets/icons/support_icon.png',
                                ),
                              )
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
                                                      selectedId =
                                                          serviceData.id;
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  height: 20.h,
                                                  width: 20.w,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 1,
                                                          color:
                                                              AppColors.kblue),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: isCheck[index] == true
                                                      ? Image.asset(
                                                          "assets/icons/7-Check.png")
                                                      : Text(""),
                                                ),
                                              ),
                                              Ksizedboxw10,
                                              Text(
                                                controller
                                                    .additionalServiceData[
                                                        index]
                                                    .name,
                                                style: primaryfont.copyWith(
                                                  fontSize: 15.sp,
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
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }));
                            }),
                          ],
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            // if (isChecked == true) {

                            // }

                            Navigator.of(context).pop();
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

  void showPickerDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Photo Library'),
                  onTap: () {
                    pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
                  onTap: () {
                    pickImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}
