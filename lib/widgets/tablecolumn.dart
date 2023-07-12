import 'package:flutter/cupertino.dart';

import 'package:google_fonts/google_fonts.dart';

class SiakTableColumn extends StatelessWidget {
  final String textColumn;

  const SiakTableColumn({key , required this.textColumn,});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(textColumn,style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
        )
      ],
    );
  }
}