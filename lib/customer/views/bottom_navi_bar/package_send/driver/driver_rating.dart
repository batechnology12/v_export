import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/constant/app_font.dart';
import 'package:v_export/constant/common_container.dart';

class DriverRating extends StatefulWidget {
  const DriverRating({super.key});

  @override
  State<DriverRating> createState() => _DriverRatingState();
}

class _DriverRatingState extends State<DriverRating> {
  double _rating = 5.0;

  List<String> images = [
    "assets/icons/Group 42032.png",
    "assets/icons/Group 42034.png",
    "assets/icons/Group 42035.png",
    "assets/icons/Group 42036.png",
    "assets/icons/Group 42037.png"
  ];

  List<String> names = ["Very Poor", "Poor", "Good", "Great", "Loved IT!"];

  UpateValues(double rating, List<String> _names, _images) {
    setState(() {
      _rating = rating;

      _names = names;
      _images = images;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Driver Rate',
          style: primaryfont.copyWith(
              fontSize: 23.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.black,
            size: 20.h,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50.h,
              backgroundImage: AssetImage(
                  'assets/icons/Ellipse 26 (1).png'), // Replace with your image asset
            ),
            ksizedbox10,
            Text(
              '2.4 Van',
              style: primaryfont.copyWith(
                  fontSize: 22.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              'GBL3245N',
              style: primaryfont.copyWith(
                  fontSize: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            ksizedbox20,
            Text(
              'How was your Booking with Lee Wong',
              style: primaryfont.copyWith(
                  fontSize: 18.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            ksizedbox20,
            Text(
              'Your overall raiting',
              style: primaryfont.copyWith(
                  fontSize: 16.sp,
                  color: Color(0xffA6A6A6),
                  fontWeight: FontWeight.w600),
            ),
            _rating > 0 ? Image.asset(images[_rating.toInt() - 1]) : Text(""),
            ksizedbox10,
            _rating > 0
                ? Text(
                    names[_rating.toInt() - 1],
                    style: secondoryfont.copyWith(
                        fontSize: 18.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  )
                : Text(
                    "Select a rating",
                    style: secondoryfont.copyWith(
                        fontSize: 18.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
            ksizedbox10,
            RatingBar.builder(
              initialRating: _rating,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (
                double rating,
              ) {
                setState(() {
                  UpateValues(rating, names, images);
                  //  names = rating;
                });
              },
            ),
            ksizedbox10,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Add Details Review",
                  style: secondoryfont.copyWith(
                      fontSize: 15.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            ksizedbox10,
            Container(
              // margin: EdgeInsets.symmetric(horizontal: 15),
              height: 100.h,
              width: size.width,
              decoration: BoxDecoration(
                  color: Color(0xffF8F8F8),
                  borderRadius: BorderRadius.circular(14)),
              child: TextFormField(
                textAlign: TextAlign.start,
                maxLines: 100,
                //  controller: reasonController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, top: 10),
                  hintText: 'Enter here ...',
                  hintStyle: primaryfont.copyWith(
                      color: Color(0xff455A64),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ksizedbox20,
            GestureDetector(
              onTap: () {},
              child: CommonContainer(
                name: "Submit",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
