// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:v_export/customer/controller/auth_controller.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenScreenState();
}

class _PrivacyPolicyScreenScreenState extends State<PrivacyPolicyScreen> {
  final AuthController authController = Get.put(AuthController());
  @override
  void initState() {
    authController.privacyPolicyApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy"),
      ),
      body: GetBuilder<AuthController>(builder: (_) {
        return authController.policyLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Html(
                    data: "",
                    style: {
                      "p": Style(
                        fontSize: FontSize(15.0),
                        lineHeight: LineHeight(1.0),
                      ),
                    },
                  ),
                ),
              );
      }),
    );
  }
}
