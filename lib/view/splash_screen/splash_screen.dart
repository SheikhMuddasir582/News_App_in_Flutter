
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:world_news/res/assets/image_assets.dart';
import 'package:world_news/res/routes/routes_name.dart';

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
    Timer(const Duration(seconds: 3), () { 
      Navigator.pushReplacementNamed(context, RouteName.homeScreen);
    });
  }
  @override
  Widget build(BuildContext context) {
    final height= MediaQuery.sizeOf(context).height * 1;
    final width= MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImageAssets.splashScreen,
          fit: BoxFit.cover,
          width: width * .9,
          height: height * .5,
          ),
          (height * .04).ph,// extension sizedbox
          Text('TOP HEADLINES', style: GoogleFonts.anton(letterSpacing: .6, color: Colors.grey.shade700),),
          (height * .04).ph,// extension sizedbox
          const SpinKitChasingDots(
            color: Colors.blue,
            size: 40,
          )
        ],
      ),
    );
  }
}

extension Padding on num{
  SizedBox get ph => SizedBox(height: toDouble(),);
  SizedBox get pw => SizedBox(width: toDouble(),);
}
    