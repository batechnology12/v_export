// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:v_export/customer/controller/auth_controller.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  final AuthController teamandcondition = Get.put(AuthController());
  @override
  void initState() {
    teamandcondition.teamsandcondition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms and Conditions"),
      ),
      body: GetBuilder<AuthController>(builder: (_) {
        return teamandcondition.teamsLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Html(
                    data: teamandcondition.termsAndConditions.value,
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
