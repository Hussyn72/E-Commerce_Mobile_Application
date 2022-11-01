import 'package:JF_InfoTech/base/custom_loader.dart';
import 'package:JF_InfoTech/base/show_custom_snackbar.dart';
import 'package:JF_InfoTech/models/signupbody_body_model.dart';
import 'package:JF_InfoTech/pages/auth/sign_in_page.dart';
import 'package:JF_InfoTech/pages/auth/sign_in_page.dart';
import 'package:JF_InfoTech/pages/auth/sign_in_page.dart';
import 'package:JF_InfoTech/utils/colors.dart';
import 'package:JF_InfoTech/utils/dimensions.dart';
import 'package:JF_InfoTech/widgets/app_text_field.dart';
import 'package:JF_InfoTech/widgets/big_texts.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../routes/route_helper.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
      "t.png",
      "f.png",
      "g.png"
    ];

    void _registration(AuthController authController) {

      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty){
        showCustomSnackBar("Enter your name", title: "Name");

      }else if(phone.isEmpty){
        showCustomSnackBar("Enter your phone number", title: "Phone number");

      }else if(email.isEmpty){
        showCustomSnackBar("Enter your email address", title: "Email address");

      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Enter a valid email address ", title: "Valid Email address");

      }else if(password.isEmpty){
        showCustomSnackBar("Enter your password", title: "password");

      }else if(password.length<6){
        showCustomSnackBar("Password can not be less then six characters", title: "password");

      }else {

        SignUpBody signUpBody = SignUpBody (name: name,
            phone: phone,
            email: email,
            password: password);
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            print("Success registraion");
            Get.offNamed(RouteHelper.getInitial());
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }
    return  Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading?SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
              //your email
              AppTextField(textController: emailController,
                  hintText: "Email",
                  icon: Icons.email),
              SizedBox(height: Dimensions.height20),
              //your password
              AppTextField(textController: passwordController,
                  hintText: "Password",
                  icon: Icons.password_sharp,isObscure:true,),
              SizedBox(height: Dimensions.height20),
              //your name
              AppTextField(textController: nameController,
                  hintText: "Name",
                  icon: Icons.person),
              SizedBox(height: Dimensions.height20),
              //your phone
              AppTextField(textController: phoneController,
                  hintText: "Phone",
                  icon: Icons.phone),
              SizedBox(height: Dimensions.height20),
              //sign up button
              GestureDetector(
                onTap: (){
                  _registration(_authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: AppColors.mainColor,
                  ),
                  child: Center(
                    child: BigText(text: "Sign Up",
                      size: Dimensions.font20+Dimensions.font20/2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height10,),
              //tag line
              RichText(
                text: TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignInPage()),
                    text: "Have an account already?",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20,
                    )
                ),
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //sign up options
              RichText(
                text: TextSpan(
                    text: "Sign up Using ",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font16,
                    )
                ),
              ),
              SizedBox(height: Dimensions.screenHeight*0.015),
              Wrap(
                children: List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: Dimensions.radius30,
                    backgroundImage: AssetImage(
                        "assets/image/"+signUpImages[index]
                    ),
                  ),
                ),),
              ),
            ],
          ),
        ):CustomLoader();
    })
    );
  }
}
