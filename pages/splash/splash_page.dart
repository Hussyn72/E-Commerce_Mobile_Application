import 'dart:async';

import 'package:JF_InfoTech/utils/dimensions.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResources() async {
     await Get.find<PopularProductController>().getPopularProductList();
     await Get.find<RecommendedProductController>().getRecommendedProductList();

  }

  @override
  void initState(){
    super.initState();
    _loadResources();
    controller = AnimationController(vsync: this,duration: const Duration(seconds: 2))..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(
        const Duration(seconds: 1),
    ()=>Get.offNamed(RouteHelper.getInitial())
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
             ScaleTransition(scale: animation,
             child: Center(child: Image.asset("assets/image/programmer.png",width: Dimensions.splashImg,),),),
          Center(child: Image.asset("assets/image/infotech logo.png",width: Dimensions.splashImg,),),
        ],
   ),
    );
  }
}
