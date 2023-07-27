import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/model/RestAPI/user_login_api.dart';
import 'package:siak/model/data/angket/data_angket.dart';
import 'package:siak/screen/nilai/angket/isi_angket/components/pertanyaan_angket.dart';
import 'package:siak/widgets/app_bar/siakappbar.dart';
import 'package:dots_indicator/dots_indicator.dart';

class SiakIsiAngket extends StatefulWidget {

  final String? kdMatkul;
  const SiakIsiAngket({super.key, this.kdMatkul});

  @override
  _SiakIsiAngketState createState() => _SiakIsiAngketState();
}

class _SiakIsiAngketState extends State<SiakIsiAngket> {
  PageController _pageController = PageController(initialPage: 0);
  List<int> answers = List.filled(13, 0);
  bool isPageBuilt = false;
  DatabaseHelper _postIsiAngket = DatabaseHelper();

  dynamic token;

  @override
  void initState() {
    super.initState();
    _loadTokenDataFromPreferences();
    _pageController.addListener(() {
      if (_pageController.positions.isNotEmpty) {
        setState(() {
          isPageBuilt = true;
        });
      }
    });
  }

  Future<void> _loadTokenDataFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final tokenData = prefs.getString('token');
    print("Di bawah ini merupakan token dari local");
    print(tokenData);

    if (tokenData != null && tokenData.isNotEmpty) {
      setState(() {
        token = tokenData;
      });
    }
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _loadQuestions() {
    // Lakukan inisialisasi pertanyaan atau data dari sumber lain di sini
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SiakAppbar(),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: questionData.length,
              itemBuilder: (context, index) {
                return QuestionItemPage(
                  questionIndex: index,
                  answer: answers[index],
                  onAnswerSelected: (int? value) {
                    setState(() {
                      answers[index] = value!;
                    });
                  },
                  questionData: questionData[index],
                );
              },
            ),
          ),
          if (isPageBuilt)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DotsIndicator(
                      dotsCount: questionData.length,
                      position: _pageController.page!.toInt(),
                      decorator: DotsDecorator(
                        size: const Size.square(9.0),
                        activeSize: const Size(18.0, 9.0),
                        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                        activeColor: SiakColors.SiakPrimary,
                        spacing: EdgeInsets.symmetric(horizontal: 4),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_pageController.page!.toInt() > 0) {
                            _pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          }
                        },
                        child: Text('Sebelumnya'),
                        style: ElevatedButton.styleFrom(
                          primary: SiakColors.SiakPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_pageController.page!.toInt() < answers.length - 1) {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          } else {
                            bool isAllQuestionsAnswered = answers.every((answer) => answer > 0);

                            if (isAllQuestionsAnswered) {
                             await _sendData();
                             Fluttertoast.showToast(
                               msg: 'Angket Berhasil Dikirim!',
                               toastLength: Toast.LENGTH_SHORT,
                             );
                             Navigator.of(context).pushReplacementNamed("/NilaiPage");
                            } else {
                              Fluttertoast.showToast(
                                msg: 'Harap jawab semua pertanyaan terlebih dahulu!',
                                toastLength: Toast.LENGTH_SHORT,
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: SiakColors.SiakPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(_pageController.page!.toInt() < answers.length - 1
                            ? 'Selanjutnya'
                            : 'Kirim Angket'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Future _sendData() async {
    await _postIsiAngket.postIsiAngket(answers, widget.kdMatkul!, token);
    print(answers);
    print(token);
    print(widget.kdMatkul!);
  }
}
