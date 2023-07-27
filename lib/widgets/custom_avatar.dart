import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;

  const CustomAvatar({
    required this.radius,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
      child: imageUrl == null
          ? Image.asset(
        'assets/images/siak_user.png',
        width: radius * 2,
        height: radius * 2,
        fit: BoxFit.contain,
      )
          : null,
    );
  }
}
