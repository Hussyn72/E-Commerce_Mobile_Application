import 'package:JF_InfoTech/widgets/small_texts.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_texts.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(
            text: text,size: Dimensions.font26,
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
              SizedBox(
                width: 10,
              ),
              SmallText(
                text: "4.5",
              ),
              SizedBox(
                width: 10,
              ),
              SmallText(text: "1287"),
              SizedBox(
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
    );
  }
}
