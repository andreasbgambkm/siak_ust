import 'package:flutter/material.dart';

class CustomFileUploadButton extends StatelessWidget {
  final String title;

  final void Function() onPressed;

  CustomFileUploadButton({
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Color(0xFF800000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Color(0xFF800000)),
                ),
                minimumSize: Size(100, 30),
              ),
              child: Text(
                'Pilih File',
                style: TextStyle(color: Color(0xFF800000)),
              ),
            ),
            SizedBox(width: 10),
            Text(
              'belum ada file',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ],
    );
  }
}
