import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/manager_values.dart';
import '../../resources/styles_manager.dart';
import 'custom_image_widget.dart';

enum EmptyScreenTypes {
  emptyList,
  emptyScreen,
  genericError,
}

class CustomEmptyScreen extends StatelessWidget {
  final String title;
  final bool? disableIcon;
  final String? description;
  final String? iconName;
  final Widget? actionWidget;
  final bool? emphasizeSvg;
  final EmptyScreenTypes? emptyScreenTypes;

  const CustomEmptyScreen({required this.title, this.description, this.iconName, this.actionWidget, this.emphasizeSvg, this.emptyScreenTypes, this.disableIcon = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (emptyScreenTypes != null) CustomSvgImage(imageName: emptyScreenTypes == EmptyScreenTypes.emptyList ? Assets.assetsSvgEmptyScreen : Assets.assetsSvgErrorScreen, width: 150,)
       else disableIcon==true ? const SizedBox.shrink(): Container(
          height: AppSize.s80,
          width: AppSize.s80,
          margin: const EdgeInsets.all(AppPadding.p8),
          padding: const EdgeInsets.all(AppPadding.p16),
          decoration: BoxDecoration(
            // color: ColorManager.primary.withOpacity(.16),
            color: ColorManager.lightPrimary,
            borderRadius: BorderRadius.circular(AppSize.s8),
          ),
          child: SvgPicture.asset(
            iconName ?? "",
            color: ColorManager.primary,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppPadding.p8),
          child: Text(
            title,
            style: getBoldStyle(color: ColorManager.primary, fontSize: FontSize.s20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppPadding.p8 / 2, bottom: AppPadding.p28),
          child: Text(
            description ?? '',
            textAlign: TextAlign.center,
            style: getRegularStyle(fontSize: FontSize.s14),
          ),
        ),
        actionWidget ?? const SizedBox(),
      ],
    );
  }
}
