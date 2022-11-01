import 'package:JF_InfoTech/base/no_data_page.dart';
import 'package:JF_InfoTech/controllers/auth_controller.dart';
import 'package:JF_InfoTech/controllers/cart_controller.dart';
import 'package:JF_InfoTech/controllers/location_controllar.dart';
import 'package:JF_InfoTech/controllers/popular_product_controller.dart';
import 'package:JF_InfoTech/helper/dependencies.dart';
import 'package:JF_InfoTech/pages/home/main_item_page.dart';
import 'package:JF_InfoTech/utils/app_constants.dart';
import 'package:JF_InfoTech/utils/colors.dart';
import 'package:JF_InfoTech/utils/dimensions.dart';
import 'package:JF_InfoTech/widgets/big_texts.dart';
import 'package:JF_InfoTech/widgets/small_texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../widgets/app_icon.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: Dimensions.width20,
              right: Dimensions.width20,
              top: Dimensions.height20*3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(icon:Icons.arrow_back,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                  SizedBox(width: Dimensions.width20*5),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon:Icons.home,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  AppIcon(icon:Icons.shopping_cart_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  )
                ],

          )
          ),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItems.length>0?Positioned(
              top: Dimensions.height20*5,
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: 0,
              child: Container(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child:GetBuilder<CartController>(builder: (cartController){
                    var _cartList = cartController.getItems;
                    return  ListView.builder(
                        itemCount: _cartList.length,
                        itemBuilder: (_,index){
                          return Container(
                            margin: EdgeInsets.only(top:Dimensions.height15),
                            width: double.maxFinite,
                            height: 100,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    var popularIndex = Get.find<PopularProductController>()
                                        .popularProductList
                                        .indexOf(_cartList[index].product!);
                                    if(popularIndex>=0){
                                      Get.toNamed(RouteHelper.getPopularItem(popularIndex,"cartpage"));
                                    }else{
                                      var recommendedIndex = Get.find<RecommendedProductController>()
                                          .recommendedProductList
                                          .indexOf(_cartList[index].product!);
                                      if(recommendedIndex<0){
                                        Get.snackbar("History Product", "Product review is not available for history products",
                                          backgroundColor: AppColors.mainColor,
                                          colorText: Colors.white,
                                        );
                                      }else{
                                        Get.toNamed(RouteHelper.getRecommendedItem(recommendedIndex,"cartpage"));
                                      }
                                    }
                                  },
                                  child: Container(
                                    width: Dimensions.height20*5,
                                    height: Dimensions.height20*5,
                                    margin: EdgeInsets.only(bottom: Dimensions.height10),
                                    decoration: BoxDecoration(
                                      image:DecorationImage(
                                        fit:BoxFit.cover,
                                        image: NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+ cartController.getItems[index].img!),),
                                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: Dimensions.width10,),
                                Expanded(child: Container(
                                  height: Dimensions.radius20*5,
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children:[
                                        BigText(text: cartController.getItems[index].name!,color: Colors.black54,),
                                        SmallText(text: ""),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(text: "₹ "+cartController.getItems[index].price.toString(),color: Colors.redAccent,),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: Dimensions.height10,
                                                  bottom: Dimensions.height10,
                                                  left: Dimensions.width10,
                                                  right: Dimensions.width10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      cartController.addItem(_cartList[index].product!, -1);
                                                      //   print("maine ise chu'a");
                                                      //popularProducts.setQuantity(false);
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: AppColors.signColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: Dimensions.width10 / 2,
                                                  ),
                                                  BigText(text:_cartList[index].quantity.toString()),// popularProducts.inCartItems.toString()),
                                                  SizedBox(
                                                    width: Dimensions.width10 / 2,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      cartController.addItem(_cartList[index].product!, 1);
                                                      // popularProducts.setQuantity(true);
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      color: AppColors.signColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ]
                                  ),

                                ))
                              ],
                            ),
                          );
                        });
                  }
                  ),
                ),),
            ):NoDataPage(text: "Your cart is Empty!");
          }
          ), ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartController) {
          return Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(
                top: Dimensions.height30,
                bottom: Dimensions.height30,
                left: Dimensions.width20,
                right: Dimensions.width20),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                ),),
            child: cartController.getItems.isNotEmpty?Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                ),
                child: Row(
                  children: [

                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),
                    BigText(text:"₹ " +cartController.totalAmount.toString()),
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),

                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  if(Get.find<AuthController>().userLoggedIn()){
                    if(Get.find<LocationController>().addressList.isEmpty){
                      Get.toNamed(RouteHelper.getAddressPage());
                    }else{
                      Get.offNamed(RouteHelper.getInitial());
                    }
                  }else{
                    Get.toNamed(RouteHelper.getSignInPage());
                  }
                 // popularProducts.addItem(product);
                  cartController.addToHistory();
                },
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20),

                  child: BigText(
                    text: "Checkout",
                    color: Colors.white,
                  ),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                ),
              ),
            ],
          ):Container(),
          );
        },
      ),
    );
  }
}
