import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:dio/dio.dart' as dio;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_export/constant/app_constant.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/customer/model/login_model.dart';
import 'package:v_export/customer/model/register_person_business_account_model.dart';
import 'package:v_export/customer/services/network/auth_api_service/check_corporate_mail_api_service.dart';
import 'package:v_export/customer/services/network/auth_api_service/check_corporate_mobile_api_service.dart';
import 'package:v_export/customer/services/network/auth_api_service/check_mail%20_api_service.dart';
import 'package:v_export/customer/services/network/auth_api_service/check_mobile_api_service.dart';
import 'package:v_export/customer/services/network/auth_api_service/forget_password_api_service.dart';
import 'package:v_export/customer/services/network/auth_api_service/login_api_service.dart';
import 'package:v_export/customer/services/network/auth_api_service/new_password_api_service.dart';
import 'package:v_export/customer/services/network/auth_api_service/privacy_policy_api_service.dart';
import 'package:v_export/customer/services/network/auth_api_service/register_business_api_service.dart';
import 'package:v_export/customer/services/network/auth_api_service/register_business_otp_api_service.dart';
import 'package:v_export/customer/services/network/auth_api_service/register_personal_otp_service.dart';
import 'package:v_export/customer/services/network/auth_api_service/register_personal_api_service.dart';
import 'package:v_export/customer/services/network/auth_api_service/terms_and_conditions_api_service.dart';
import 'package:v_export/customer/services/network/auth_api_service/verification_otp_api_service.dart';
// import 'package:v_export/customer/services/network/start_api_services.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';
import 'package:v_export/customer/views/auth/login/forgot/create_new_password.dart';
import 'package:v_export/customer/views/auth/login/forgot/verified_password.dart';
import 'package:v_export/customer/views/auth/login/login_screen.dart';
import 'package:v_export/customer/views/auth/register_account.dart/accounts/personal_account_container.dart';
import 'package:v_export/customer/views/auth/register_account.dart/register_business_otp.dart';
import 'package:v_export/customer/views/auth/register_account.dart/register_personal_otp.dart';
import 'package:v_export/customer/views/bottom_navi_bar/bottomn_navi_bar.dart';

class AuthController extends GetxController {
  RxInt containerindex = 0.obs;

  /////////////////////////////
  RxBool isLoading = false.obs;
  RegisterPersonalApiService registerPersonalApiService =
      RegisterPersonalApiService();

