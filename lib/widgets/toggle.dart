import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SiakToogle extends StatelessWidget {
  final String tittle1;
  final String tittle2;
  const SiakToogle({key , required this.tittle1,required this.tittle2});

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      customTextStyles: [

        GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white),
        GoogleFonts.poppins(fontWeight: FontWeight.bold,color: Colors.white)
      ],
      customWidths: [MediaQuery.of(context).size.width/2.2, MediaQuery.of(context).size.width/2.2],
      customHeights: [80,80],
      activeBgColor: [SiakColors.SiakPrimary],

      activeFgColor: Colors.white,
      inactiveBgColor: Color.fromARGB(255, 230, 230, 230),
      inactiveFgColor: Colors.grey,
      totalSwitches: 2,
      labels: [tittle1, tittle2],

    );
  }
}