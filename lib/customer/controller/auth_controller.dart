import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:dio/dio.dart' as dio;
import 'package:v_export/customer/model/register_person_account_model.dart';
import 'package:v_export/customer/services/network/auth_api_service/register_personal_api_service.dart';
import 'package:v_export/customer/services/network/start_api_services.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';
import 'package:v_export/customer/views/auth/register_account.dart/accounts/personal_account_container.dart';
import 'package:v_export/customer/views/auth/register_account.dart/register_otp.dart';

class AuthController extends GetxController {
  RegisterPersonalApiService registerPersonalApiService =
      RegisterPersonalApiService();

  registerPersonal(RegisterPersonalAccount registerPersonalAccount) async {
    dio.Response<dynamic> response = await registerPersonalApiService
        .registerPersonal(registerPersonalAccount);

    print("register response-----");

    print(response.data);
    if (response.data["status"] == true) {
      Get.rawSnackbar(
        backgroundColor: Colors.green,
        messageText: const Text(
          "Enter the 4 digits OTP",
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      );
      Get.to(RegisterOtpScreen());
    } else {
      Get.rawSnackbar(
        backgroundColor: Colors.red,
        messageText: Text(
          response.data['message'],
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      );
    }
  }

  /////////////////////////////
  RxInt containerindex = 0.obs;

  RxBool isLoading = false.obs;

  void personalAccount({
    required String type,
    required String name,
    required String email,
    required String mobile,
    required String password,
    required String confirmPassword,
  }) {
    StartupServices.networkProvider!.getCommonnormalcell(AppPath.register, {
      "type": type,
      "name": name,
      "email": email,
      "mobile": mobile,
      "password": password,
      "password_confirmation": confirmPassword
    }).then((value) {
      Get.log("response ${value.body}");
      if (value.statusCode == 200) {
        print("TRUE");
      } else {
        print("FALSE");
      }
    });
  }
}
