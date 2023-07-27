import 'package:flutter/material.dart';



class SiakColors {
  static const SiakPrimary = Color(0xFFBE0D0D);
  static const SiakPrimaryLightColor = Color(0xFFFBF3ED);
  static const SiakLightColor = Color(0xFFFFBA98);
  static const SiakWhite = Color(0xFFFFFFFF);
  static const SiakBlack = Color(0xFF393939);
  static const SiakSecondaryLight = Color(0xFFA1C9CB);
  static const SiakGreenDark = Color(0xFF159900);
  static const SiakBlueLight = Color.fromARGB(255, 39, 135, 224);


  static Color gray700 = fromHex('#555555');

  static Color gray500 = fromHex('#9b9b9b');

  static Color blueGray100 = fromHex('#cdcdcd');

  static Color black900 = fromHex('#000000');

  static Color red900 = fromHex('#be0d0d');

  static Color black90084 = fromHex('#84000000');

  static Color blueGray700 = fromHex('#525252');

  static Color black9003f = fromHex('#3f000000');

  static Color whiteA700 = fromHex('#ffffff');

  static Color gray100 = fromHex('#f5f5f5');

  static Color gray600 = fromHex('#7f7f7f');

  static Color yellow300 = fromHex('#ffe769');

  static Color siakGreenDarkKrs = fromHex('#159900');




  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));

  }


}
