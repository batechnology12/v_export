import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:v_export/customer/model/corporateAccount_model.dart';
import 'package:v_export/customer/model/get_profile_model.dart';
import 'package:v_export/customer/services/network/Account_api_service/corporate_edit_api_service.dart';
import 'package:v_export/customer/services/network/Account_api_service/corporate_profile_api_service.dart';
import 'package:v_export/customer/services/network/Account_api_service/edit_profile_api_service.dart';
import 'package:v_export/customer/services/network/Account_api_service/edit_profile_picture_api_service.dart';
import 'package:v_export/customer/services/network/Account_api_service/update_profile_api_service.dart';
import 'package:v_export/customer/views/bottom_navi_bar/bottomn_navi_bar.dart';

class AccountController extends GetxController {
  ProfileApiServices profileApiServices = ProfileApiServices();
  GetUserModel? getUserData;
  RxBool imageLoading = false.obs;
  RxString checkCorporate = "".obs;
  getProfile() async {
    imageLoading(true);

    dio.Response<dynamic> response = await profileApiServices.getProfile();
    imageLoading(false);

    update();
    print("------profile token--------------------------");
    print(response.data);
    if (response.data["status"] == true) {
      GetUserModel getUserModel = GetUserModel.fromJson(response.data);
      getUserData = getUserModel;
      //  checkCorporate = getUserData.
      update();
    } else {
      Get.rawSnackbar(
        backgroundColor: Colors.red,
        messageText: Text(
          response.data['message'],
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      );
    }
  }

  CorporatEditProfileApiServices corporateprofileApiServices =
      CorporatEditProfileApiServices();

  GetCorporateAccountModelData? getCorporateAccountModelList;

  RxBool corporateLoading = false.obs;
  corporateAccountProfile() async {
    corporateLoading(true);
    dio.Response<dynamic> response =
        await corporateprofileApiServices.getcorporateProfileApi();
    corporateLoading(false);

    if (response.data["status"] == true) {
      GetCorporateAccountModel getCorporateAccountModel =
          GetCorporateAccountModel.fromJson(response.data);
      getCorporateAccountModelList = getCorporateAccountModel.data;
      Get.rawSnackbar(
        backgroundColor: Colors.green,
        messageText: Text(
          response.data['message'],
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      );
      update();
    } else {
      Get.rawSnackbar(
        backgroundColor: Colors.red,
        messageText: Text(
          response.data['message'],
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      );
    }
  }

  UpdateProfileApiService updateProfileApiService = UpdateProfileApiService();
  RxBool profileLoading = false.obs;
  updateProfileUser(
      {required String name,
      required String mail,
      required String phone,
      required String address}) async {
    profileLoading(true);
    dio.Response<dynamic> response = await updateProfileApiService
        .updateProfile(name: name, mail: mail, phone: phone, address: address);

    profileLoading(false);
    print("update profile response---------");
    print(response.data);
    if (response.data["status"] == true) {
      Get.back();
      getProfile();
      Get.rawSnackbar(
        backgroundColor: Colors.green,
        messageText: Text(
          response.data['message'],
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      );
      update();
      Get.back();
    } else {
      Get.rawSnackbar(
        backgroundColor: Colors.red,
        messageText: Text(
          response.data['message'],
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      );
    }
  }

  CorporateUpdateProfileApiService corporateUpdateProfileApiService =
      CorporateUpdateProfileApiService();

  RxBool corporateProfileLoading = false.obs;

  corporateAccountProfileUser(
      {required String companyname,
      required String mail,
      required String phone,
      required String address,
      required String person}) async {
    corporateProfileLoading(true);
    dio.Response<dynamic> response =
        await corporateUpdateProfileApiService.corporateProfile(
            companyname: companyname,
            mail: mail,
            phone: phone,
            address: address,
            person: person);

    if (response.data["status"] == true) {
      Get.offAll(BottomNavigationScreen(indexes: 3));
      corporateAccountProfile();
      // Get.rawSnackbar(
      //   backgroundColor: Colors.green,
      //   messageText: Text(
      //     response.data['message'],
      //     style: TextStyle(color: Colors.white, fontSize: 15.sp),
      //   ),
      // );
      corporateProfileLoading(false);
      update();
      Get.back();
    } else {
      Get.rawSnackbar(
        backgroundColor: Colors.red,
        messageText: Text(
          response.data['message'],
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      );
    }
  }

  EditProfilePictureApiService editProfilePictureApiService =
      EditProfilePictureApiService();

  RxBool editProfilePictureLoading = false.obs;
  editProfilePicture({required String profilePicture}) async {
    editProfilePictureLoading.value = true;
    dio.Response<dynamic> response = await editProfilePictureApiService
        .editProfilePictureUser(profilePicture: profilePicture);
    editProfilePictureLoading.value = false;
    getProfile();
    update();
    if (response.data["status"] == true) {
      Get.rawSnackbar(
        backgroundColor: Colors.green,
        messageText: Text(
          response.data['message'],
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      );
    } else {
      Get.rawSnackbar(
        backgroundColor: Colors.red,
        messageText: Text(
          response.data['message'],
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      );
    }
  }
}
