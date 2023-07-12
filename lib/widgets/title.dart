import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class TitlePage extends StatelessWidget {
  final String title;
  const TitlePage({key , required this.title,});

  @override
  Widget build(BuildContext context ) {
    return  Padding(
      padding: const EdgeInsets.only(left: 8, top: 10),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: GoogleFonts.poppins(
            color: Color.fromARGB(255, 190, 13, 13),
            fontSize: MediaQuery.of(context).size.width / 15,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
