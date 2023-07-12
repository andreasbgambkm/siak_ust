import 'package:flutter/material.dart';
import 'package:siak/core/utils/color_constant.dart';
import 'package:siak/theme/app_decoration.dart';
import 'package:siak/theme/app_style.dart';

// ignore: must_be_immutable
class AppbarTitle extends StatelessWidget {
  AppbarTitle({
    required this.text,
    this.margin,
    this.onTap,
  });

  String text;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Container(
          decoration: AppDecoration.txtOutlineBlack9003f,
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: AppStyle.txtPoppinsSemiBold20.copyWith(
              color: ColorConstant.whiteA700,
            ),
          ),
        ),
      ),
    );
  }
}
