import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/customer/controller/account_controller.dart';
import 'package:v_export/customer/controller/auth_controller.dart';
import 'package:v_export/customer/controller/parcel_controller.dart';
import 'package:v_export/customer/views/auth/login/login_screen.dart';
import 'package:v_export/customer/views/bottom_navi_bar/account/chat.dart';
import 'package:v_export/customer/views/bottom_navi_bar/account/corporate_account.dart';
import 'package:v_export/customer/views/bottom_navi_bar/account/edit_profile.dart';
import 'package:v_export/customer/views/bottom_navi_bar/account/refer_friends.dart';
import 'package:v_export/customer/views/bottom_navi_bar/account/settings.dart';
import 'package:v_export/customer/views/bottom_navi_bar/my_list/get_completed_orders_screen.dart';
import 'package:v_export/customer/views/bottom_navi_bar/my_list/my_list.dart';
import 'package:v_export/customer/views/notification/notification_view.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  AccountController accountController = Get.put(AccountController());
  AuthController authController = Get.put(AuthController());
  ParcelController parcelController = Get.put(ParcelController());
  TextEditingController controller = TextEditingController();

  String corporateName = "";
  String bookingID = "";

  @override
  void initState() {
    accountController.getProfile();
    super.initState();
    getID();
    hideCorporateAccount();
  }

  // getData() async {
  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     await getID();
  //     hideCorporateAccount();
  //   });
  // }

  void getID() async {
    final SharedPreferences prefs1 = await SharedPreferences.getInstance();
    String? type1 = prefs1.getString('typeid');

    setState(() {
      bookingID = type1!;
    });
  }

  String type = "";

  void hideCorporateAccount() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? type = prefs.getString('crAccount');

    setState(() {
      type = accountController.getUserData!.role;
    });
  }

  final List accountList = [
    {
      "accountNames": "Your Profile",
      "image": "assets/icons/profile1.png",
    },
    {
      "accountNames": "Booking History",
      "image": "assets/icons/map.png",
    },
    {
      "accountNames": "Corporate account",
      "image": "assets/icons/acc.png",
    },
    {
      "accountNames": "Settings",
      "image": "assets/icons/settings.png",
    },
    {
      "accountNames": "Customer Chat",
      "image": "assets/icons/chat.png",
    },
    {
      "accountNames": "Refer Friends",
      "image": "assets/icons/refer.png",
    },
    {
      "accountNames": "Rate Review",
      "image": "assets/icons/rating.png",
    },
    {
      "accountNames": "Log Out",
      "image": "assets/icons/log.png",
    },
  ];

  File? image;
  final ImagePicker picker = ImagePicker();

  Future<void> editProfileImage() async {
    final XFile? imageFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (imageFile != null && imageFile.path.isNotEmpty) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        compressQuality: 70,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
      );
      if (croppedFile != null) {
        var tempImage = croppedFile.path;
        setState(() {
          image = File(tempImage);
        });
        accountController.editProfilePicture(profilePicture: tempImage);
      } else {
        print("edit picture");
      }
    }
  }

  String capitalize(String input) {
    if (input.isEmpty) return input;

    return input.substring(0, 1).toUpperCase() +
        input.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.kblue,
      appBar: AppBar(
        backgroundColor: AppColors.kblue,
        centerTitle: true,
        leading: Container(),
        title: Text(
          'Account',
          style: primaryfont.copyWith(
              fontSize: 20.sp,
              color: AppColors.kwhite,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          InkWell(
              onTap: () {
                Get.to(NotificationView());
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Image.asset(
                  'assets/icons/notification_icon.png',
                  color: Colors.white,
                ),
              ))
        ],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 80.h),
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Color(0xffF4F8FF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 160, right: 10),
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: accountList.length,
                            itemBuilder: (context, index) {
                              // return Obx(() {
                              // if (accountList[index]["accountNames"] ==
                              //         "Corporate account" &&
                              //     authController.roleName.value == "client") {
                              //   return Container(); // Hide the Corporate Account
                              // }
                              return GestureDetector(
                                onTap: () {
                                  switch (index) {
                                    case 0:
                                      Get.to(EditProfile());
                                      break;
                                    case 1:
                                      // Get.to(GetCompletedScreenData());
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MyOrder(),
                                          settings: RouteSettings(arguments: 1),
                                        ),
                                      );
                                      break;
                                    case 2:
                                      type == "client"
                                          ?
                                          // Container()
                                          Get.snackbar("Alert",
                                              "Corporate account not required.",
                                              colorText: AppColors.kwhite,
                                              backgroundColor: Colors.red,
                                              snackPosition:
                                                  SnackPosition.BOTTOM)
                                          : Get.to(CorporateAccount());
                                      break;
                                    case 3:
                                      Get.to(Settings());
                                      break;
                                    case 4:
                                      Get.to(ChatScreen());
                                      break;
                                    case 5:
                                      Get.to(ReferFriends());
                                      break;
                                    case 6:
                                      ratingPopup();
                                      break;
                                    case 7:
                                      popUp();
                                      break;
                                  }
                                },
                                child: Container(
                                  color: Color(0xffF4F8FF),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                accountList[index]["image"],
                                                height: 20.h,
                                                width: 20.w,
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                accountList[index]
                                                    ["accountNames"],
                                                style: primaryfont.copyWith(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff212121)),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {},
                                                child: const Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 20,
                                                  color: Color(0XFF0072E8),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      ksizedbox10,
                                      Container(
                                        height: 2,
                                        width: size.width,
                                        color:
                                            Color(0xff000000).withOpacity(.20),
                                      ),
                                      ksizedbox15,
                                    ],
                                  ),
                                ),
                              );
                              // });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 200,
            child: Container(),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: GetBuilder<AccountController>(builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          editProfileImage();
                        },
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1,
                              color: const Color.fromRGBO(0, 0, 0, 1),
                            ),
                          ),
                          child: accountController.getUserData == null
                              ? Image.asset(
                                  "assets/icons/Ellipse 26.png",
                                  fit: BoxFit.cover,
                                )
                              : accountController.getUserData!.data.imageUrl ==
                                      ""
                                  ? Image.asset("assets/icons/Ellipse 26.png")
                                  : accountController
                                          .editProfilePictureLoading.value
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Image.network(
                                          accountController
                                              .getUserData!.data.imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                        ),
                      );
                    }),
                  ),
                  GestureDetector(
                    onTap: () {
                      editProfileImage();
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: GestureDetector(
                        onTap: () {
                          editProfileImage();
                        },
                        child: const Icon(Icons.edit,
                            color: Colors.blue, size: 22),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              GetBuilder<AccountController>(builder: (controller) {
                return accountController.getUserData == null
                    ? Text(
                        "",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        capitalize(accountController.getUserData!.data.firstName
                            .toString()),
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      );
              }),
            ],
          ),
        ],
      ),
    );
  }

  popUp() {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25))),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Logout",
                    style: primaryfont.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff212121)),
                  ),
                  ksizedbox5,
                  Text(
                    "Are you sure you want to Logout?",
                    style: primaryfont.copyWith(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff949599)),
                  ),
                  ksizedbox20,
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 50.h,
                            width: 130.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    width: 1, color: Color(0xff0072E8)),
                                color: Colors.white),
                            child: Center(
                              child: Text(
                                "Cancel",
                                style: primaryfont.copyWith(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff0072E8)),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            //  await prefs.clear();
                            await prefs.setString('auth_token', "null");
                            print("token clear--------------");
                            print(prefs);
                            Get.offAll(LoginScreen());
                          },
                          child: Container(
                            height: 50.h,
                            width: 140.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.blue),
                            child: Center(
                              child: Text(
                                "Yes, Logout",
                                style: primaryfont.copyWith(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xffFFFFFF)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  ratingPopup() {
    getID();
    double _ratings = 5.0;
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Rate us experience',
                textAlign: TextAlign.center,
                style: primaryfont.copyWith(
                    fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ),
            Ksizedboxw5,
            Text(
              'Please let us know how do you feel about this app',
              textAlign: TextAlign.center,
              style: primaryfont.copyWith(
                  color: Color(0xff949599),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
            ksizedbox15,
            Center(
              child: RatingBar.builder(
                itemSize: 35,
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                unratedColor: AppColors.kgrey,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                  _ratings = rating;
                },
              ),
            ),
            ksizedbox15,
            Center(
              child: TextField(
                controller: controller,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: "Tell us what you think",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),
              ),
            ),
            ksizedbox10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 40.h,
                    width: 110.w,
                    decoration: BoxDecoration(
                        color: AppColors.kwhite,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(width: 1, color: AppColors.kblue)),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: primaryfont.copyWith(
                            color: AppColors.kblue,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    parcelController.rateDriverApi(
                        bookingID, _ratings.toString(), controller.text);
                    controller.clear();
                    Get.back();
                    Get.rawSnackbar(
                      backgroundColor: Colors.green,
                      messageText: Text(
                        "Thanks for giving your valuable Review",
                        style: TextStyle(color: Colors.white, fontSize: 15.sp),
                      ),
                    );
                  },
                  child: Container(
                    height: 40.h,
                    width: 110.w,
                    decoration: BoxDecoration(
                      color: AppColors.kblue,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        'Submit',
                        style: primaryfont.copyWith(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
