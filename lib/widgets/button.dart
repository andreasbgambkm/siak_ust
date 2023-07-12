import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:siak/core/utils/color_pallete.dart';

class SiakButton extends StatelessWidget {
  final String text;
  final double borderRadius;
  final  VoidCallback? onPressedButton ;
  final  double heightButton;
  final  double widthButton;
  const SiakButton({key ,required this.text,required this.borderRadius,required this.heightButton,required this.widthButton,required this.onPressedButton});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      color:SiakColors.SiakPrimary,
      height:heightButton,
      minWidth:widthButton ,
      // color: Colors.deepOrange,
      shape: RoundedRectangleBorder(
          borderRadius:  BorderRadius.circular(borderRadius)),
      onPressed:onPressedButton,
      child: Text(text,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: SiakColors.SiakWhite,
          )),
    );
  }
}