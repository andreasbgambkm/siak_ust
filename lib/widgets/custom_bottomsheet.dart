import 'package:flutter/material.dart';
import 'package:siak/core/utils/image_constant.dart';
import 'package:siak/core/utils/size_utils.dart';
import 'package:siak/theme/app_style.dart';
import 'package:siak/widgets/home_widgets/custom_image_view.dart';

class SiakBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 14,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(

                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgBnilogowithtagline,
                    height: getVerticalSize(32),
                    width: getHorizontalSize(60),
                    margin: getMargin(top: 1),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgLogobanpt1,
                    height: getVerticalSize(30),
                    width: getHorizontalSize(35),
                    margin: getMargin(left: 16, top: 1, bottom: 2),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgLogoristekdiktipng,
                    height: getVerticalSize(31),
                    width: getHorizontalSize(28),
                    margin: getMargin(left: 16, bottom: 2),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgLogoaptik1,
                    height: getVerticalSize(30),
                    width: getHorizontalSize(25),
                    margin: getMargin(left: 16, top: 1, bottom: 2),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgLogoadlaptik1,
                    height: getVerticalSize(20),
                    width: getHorizontalSize(48),
                    margin: getMargin(left: 10, top: 6, bottom: 7),
                  ),
                ],
              ),
            ],
          ),
          Text(
            "© 2022 - Lembaga Pusat Sistem Informasi (LPSI)",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.txtPoppinsSemiBold13,
          ),
        ],
      ),
    );
  }
}
