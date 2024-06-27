import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgImage extends StatelessWidget {
  String imageName;
  double? height;
  double? width;
  Color? color;
  BoxFit? fit;

  CustomSvgImage({required this.imageName, this.height, this.width, this.color, this.fit});
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      imageName,
      color: color,
      // colorFilter: ColorFilter.mode(color??, blendMode),
      height: height,
      width: width,
      fit: fit ?? BoxFit.contain,
    );
  }
}

class CustomSvgImageNetwork extends StatelessWidget {
  String imageName;
  double? height;
  double? width;
  Color? color;
  BoxFit? fit;

  CustomSvgImageNetwork({required this.imageName, this.height, this.width, this.color, this.fit});
  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      imageName,
      color: color,
      height: height ?? 30.h,
      width: width ?? 30.w,
      fit: fit ?? BoxFit.contain,
    );
  }
}
