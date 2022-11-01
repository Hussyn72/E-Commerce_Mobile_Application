import 'package:JF_InfoTech/controllers/auth_controller.dart';
import 'package:JF_InfoTech/controllers/location_controllar.dart';
import 'package:JF_InfoTech/controllers/popular_product_controller.dart';
import 'package:JF_InfoTech/data/repository/auth_repo.dart';
import 'package:JF_InfoTech/data/repository/cart_repo.dart';
import 'package:JF_InfoTech/data/repository/popular_product_repo.dart';
import 'package:JF_InfoTech/data/repository/user_repo.dart';
import 'package:JF_InfoTech/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../controllers/cart_controller.dart';
import '../controllers/recommended_product_controller.dart';
import '../controllers/user_controller.dart';
import '../data/api/api_client.dart';
import '../data/repository/location_repo.dart';
import '../data/repository/recommended_product_repo.dart';

Future<void> init()async{
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  //api client
  Get.lazyPut(()=>ApiClient(appBaseUrl:AppConstants.BASE_URL, sharedPreferences:Get.find()));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find() ));

  //repos
  Get.lazyPut(() => AuthController(authRepo:Get.find()));
  Get.lazyPut(() => UserController(userRepo:Get.find()));
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences:Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => LocationRepo(apiClient: Get.find(), sharedPreferences:Get.find()));


  //controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo:Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));


  }