import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:v_export/constant/app_constant.dart';
import 'package:v_export/customer/services/network/start_api_services.dart';

class NetworkProvider extends GetConnect {
  @override
  void onInit() {
    // TODO: implement onInit
    httpClient.baseUrl = AppConstant.baseUrl;
    HttpStatus.unauthorized;
    httpClient.maxAuthRetries = 3;
    httpClient.addRequestModifier((Request request) {
      if (StartupServices.token != null)
        request.headers['Authorization'] = 'Bearer ${StartupServices.token}';
      request.headers['Accept'] = 'application/json';
      return request;
    });

    super.onInit();
  }

  Future<Response> getCommonCall(String url, dynamic data) =>
      post(url, FormData(data));

  // Future<Response> getCommonmapCall(
  //         String path, List<Map<String, dynamic>> data) =>
  //     post(path, data);

  Future<Response> getCommonnormalcell(String path, dynamic data) =>
      post(path, data);

  Future<Response> getCall(String url) => get(url);
}

class NetworkProviderNMC extends GetConnect {
  @override
  void onInit() {
    // TODO: implement onInit
    httpClient.baseUrl = baseUrl;
    HttpStatus.unauthorized;
    httpClient.maxAuthRetries = 3;
    httpClient.addRequestModifier((Request request) {
      return request;
    });

    super.onInit();
  }

  Future<Response> getCommonCall(String url, dynamic data) => post(url, data);

  // Future<Response> getCallQuery(String url, dynamic data) =>
  //     post(url, FormData(data), query: data);

  Future<Response> getCall(String url) => get(url);

  Future<Response> getQuery(String url, dynamic data) => get(url, query: data);
}