  registerPersonal(RegisterPersonalAccount registerPersonalAccount) async {
    isLoading(true);
    dio.Response<dynamic> response = await registerPersonalApiService
        .registerPersonal(registerPersonalAccount);
    print("register response-----");
    print(response.data);
    isLoading(false);
    if (response.data["status"] == true) {
      Get.rawSnackbar(
        backgroundColor: Colors.green,
        messageText: Text(
          response.data['message'],
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      );
      Get.to(RegisterPersonalOtpScreen(
        mobile: registerPersonalAccount.phone!,
      ));
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

  RegisterPersonalOtpApiService registerOtpApiService =
      RegisterPersonalOtpApiService();
  RxBool personalOtpLoading = false.obs;
  resgisterPersonalOtpUser(String phone, String otp) async {
    personalOtpLoading(true);
    dio.Response<dynamic> response =
        await registerOtpApiService.registerOtpUser(phone, otp);
    personalOtpLoading(false);
    if (response.data["status"] == true) {
      AppSnackBar.showSnackbar(
        headText: response.data['message'],
        content: "Signing in...",
        position: SnackPosition.BOTTOM,
      );

      Get.offAll(BottomNavigationScreen(indexes: 0));

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("auth_token", response.data["token"]);
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

  RegisterBusinessApiService registerBusinessApiService =
      RegisterBusinessApiService();
  RxBool businessLoading = false.obs;
  RxString registerToken = "".obs;
  registerBusiness(RegisterBusinessAccount registerBusinessAccount) async {
    businessLoading(true);
    dio.Response<dynamic> response = await registerBusinessApiService
        .registerBusiness(registerBusinessAccount);
    businessLoading(false);
    if (response.data["status"] == true) {
      Get.rawSnackbar(
        backgroundColor: Colors.green,
        messageText: Text(
          response.data['message'],
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      );

      registerToken.value = response.data["token"];
      final SharedPreferences typeName = await SharedPreferences.getInstance();
      await typeName.setString("crAccount", registerToken.value);
      print("register token ----- $registerToken");

      Get.to(RegisterBusinessOtpScreen(
        mobile: registerBusinessAccount.mobile!,
      ));
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

  RegisterBusinessOtpApiService registerBusinessOtpApiService =
      RegisterBusinessOtpApiService();
  RxBool businessOtpLoading = false.obs;
  registerBusinessOtpUser(String phone, String otp) async {
    businessOtpLoading(true);
    dio.Response<dynamic> response =
        await registerBusinessOtpApiService.registerBusinessOtpUser(phone, otp);
    businessOtpLoading(false);
    if (response.data["status"] == true) {
      AppSnackBar.showSnackbar(
        headText: response.data['message'],
        content: "Signing in...",
        position: SnackPosition.BOTTOM,
      );
      Get.offAll(BottomNavigationScreen(
        indexes: 0,
      ));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("auth_token", response.data["token"]);
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

  LoginApiServices loginApiServices = LoginApiServices();
  RxBool loginLoading = false.obs;
  LoginData? loginData;
  RxString roleName = "".obs;

  loginApi(
      {required String emailOrmobileNmuber, required String password}) async {
    loginLoading(true);
    dio.Response<dynamic> response = await loginApiServices.loginApi(
        emailOrmobileNmuber: emailOrmobileNmuber, password: password);
    print("---- login api----");
    print(response.data);
    loginLoading(false);
    if (response.data["status"] == true) {
      LoginModel loginModel = LoginModel.fromJson(response.data);
      loginData = loginModel.user;
      roleName.value = loginModel.user.roles;

      print("rolename====");
      print(roleName.value);
      final SharedPreferences typeName = await SharedPreferences.getInstance();
      await typeName.setString("type", roleName.value);

      if (loginData!.roles == "client" || loginData!.roles == "business") {
        print("name--------------");
        print(typeName);
        print("login type name");
        print(loginData!.roles);
        Get.offAll(BottomNavigationScreen(
          indexes: 0,
        ));
      } else {
        Get.rawSnackbar(
          backgroundColor: Colors.red,
          messageText: Text(
            "Please login with client or business account",
            style: TextStyle(color: Colors.white, fontSize: 15.sp),
          ),
        );
      }
      print("----auth_token-------------");
      print(response.data["token"]);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("auth_token", response.data["token"]);
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

  ForgetPasswordApiService forgetPasswordApiService =
      ForgetPasswordApiService();
  RxBool forgetPasswordLoading = false.obs;
  forgetPassword(String emailOrPhoneNumber) async {
    forgetPasswordLoading(true);
    dio.Response<dynamic> response =
        await forgetPasswordApiService.forgetPassword(emailOrPhoneNumber);
    forgetPasswordLoading(false);
    if (response.data["status"] == true) {
      Get.rawSnackbar(
        backgroundColor: Colors.green,
        messageText: Text(
          response.data['message'],
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      );
      Get.to(VerifiedPasswordScreen(
        mobileNumber: emailOrPhoneNumber,
      ));
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

  VerificationOtpApiService verificationOtpApiService =
      VerificationOtpApiService();
  RxBool verificationOtpLoading = false.obs;
  verificationOtp(String phone, String otp) async {
    verificationOtpLoading(true);
    dio.Response<dynamic> response =
        await verificationOtpApiService.verificationOtp(phone, otp);
    verificationOtpLoading(false);
    if (response.data["status"] == true) {
      Get.rawSnackbar(
        backgroundColor: Colors.green,
        messageText: Text(
          response.data['message'],
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      );
      Get.to(CreatePasswordScreen());
      //   final SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString("auth_token", response.data["token"]);
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

  NewPasswordApiService newPasswordApiService = NewPasswordApiService();
  RxBool newPasswordLoading = false.obs;
  newPassword(String newPassword, String confirmPassword) async {
    newPasswordLoading(true);

    dio.Response<dynamic> response =
        await newPasswordApiService.newPassword(newPassword, confirmPassword);
    newPasswordLoading(false);
    if (response.data["status"] == true) {
      Get.rawSnackbar(
        backgroundColor: Colors.green,
        messageText: Text(
          response.data['message'],
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      );
      Get.offAll(LoginScreen());
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

  Teamandcondition teamsandconditionservec = Teamandcondition();
  RxBool teamsLoading = false.obs;
  var termsAndConditions = "".obs;
  teamsandcondition() async {
    teamsLoading.value = true;
    dio.Response<dynamic> response =
        await teamsandconditionservec.teamscondition();

    if (response.data["success"] == true) {
      print(response.data);
      termsAndConditions.value = response.data["data"];
      print(termsAndConditions.value);
      teamsLoading.value = false;
      update();
    } else {
      teamsLoading.value = false;
      update();
      Get.rawSnackbar(
        backgroundColor: Colors.red,
        messageText: Text(
          response.data['message'],
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      );
    }
  }

  PrivacyPolicy privacyPolicy = PrivacyPolicy();
  RxBool policyLoading = false.obs;
  var privacy_Policy = "".obs;

  privacyPolicyApi() async {
    policyLoading.value = true;
    dio.Response<dynamic> response = await privacyPolicy.privacyPolicy();
    if (response.data["success"] == true) {
      print(response.data);
      privacy_Policy.value = response.data["data"];
      print(termsAndConditions.value);
      policyLoading.value = false;
      update();
    } else {
      policyLoading.value = false;
      update();
      Get.rawSnackbar(
        backgroundColor: Colors.red,
        messageText: Text(
          response.data['message'],
          style: TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      );
    }
  }

  CheckEmailExistsApiService checkEmailExistsApiService =
      CheckEmailExistsApiService();
  TextEditingController emailcontroller = TextEditingController();
  // TextEditingController businessemailidController = TextEditingController();
  RxBool checkmailLoading = false.obs;
  checkMailApi(String email) async {
    // checkmailLoading(true);
    dio.Response<dynamic> response =
        await checkEmailExistsApiService.checkEmailApi(email: email);
    if (response.data["status"] == true) {
      checkmailLoading(true);
      update();
    } else {
      checkmailLoading(false);
      print('mail Id not avilable');
    }
    update();
  }

  CheckMobileExistApiService checkMobileExistApiService =
      CheckMobileExistApiService();

  TextEditingController mobileController = TextEditingController();

  RxBool checkMobileLoading = false.obs;

  checkMoobileApi(String mobile) async {
    dio.Response<dynamic> response =
        await checkMobileExistApiService.checkMobileApi(mobile: mobile);
    if (response.data["status"] == true) {
      checkMobileLoading(true);
      update();
    } else {
      checkMobileLoading(false);
      print('Mobile Number not avilable');
    }
    update();
  }

  CheckCorporateEmailExistsApiService checkCorporateEmailExistsApiService =
      CheckCorporateEmailExistsApiService();

  TextEditingController businessemailidController = TextEditingController();
  RxBool checkcorporatemailLoading = false.obs;
  checkcorporateMailApi(String email) async {
    // checkmailLoading(true);
    dio.Response<dynamic> response = await checkCorporateEmailExistsApiService
        .checkcorporateEmailApi(email: email);
    if (response.data["status"] == true) {
      checkcorporatemailLoading(true);
      update();
    } else {
      checkcorporatemailLoading(false);
      print('mail Id not avilable');
    }
    update();
  }

  CheckCorporateMobileExistApiService checkCorporateMobileExistApiService =
      CheckCorporateMobileExistApiService();

  TextEditingController businessphoneController = TextEditingController();

  RxBool checkcorporateMobileLoading = false.obs;

  checkcorporateMobileApi(String mobile) async {
    dio.Response<dynamic> response = await checkCorporateMobileExistApiService
        .checkCorporateMobileApi(mobile: mobile);
    if (response.data["status"] == true) {
      checkcorporateMobileLoading(true);
      update();
    } else {
      checkcorporateMobileLoading(false);
      print('Mobile Number not avilable');
    }
    update();
  }
}
