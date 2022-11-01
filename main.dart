import 'package:JF_InfoTech/controllers/cart_controller.dart';
import 'package:JF_InfoTech/controllers/popular_product_controller.dart';
import 'package:JF_InfoTech/routes/route_helper.dart';
import 'package:JF_InfoTech/utils/colors.dart';
import 'package:flutter/material.dart';
import 'controllers/recommended_product_controller.dart';
import 'helper/dependencies.dart'as dep;
import 'package:get/get.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
 Get.find<CartController>().getCartData();
  return GetBuilder<PopularProductController>(builder: (_){
   return GetBuilder<RecommendedProductController>(builder: (_){
     return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JF InFoTech',

      //home: AddAddressPage(),
       //home: SplashScreen(),
       initialRoute: RouteHelper.getSplashPage(),
       getPages: RouteHelper.routes,
       theme: ThemeData(
         primaryColor: AppColors.mainColor,
         fontFamily: "Lato",
       ),
    );
  });
});
  }
}
