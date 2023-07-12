import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siak/core/utils/color_pallete.dart';
import 'package:siak/core/utils/size_utils.dart';

class SiakAppbar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onImageTap;
  final String? imagePath;

  SiakAppbar({this.onImageTap, this.imagePath});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final String finalImagePath = imagePath ?? 'assets/images/logoust.png';

    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15),
        ),
      ),
      backgroundColor: SiakColors.SiakPrimary,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: GestureDetector(
            onTap: onImageTap,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(finalImagePath),
                ),
              ),
            ),
          ),
        ),
      ],
      title: Text(
        "Fakultas Ilmu Komputer",
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: MediaQuery.of(context).size.width / 20,
        ),
      ),
      centerTitle: true,
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    required this.height,
    this.styleType,
    this.leadingWidth,
    this.leading,
    this.title,
    this.centerTitle,
    this.actions,
  });

  double height;

  Style? styleType;

  double? leadingWidth;

  Widget? leading;

  Widget? title;

  bool? centerTitle;

  List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: height,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: _getStyle(),
      leadingWidth: leadingWidth ?? 0,
      leading: leading,
      title: title,
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(
    size.width,
    height,
  );
  _getStyle() {
    switch (styleType) {
      case Style.bgFillRed900:
        return Container(
          height: getVerticalSize(
            66,
          ),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: SiakColors.red900,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(
                getHorizontalSize(
                  10,
                ),
              ),
              bottomRight: Radius.circular(
                getHorizontalSize(
                  10,
                ),
              ),
            ),
          ),
        );
      default:
        return null;
    }
  }
}

enum Style {
  bgFillRed900,
}
