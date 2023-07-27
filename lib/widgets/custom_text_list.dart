import 'package:flutter/material.dart';

class CustomTextList extends StatelessWidget {
  final List<String> texts;

  CustomTextList({
    required this.texts,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Syarat :',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: texts.map((text) {
            return Text(
              '◉ $text',
              style: TextStyle(
                fontSize: 14,
              ),
            );
          }).toList(),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Semua berkas diatas disatukan dalam satu file PDF/Word max 2Mb',
          style: TextStyle(
            fontSize: 14,
          ),
        )
      ],
    );
  }
}