import 'package:flutter/material.dart';
import 'package:siak/core/utils/color_constant.dart';
import 'package:siak/core/utils/size_utils.dart';

class AppDecoration {
  static BoxDecoration get fillBlack90084 => BoxDecoration(
        color: ColorConstant.black90084,
      );
  static BoxDecoration get txtOutlineBlack9003f => BoxDecoration();
  static BoxDecoration get outlineBluegray700 => BoxDecoration(
        color: ColorConstant.gray100,
        border: Border.all(
          color: ColorConstant.blueGray700,
          width: getHorizontalSize(
            1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.black9003f,
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: Offset(
              0,
              4,
            ),
          ),
        ],
      );
  static BoxDecoration get fillWhiteA700 => BoxDecoration(
        color: ColorConstant.whiteA700,
      );
  static BoxDecoration get outlineGray700 => BoxDecoration(
        color: ColorConstant.red900,
        border: Border.all(
          color: ColorConstant.gray700,
          width: getHorizontalSize(
            1,
          ),
        ),
      );
}

class BorderRadiusStyle {
  static BorderRadius roundedBorder5 = BorderRadius.circular(
    getHorizontalSize(
      5,
    ),
  );

  static BorderRadius roundedBorder2 = BorderRadius.circular(
    getHorizontalSize(
      2,
    ),
  );

  static BorderRadius roundedBorder10 = BorderRadius.circular(
    getHorizontalSize(
      10,
    ),
  );

  static BorderRadius circleBorder60 = BorderRadius.circular(
    getHorizontalSize(
      60,
    ),
  );


  static BoxDecoration get outlineGray7002 => BoxDecoration(
    color: ColorConstant.whiteA700,
    border: Border.all(
      color: ColorConstant.gray700,
      width: getHorizontalSize(
        1,
      ),
    ),
    boxShadow: [
      BoxShadow(
        color: ColorConstant.black9003f,
        spreadRadius: getHorizontalSize(
          2,
        ),
        blurRadius: getHorizontalSize(
          2,
        ),
        offset: Offset(
          0,
          4,
        ),
      ),
    ],
  );
  static BoxDecoration get outlineBlack900 => BoxDecoration(
    color: ColorConstant.whiteA700,
    border: Border.all(
      color: ColorConstant.black900,
      width: getHorizontalSize(
        1,
      ),
    ),
  );
  static BoxDecoration get fillYellow300 => BoxDecoration(
    color: ColorConstant.yellow300,
  );
  static BoxDecoration get outlineGray7001 => BoxDecoration(
    color: ColorConstant.gray100,
    border: Border.all(
      color: ColorConstant.gray700,
      width: getHorizontalSize(
        1,
      ),
      strokeAlign: strokeAlignOutside,
    ),
    boxShadow: [
      BoxShadow(
        color: ColorConstant.black9003f,
        spreadRadius: getHorizontalSize(
          2,
        ),
        blurRadius: getHorizontalSize(
          2,
        ),
        offset: Offset(
          0,
          4,
        ),
      ),
    ],
  );
  static BoxDecoration get outlineGray7003 => BoxDecoration(
    color: ColorConstant.red900,
    border: Border.all(
      color: ColorConstant.gray700,
      width: getHorizontalSize(
        1,
      ),
    ),
  );
  static BoxDecoration get txtOutlineBlack9003f => BoxDecoration();
  static BoxDecoration get fillGray100 => BoxDecoration(
    color: ColorConstant.gray100,
  );
  static BoxDecoration get fillWhiteA700 => BoxDecoration(
    color: ColorConstant.whiteA700,
  );
  static BoxDecoration get outlineGray700 => BoxDecoration(
    color: ColorConstant.whiteA700,
    border: Border.all(
      color: ColorConstant.gray700,
      width: getHorizontalSize(
        1,
      ),
    ),
  );
}



// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
