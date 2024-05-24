// import 'dart:js_interop';
// import 'dart:js_util';

// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:vexport/customer/views/auth/login/login_screen.dart';

// class AnimationAccountCreating extends StatefulWidget {
//   const AnimationAccountCreating({super.key});

//   @override
//   State<AnimationAccountCreating> createState() => _AnimationAccountCreatingState();
// }

// class _AnimationAccountCreatingState extends State<AnimationAccountCreating> {

//    late final AnimationController _controller;

//    @override
//   void initState() {
//     super.initState();
//     // Initialize the controller with a default duration.
//     _controller = AnimationController(
//       vsync:this,
//       duration: const Duration(seconds: 1),
//     );
//     _controller.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         _onAnimationComplete();
//       }
//     });
//   }
//     @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//    void _onAnimationComplete() {
//     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
//   }

//   void _startAnimation(Duration duration) {
//     _controller.duration = duration;
//     _controller.forward(from: 0);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child: Lottie.asset('assets/icons/account_create_lottie.json',
//          controller: _controller,
//           onLoaded: (composition) {
//             _startAnimation(composition.duration);
//           },),
//       ),
//     );
//   }
// }