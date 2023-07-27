import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siak/core/utils/color_pallete.dart';

class CustomTable extends StatelessWidget {
  final List<Map<String, String>> data;

  CustomTable({required this.data});

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultColumnWidth: IntrinsicColumnWidth(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: _buildTableRows(),
    );
  }

  List<TableRow> _buildTableRows() {
    return data.map((row) {
      return TableRow(
        children: [
          TableCell(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                row['label']!,
                    style: GoogleFonts.poppins(fontSize: 18, color: SiakColors.SiakBlack, fontWeight: FontWeight.bold),
                  ),
              ),
            ),

          TableCell(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                ': ${row['value']}',
                style:   GoogleFonts.poppins(fontSize: 16, color: SiakColors.black900, fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ],
      );
    }).toList();
  }
}