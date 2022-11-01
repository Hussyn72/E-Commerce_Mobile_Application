import 'package:flutter/material.dart';
import 'package:JF_InfoTech/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  bool isObscure;
  final IconData icon;
   AppTextField({
    Key? key,
    required this.textController,
    required this.hintText,
    required this.icon,
    this.isObscure=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimensions.height20,right: Dimensions.height20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius20),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 7,
            offset: Offset(1,10),
            color: Colors.grey.withOpacity(0.2),
          )
        ],
      ),
      child: TextField(
        obscureText: isObscure?true:false,
        controller: textController,
        decoration: InputDecoration(
          //hint Text
          hintText: hintText,
          //prefixIcon
          prefixIcon: Icon(icon ,color: AppColors.mainColor,),
          //focusBorder
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius20),
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
          //enable border
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius20),
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
          //border
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius20),
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
