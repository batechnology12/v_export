import 'dart:io';

import 'package:v_export/customer/model/register_person_business_account_model.dart';
import 'package:v_export/customer/services/utils/base_url_api.dart';
import 'package:dio/dio.dart';

class RegisterBusinessApiService extends BaseApiServices {
  Future registerBusiness(
      RegisterBusinessAccount registerBusinessAccount) async {
    dynamic responsJson;
    try {
      var dio = Dio();
      var response = await dio.post(registerBusinessAccountUrl,
          options: Options(
              headers: {'Content-Type': 'application/json'},
              followRedirects: false,
              validateStatus: (status) {
                return status! <= 500;
              }),
          data: {
            "type": "business",
            "company_name": registerBusinessAccount.companyName,
            "business_email_id": registerBusinessAccount.emailId,
            "phone": registerBusinessAccount.mobile,
            "password": registerBusinessAccount.businessPassword,
            "password_confirmation":
                registerBusinessAccount.businessConfirmPassword,
            "contact_person_name": registerBusinessAccount.contactPerson,
            "industry": registerBusinessAccount.industry,
            "industry_no_of_delivery_in_month":
                registerBusinessAccount.noofPersonal
          });
      responsJson = response;
    } on SocketException {
      print("No Internet");
    }
    return responsJson;
  }
}
