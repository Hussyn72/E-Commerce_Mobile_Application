import 'package:JF_InfoTech/base/custom_loader.dart';
import 'package:JF_InfoTech/controllers/auth_controller.dart';
import 'package:JF_InfoTech/controllers/cart_controller.dart';
import 'package:JF_InfoTech/controllers/location_controllar.dart';
import 'package:JF_InfoTech/routes/route_helper.dart';
import 'package:JF_InfoTech/utils/colors.dart';
import 'package:JF_InfoTech/utils/dimensions.dart';
import 'package:JF_InfoTech/widgets/account_widget.dart';
import 'package:JF_InfoTech/widgets/app_icon.dart';
import 'package:JF_InfoTech/widgets/big_texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/user_controller.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
      print("user has logged in");
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(text: "Profile",size: 24,color: Colors.white,),
      ),
      body: GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn?
        (userController.isLoading?Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimensions.height20),
          child:Column(
            children: [
              //profile Icon
              AppIcon(icon: Icons.person,
                backgroundColor: AppColors.mainColor,
                iconColor: Colors.white,
                iconSize: Dimensions.height45+Dimensions.height30,
                size: Dimensions.height15*10,),
              SizedBox(height: Dimensions.height30,),
              //Name
              Expanded(
                child: SingleChildScrollView(
                  child :
                  Column(
                    children: [
                      AccountWidget(
                        appIcon:AppIcon(icon: Icons.person,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5),
                        bigText: BigText(text: userController.userModel.name),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      //Phone
                      AccountWidget(
                        appIcon:AppIcon(icon: Icons.phone,
                            backgroundColor: AppColors.yellowColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5),
                        bigText: BigText(text:userController.userModel.phone),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      //Email
                      AccountWidget(
                        appIcon:AppIcon(icon: Icons.email,
                            backgroundColor: AppColors.yellowColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5),
                        bigText: BigText(text: userController.userModel.email,),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      //Address
                     GetBuilder<LocationController>(builder: (locationController){
                       if(_userLoggedIn&&locationController.addressList.isEmpty){
                         return GestureDetector(onTap: (){
                           Get.offNamed(RouteHelper.getAddressPage());
                         },
                           child: AccountWidget(
                             appIcon:AppIcon(icon: Icons.location_on,
                                 backgroundColor: AppColors.yellowColor,
                                 iconColor: Colors.white,
                                 iconSize: Dimensions.height10*5/2,
                                 size: Dimensions.height10*5),
                             bigText: BigText(text: "Fill in your address"),
                           ),
                         );
                       }else{
                         return GestureDetector(onTap: (){
                           Get.offNamed(RouteHelper.getAddressPage());
                         },
                           child: AccountWidget(
                             appIcon:AppIcon(icon: Icons.location_on,
                                 backgroundColor: AppColors.yellowColor,
                                 iconColor: Colors.white,
                                 iconSize: Dimensions.height10*5/2,
                                 size: Dimensions.height10*5),
                             bigText: BigText(text: " Your address"),
                           ),
                         );
                       }
                     }),
                      SizedBox(height: Dimensions.height20,),
                      //Message
                      AccountWidget(
                        appIcon:AppIcon(icon: Icons.message_sharp,
                            backgroundColor:Colors.redAccent,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5),
                        bigText: BigText(text: "Messages"),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      //Logout
                      GestureDetector(
                        onTap: (){
                          if(Get.find<AuthController>().userLoggedIn()) {
                            Get.find<AuthController>().clearSharedData();
                            Get.find<CartController>().clear();
                            Get.find<CartController>().clearCartHistory();
                            Get.find<LocationController>().clearAddressList();
                            Get.offNamed(RouteHelper.getSignInPage());
                          }else{
                            print("you logged out");
                          }
                        },
                        child: AccountWidget(
                          appIcon:AppIcon(icon: Icons.logout,
                              backgroundColor: Colors.redAccent,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10*5/2,
                              size: Dimensions.height10*5),
                          bigText: BigText(text: "Logout"),
                        ),
                      ),
                      SizedBox(height: Dimensions.height20,),
                    ],
                  ),),
              ),
            ],
          ),):CustomLoader()) :
        Container(

          child: Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.maxFinite,
                height: Dimensions.height20*8,
                margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            "assets/image/signintocontinue.png"
                        )
                    )
                ),
              ),
              GestureDetector(
                onTap: (){
                  Get.toNamed(RouteHelper.getSignInPage());
                },
                child: Container(
                  width: double.maxFinite,
                  height: Dimensions.height20*5,
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius20),

                  ),
                  child: Center(child: BigText(text: "Sign In",color: Colors.white,size: Dimensions.font26,)),
                ),
              )
            ],
          )),
        );
    })
    );
  }
}
