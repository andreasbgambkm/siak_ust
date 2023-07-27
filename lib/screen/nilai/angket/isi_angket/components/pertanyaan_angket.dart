import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/widgets/title.dart';

class QuestionItemPage extends StatelessWidget {
  final int questionIndex;
  final int answer;
  final ValueChanged<int?> onAnswerSelected;

  // Tambahkan data pertanyaan ke constructor
  final Map<String, dynamic> questionData;

  QuestionItemPage({
    required this.questionIndex,
    required this.answer,
    required this.onAnswerSelected,
    required this.questionData, // Tambahkan ini
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TitlePage(
               title: 'Pertanyaan ${questionIndex + 1}',

              ),
            ),
            // Tampilkan pertanyaan dan opsi jawaban sesuai data
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right:  16.0),
                child: Text(questionData['question'], style: GoogleFonts.poppins(color: SiakColors.SiakBlack, fontSize: 15, fontWeight: FontWeight.bold),),
              ),
            ),
            ...questionData['options'].entries.map(
                  (entry) {
                final optionKey = entry.key;
                final optionValue = entry.value;
                return ListTile(
                  leading: Radio<int>(
                    value: answerValueToInt(optionKey),
                    groupValue: answer,
                    onChanged: onAnswerSelected,
                    activeColor: SiakColors.SiakPrimary,
                  ),
                  title: Text(optionValue, style: GoogleFonts.poppins(color: SiakColors.SiakBlack, fontSize: 14, fontWeight: FontWeight.w300),),
                );
              },
            ).toList(),
          ],
        ),
      ),
    );
  }

  // Helper function untuk mengubah string 'a', 'b', 'c', 'd', 'e' menjadi nilai int
  int answerValueToInt(String answerValue) {
    switch (answerValue) {
      case 'a':
        return 5;
      case 'b':
        return 4;
      case 'c':
        return 3;
      case 'd':
        return 2;
      case 'e':
        return 1;
      default:
        return 0;
    }
  }
}
