import 'package:flutter/material.dart';

class SiakCard extends StatelessWidget {
  final Widget? child;
  final double shadow;
  const SiakCard({key ,required this.child,required this.shadow});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left:10 ,right: 10),
      alignment: Alignment.topLeft,
      child:child,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          border: Border.all(
              color: Color.fromARGB(255, 201, 201, 201), width: 2),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 201, 201, 201),
                offset: Offset(shadow, shadow)),
          ]),
    );
  }
}