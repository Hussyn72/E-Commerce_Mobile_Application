import 'package:JF_InfoTech/controllers/cart_controller.dart';
import 'package:JF_InfoTech/controllers/popular_product_controller.dart';
import 'package:JF_InfoTech/pages/home/main_item_page.dart';
import 'package:JF_InfoTech/utils/app_constants.dart';
import 'package:JF_InfoTech/utils/dimensions.dart';
import 'package:JF_InfoTech/widgets/app_column.dart';
import 'package:JF_InfoTech/widgets/app_icon.dart';
import 'package:JF_InfoTech/widgets/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/big_texts.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_texts.dart';
import '../cart/cart_page.dart';

class PopularItemDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularItemDetail({Key? key, required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    // print("page is id" + pageId.toString());
    // print("product name is " + product.name.toString());

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            //background image
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularItemImgSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                     // fit: BoxFit.cover,
                     // image: AssetImage("assets/image/hp2.png"),)
                    image: NetworkImage(AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!)),
                ),
              ),
            ),
            //icon widget
            Positioned(
              top: Dimensions.height45,
              left: Dimensions.width10,
              right: Dimensions.width10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if(page=="cartpage"){
                        Get.toNamed(RouteHelper.getCartPage());
                      }else{
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                    child: AppIcon(
                      icon: Icons.arrow_back,
                    ),
                  ),
                  GetBuilder<PopularProductController>(builder: (controller){
                  return GestureDetector(
                  onTap: (){
                  if(controller.totalItems>=1) {
                    Get.toNamed(RouteHelper.getCartPage());
                  }else{
                    Get.toNamed(RouteHelper.getCartPage());
                  }
                  },
                    child:Stack(
                    children: [
                      AppIcon(icon: Icons.shopping_cart_outlined),
                      controller.totalItems>=1?
                    Positioned(
                        right:0,
                        top: 0,
                        child: AppIcon(icon: Icons.circle,size: 20,iconColor: Colors.transparent,backgroundColor: AppColors.mainColor,)
                        ):
                      Container(),
                      Get.find<PopularProductController>().totalItems>=1?
                      Positioned(
                          right:3,
                          top: 3,
                          child:BigText(text: Get.find<PopularProductController>().totalItems.toString(),
                          size: 12,color: Colors.white,
                          ),
                      ):
                      Container(),
                    ],
                    ),);

      })


                ],
              ),
            ),
            //introduction of item
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularItemImgSize,
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    top: Dimensions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    BigText(text: "Introduction"),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    //Expandable text widget
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableTexts(text: product.description!),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (popularProducts) {
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
                  )),
              child: Row(
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
                        GestureDetector(
                          onTap: () {
                            popularProducts.setQuantity(false);
                          },
                          child: Icon(
                            Icons.remove,
                            color: AppColors.signColor,
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.width10 / 2,
                        ),
                        BigText(text: popularProducts.inCartItems.toString()),
                        SizedBox(
                          width: Dimensions.width10 / 2,
                        ),
                        GestureDetector(
                          onTap: () {
                            popularProducts.setQuantity(true);
                          },
                          child: Icon(
                            Icons.add,
                            color: AppColors.signColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      popularProducts.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20),

                        child: BigText(
                          text: "₹ ${product.price!}| Add to cart",
                          color: Colors.white,
                        ),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
