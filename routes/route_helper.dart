import 'package:JF_InfoTech/pages/address/add_address_page.dart';
import 'package:JF_InfoTech/pages/auth/sign_in_page.dart';
import 'package:JF_InfoTech/pages/home/main_item_page.dart';
import 'package:JF_InfoTech/pages/items/popular_item_detail.dart';
import 'package:JF_InfoTech/pages/items/recommended_item_datail.dart';
import 'package:JF_InfoTech/pages/splash/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../pages/address/pick_address_map.dart';
import '../pages/cart/cart_page.dart';
import '../pages/home/home_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularItem = "/popular-item";
  static const String recommendedItem = "/recommended-item";
  static const String cartPage="/cart-page";
  static const String signIn="/sign-in";
  static const String addAddress="/add-address";
  static const String pickAddressMap="/pick-address";

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularItem(int pageId,String page) => '$popularItem?pageId=$pageId&page=$page';
  static String getRecommendedItem(int pageId,String page) => '$recommendedItem?pageId=$pageId&page=$page';
  static String getCartPage()=>'$cartPage';
  static String getSignInPage()=>'$signIn';
  static String getAddressPage()=>'$addAddress';
  static String getPickAddressPage()=>'$pickAddressMap';

  static List<GetPage> routes = [
    GetPage(name: pickAddressMap, page: (){
      PickAddressMap _pickAddress=Get.arguments;
      return _pickAddress;
    }),
    GetPage(name: splashPage, page: ()=>SplashScreen()),



  GetPage(name: initial, page: () => HomePage(),
  transition: Transition.fade),


    GetPage(name: signIn, page: (){
      return SignInPage();
    },transition: Transition.fade),

    GetPage(
      name: popularItem,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters["page"];
        return PopularItemDetail(pageId: int.parse(pageId!),page:page!);
      },
      transition: Transition.circularReveal,transitionDuration:Duration(seconds: 1),
    ),

    GetPage(
      name: recommendedItem,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters["page"];
        return RecommendedItemDetail(pageId: int.parse(pageId!), page:pageId);
      },
      transition: Transition.zoom,
    ),//get page

  GetPage(name: cartPage, page: (){
  return const CartPage();
  },
  transition: Transition.zoom,
  ),

    GetPage(name: addAddress, page: (){
      return AddAddressPage();

    }),

  ];
}
