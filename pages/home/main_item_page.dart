
import 'package:JF_InfoTech/controllers/recommended_product_controller.dart';
import 'package:JF_InfoTech/utils/colors.dart';
import 'package:JF_InfoTech/utils/dimensions.dart';
import 'package:JF_InfoTech/widgets/big_texts.dart';
import 'package:JF_InfoTech/widgets/small_texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/popular_product_controller.dart';
import 'item_page_body.dart';


class MainItemPage extends StatefulWidget {
  const MainItemPage({Key? key}) : super(key: key);

  @override
  _MainItemPageState createState() => _MainItemPageState();
}

class _MainItemPageState extends State<MainItemPage> {
  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    // print("curent height is"+MediaQuery.of(context).size.height.toString());

    return RefreshIndicator(child: Column(
        children: [
          //showing the header
          Container(
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height45,bottom: Dimensions.height15),
              padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children:[
                      BigText(text: 'INDIA',color: AppColors.mainColor),
                      Row(

                         children: [
                           SmallText(text: 'Mumbai',color: Colors.black54,),
                          const Icon(Icons.arrow_drop_down_rounded),

                        ],
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimensions.height45,
                      height: Dimensions.height45,
                      child: Icon(Icons.search,color: Colors.white,size:Dimensions.iconSize24,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        color: AppColors.mainColor,
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
          //showing the body
          Expanded(child: SingleChildScrollView(
            child: ItemPageBody(),
          ),),
        ],
      ),
          onRefresh: _loadResources );

  }


}//contains india mumbai & search
