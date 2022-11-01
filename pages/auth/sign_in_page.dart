import 'dart:ui';

import 'package:JF_InfoTech/base/custom_loader.dart';
import 'package:JF_InfoTech/pages/auth/sign_up_page.dart';
import 'package:JF_InfoTech/routes/route_helper.dart';
import 'package:JF_InfoTech/utils/colors.dart';
import 'package:JF_InfoTech/utils/dimensions.dart';
import 'package:JF_InfoTech/widgets/app_text_field.dart';
import 'package:JF_InfoTech/widgets/big_texts.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    void _login(AuthController authController) {


      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

     if(phone.isEmpty){
        showCustomSnackBar("Enter your phone address", title: "Phone number");

      }else if(password.isEmpty){
        showCustomSnackBar("Enter your password", title: "password");

      }else if(password.length<6){
        showCustomSnackBar("Password can not be less then six characters", title: "password");

      }else {


        authController.login(phone, password).then((status){
          if(status.isSuccess){
             Get.toNamed(RouteHelper.getInitial());
             //Get.toNamed(RouteHelper.getCartPage());
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }
    return  Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading? SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //app logo
              Container(
                height: Dimensions.screenHeight*0.25,
                child: const Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius:80,
                    backgroundImage: AssetImage(
                        "assets/image/jf logo.png"
                    ),
                  ),
                ),
              ),
              //welcome
              Container(
                margin: EdgeInsets.only(left: Dimensions.width20,),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome",
                      style: TextStyle(
                        fontSize: Dimensions.font20*3+Dimensions.font20/2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Sign into your account",
                      style: TextStyle(
                        fontSize: Dimensions.font20,
                        color: Colors.grey[500],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20),
              //your email
              AppTextField(textController: phoneController,
                  hintText: "phone",
                  icon: Icons.phone_android),
              SizedBox(height: Dimensions.height20),
              //your password
              AppTextField(textController: passwordController,
                hintText: "Password",
                icon: Icons.password_sharp,isObscure: true,),
              SizedBox(height: Dimensions.height20),
              // sign in to your account
              // Row(
              //   children: [
              //     Expanded(child: Container()),
              //     RichText(
              //       text: TextSpan(
              //           text: "Sign into your account",
              //           style: TextStyle(
              //             color: Colors.grey[500],
              //             fontSize: Dimensions.font20,
              //           )
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(height: Dimensions.height20),
              //sign in button
              GestureDetector(
                onTap: (){
                  _login(authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: AppColors.mainColor,
                  ),
                  child: Center(
                    child: BigText(text: "Sign In",
                      size: Dimensions.font20+Dimensions.font20/2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //dont have an account create
              RichText(
                text: TextSpan(
                  text: "Don't have an account ? ",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font20,
                  ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage()),
                      text: "Create",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainBlackColor,
                        fontSize: Dimensions.font20,
                      ),),
                  ],
                ),
              ),
            ],
          ),
        ):CustomLoader();
  })
  );
  }
}
