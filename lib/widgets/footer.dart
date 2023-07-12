import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(

          height: MediaQuery.of(context).size.height/8,
          width:250,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/footer.png'),
              )
          )),
    );
  }
}