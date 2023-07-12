import 'package:flutter/material.dart';
import 'package:siak/core/utils/image_constant.dart';
import 'package:siak/core/utils/size_utils.dart';
import 'package:siak/theme/app_decoration.dart';
import 'package:siak/theme/app_style.dart';

import 'home_widgets/custom_image_view.dart';


// ignore: must_be_immutable
class HomeScreenItemWidget extends StatelessWidget {
  HomeScreenItemWidget();

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          height: getVerticalSize(
            215,
          ),
          width: getHorizontalSize(
            333,
          ),
          margin: getMargin(
            right: 20,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgRectangle146,
                height: getVerticalSize(
                  215,
                ),
                width: getHorizontalSize(
                  333,
                ),
                radius: BorderRadius.circular(
                  getHorizontalSize(
                    10,
                  ),
                ),
                alignment: Alignment.center,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: getPadding(
                    left: 13,
                    top: 9,
                    right: 13,
                    bottom: 9,
                  ),
                  decoration: AppDecoration.fillBlack90084.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder10,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: getPadding(
                          left: 2,
                          top: 12,
                        ),
                        child: Text(
                          "",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtPoppinsSemiBold16Yellow300,
                        ),
                      ),
                      Container(
                        width: getHorizontalSize(
                          305,
                        ),
                        margin: getMargin(
                          left: 1,
                          top: 11,
                        ),
                        child: Text(
                          "",
                          maxLines: null,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtPoppinsMedium16WhiteA700,
                        ),
                      ),
                      Padding(
                        padding: getPadding(
                          left: 2,
                          top: 53,
                        ),
                        child: Text(
                          "Baca Selengkapnya...",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtPoppinsMedium14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
