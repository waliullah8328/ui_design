 import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_design/ui/screens/signin_screen.dart';
import 'package:ui_design/ui/utils/assets_path.dart';

import '../widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
   const SplashScreen({super.key});

   @override
   State<SplashScreen> createState() => _SplashScreenState();
 }

 class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInScreen(),));
    });
  }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: ScreenBackground(
           child: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,

           children: [
             SvgPicture.asset(AssetsPath.logoSvg,width: 120,),
           ],
         ),
       ),),

     );
   }
 }


