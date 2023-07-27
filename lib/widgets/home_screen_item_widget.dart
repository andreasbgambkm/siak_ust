import 'package:flutter/material.dart';
import 'package:siak/core/utils/image_constant.dart';
import 'package:siak/core/utils/size_utils.dart';
import 'package:siak/screen/berita/berita_terkini.dart';
import 'package:siak/theme/app_decoration.dart';
import 'package:siak/theme/app_style.dart';
import 'package:siak/widgets/home_widgets/custom_image_view.dart';

// ignore: must_be_immutable
class HomeScreenItemWidget extends StatelessWidget {
  final String title;
  final String description;
  final String? url;

  HomeScreenItemWidget({
    required this.title,
    required this.description,
     this.url,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          height: getVerticalSize(
            215,
          ),
          width: getHorizontalSize(
            333,
          ),
          margin: getMargin(
            right: 20,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgRectangle146,
                height: getVerticalSize(
                  215,
                ),
                width: getHorizontalSize(
                  333,
                ),
                radius: BorderRadius.circular(
                  getHorizontalSize(
                    10,
                  ),
                ),
                alignment: Alignment.center,
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                  child: Container(

                    decoration: AppDecoration.fillBlack90084.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder10,
                    ),
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 3, left: 5, right: 5),
                          child: Text(
                            title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtPoppinsSemiBold16Yellow300,
                          ),
                        ),
                        Text(
                         description,
                           maxLines: 3,
                          textAlign: TextAlign.left,
                          style: AppStyle.txtPoppinsMedium16WhiteA700,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          child: InkWell(
                            onTap: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  SiakNews(urlBerita: url,)),

                              );
                            },
                            child: Text(
                              "Baca Selengkapnya",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtPoppinsMedium13Gray600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
