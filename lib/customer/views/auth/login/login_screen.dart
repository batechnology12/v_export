import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:svg_flutter/svg_flutter.dart';
import 'package:v_export/constant/app_colors.dart';
import 'package:v_export/customer/views/auth/login/forgot/forgot_password.dart';

import '../../../../constant/app_font.dart';
import '../../../../constant/common_container.dart';
import '../../home/home_screen.dart';
import '../register_account.dart/register_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

bool ishide = false;
bool ischeck = false;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    ishide = true;
  }

var mobileController = TextEditingController();
var passwordController = TextEditingController();

final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
     backgroundColor: AppColors.kblue,
     body: SafeArea(
       child: Form(
        key: formkey,
         child: Stack(
          children: [
          Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
               decoration: BoxDecoration(
                       color: AppColors.kblue,
                       
               ),
                 child: Center(
                  child:SvgPicture.asset('assets/images/splashimage.svg'),
                 ),
                ),
              ),
               Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
               color: AppColors.kwhite,
               boxShadow: <BoxShadow>[
                BoxShadow(
                  offset: Offset(0.0, 0.75),
                  blurRadius: 5,
                  color: AppColors.kgrey
                )
               ],
               borderRadius: BorderRadius.only(
                topLeft: Radius.circular(17),
                topRight: Radius.circular(17)
               )
              ),
          
           
          ))
            ],
          ),
          Positioned(
            top: 230,
            left: 20,
            right: 20,
            child: Container(
              height: 500,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome Back',
                  style: primaryfont.copyWith(
                    fontSize: 18.3.sp,
                    fontWeight: FontWeight.w800
                  ),),
                  ksizedbox5,
                  Text('Please enter your email & password \nto sign in',
                  style: primaryfont.copyWith(
                    fontWeight: FontWeight.w500
                  ),),
                  ksizedbox30,
                   Text('Mobile Number*',
                   style: primaryfont.copyWith(
                    color: Color(0xff7C86A2)
                   ),),
                   ksizedbox10,
                 Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value==null||value.isEmpty) {
                          return 'Please Enter the mobile number';
                        }
                        return null;
                      },
                        controller:mobileController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10)
                          )
                        ),
                      ),
                  ),
                   ksizedbox30,
                   Text('Password',
                   style: primaryfont.copyWith(
                    color: Color(0xff7C86A2)
                   ),),
                   ksizedbox10,
                  Container(
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextFormField(
                    
                       obscureText: ishide,
                        controller: passwordController,
                        decoration: InputDecoration(
                         suffixIcon: IconButton(icon: ishide? Icon(Icons.visibility):Icon(Icons.visibility_off),
                         onPressed: (){
                          setState(() {
                            ishide=!ishide;
                          });
                         },),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10),
                                
                          )
                        ),
                      ),
                  ),
                  ksizedbox5,
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                         Row(
                           children: [
                             Checkbox(value: ischeck, 
                             onChanged: (value){
                              setState(() {
                                ischeck=value!;
                              });
                             }),
                             Text('Remember me',
                             style: primaryfont.copyWith(
                              fontSize: 12.5.sp
                             ),)
                           ],
                         ),
                         InkWell(
                          onTap: (){
                            Get.to(ForgotPasswordScreen());
                          },
                           child: Text('Forgot Password?',
                           style: primaryfont.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.kblue
                           ),),
                         )
                    ],
                   ),
                   ksizedbox40,
                   ksizedbox20,
                 InkWell(
                  onTap: (){
                    Get.to(HomeScreen());
                  },
                  child: CommonContainer(name: 'Login',)),
                   ksizedbox10,
                  Center(
                    child: InkWell(
                      onTap: (){
                        Get.to(RegisterScreen());
                      },
                      child: RichText(
                        text: TextSpan(
                        children: [
                          TextSpan(text: 'Dont"t have an account ?',
                          style: secondoryfont.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.5.sp
                          )),
                          TextSpan(text: 'Sign Up',
                          style: secondoryfont.copyWith(
                             fontSize: 16.sp,
                             color: AppColors.kblue,
                             fontWeight: FontWeight.w500
                          ))
                        ]
                      ),
                      ),
                    ),
                  )
                ],
              ),
            ))
         
         ],),
       )
     ),
    );
  }
}