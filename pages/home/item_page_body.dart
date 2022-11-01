import 'package:JF_InfoTech/controllers/popular_product_controller.dart';
import 'package:JF_InfoTech/controllers/recommended_product_controller.dart';
import 'package:JF_InfoTech/models/products_models.dart';
import 'package:JF_InfoTech/pages/items/popular_item_detail.dart';
import 'package:JF_InfoTech/routes/route_helper.dart';
import 'package:JF_InfoTech/utils/app_constants.dart';
import 'package:JF_InfoTech/utils/colors.dart';
import 'package:JF_InfoTech/utils/dimensions.dart';
import 'package:JF_InfoTech/widgets/big_texts.dart';
import 'package:JF_InfoTech/widgets/icon_and_text_widget.dart';
import 'package:JF_InfoTech/widgets/small_texts.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemPageBody extends StatefulWidget {
  const ItemPageBody({Key? key}) : super(key: key);

  @override
  _ItemPageBodyState createState() => _ItemPageBodyState();
}

class _ItemPageBodyState extends State<ItemPageBody> {

  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider Section
        GetBuilder<PopularProductController>(builder: (popularProducts){
        return popularProducts.isLoaded?Container(
          //redaccent color
          height: Dimensions.pageView,
          child: PageView.builder(
              controller: pageController,
              itemCount: popularProducts.popularProductList.length,
              itemBuilder: (context, position) {
                return _buildPageItem(
                    position, popularProducts.popularProductList[position]);
              }),

        ):Container();

        //CircularProgressIndicator(

        //color: AppColors.mainColor,
      //);
      //ternary operator
        }
        ),
        //dots
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty?1:popularProducts.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        //popular Text
        SizedBox(height: Dimensions.height30),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recommended'),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child:BigText(text: ".", color: Colors.black26),
              ),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: SmallText(text: "Top Selections"),

              )
            ],
          ),
        ),
        //list of item And Images
        //   Container(
        //   height: 700,
        //  child:recommended food
          GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
            return recommendedProduct.isLoaded?
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: recommendedProduct.recommendedProductList.length,
                itemBuilder:(context,index){
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getRecommendedItem(index,"home"));

                    },
                    child: Container(
                        margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20 ,bottom: Dimensions.height10),
                        child : Row(
                          children: [
                            //image section
                            Container(
                              width:120,
                              height:120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white38,
                                image: DecorationImage(
                                  //fit: BoxFit.cover,
                                 // image: AssetImage("assets/image/hp4.png"),
                               image:NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+ recommendedProduct.recommendedProductList[index].img!),
                                ),
                              ),
                            ),
                            //Text Section
                            Expanded(
                              child: Container(
                                height: 100,

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(Dimensions.radius20),
                                    bottomRight: Radius.circular(Dimensions.radius20),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BigText(text:
                                      recommendedProduct.recommendedProductList[index].name!),
                                      SmallText(text: "Fasted Delivery By Tommorrow"),
                                      SizedBox(height:Dimensions.height10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconAndTextWidget(
                                            icon: Icons.currency_rupee,
                                            text: '79999',
                                            iconColor: AppColors.iconColor1,
                                          ),

                                          IconAndTextWidget(
                                            icon: Icons.reviews,
                                            text: '186',
                                            iconColor: AppColors.mainColor,
                                          ),

                                          IconAndTextWidget(
                                            icon: Icons.discount,
                                            text: '21% Off',
                                            iconColor: AppColors.iconColor2,
                                          )
                                        ],
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )

                    ),
                  );
                }
                ):
      CircularProgressIndicator(
              color: AppColors.mainColor,
            );
          }),
      ],
    );
  } //ye bus structure hai scrolling ka

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
                Get.toNamed(RouteHelper.getPopularItem(index,"home"));
             },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                 //color: index.isEven ? const Color(0xFF69c5df) : const Color(0xFF9294cc),
                image: DecorationImage(
                   fit: BoxFit.cover,
                   //image:AssetImage("assets/image/hp2.png")
                  image:NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+ popularProduct.img!),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30, bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0))
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height15,
                  left: 15,
                  right: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text:popularProduct.name!,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(
                            5,
                            (index) {
                              return Icon(
                                Icons.star,
                                color: AppColors.mainColor,
                                size: 15,
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SmallText(
                          text: "4.5",
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SmallText(text: "1287"),
                        const SizedBox(
                          width: 10,
                        ),
                        SmallText(text: "Comments")
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconAndTextWidget(
                          icon: Icons.currency_rupee,
                          text: '45999',
                          iconColor: AppColors.iconColor1,
                        ),
                        IconAndTextWidget(
                          icon: Icons.location_on,
                          text: '2.3km',
                          iconColor: AppColors.mainColor,
                        ),
                        IconAndTextWidget(
                          icon: Icons.discount,
                          text: '18% Off',
                          iconColor: AppColors.iconColor2,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  //isme scrolling structure ka content hai carousel ka

}
