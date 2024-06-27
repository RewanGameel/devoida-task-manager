import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resources/assets_manager.dart';

import '../../resources/color_manager.dart';
import '../../resources/manager_values.dart';
import '../../resources/size_config.dart';
import '../../resources/styles_manager.dart';
import 'check_view_widget.dart';
import 'custom_image_widget.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool? canGoBack;
  final bool? isCenterTitle;
  final Function? onBackPress;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final Widget? leadingWidget;
  final double? height;
  CustomAppBar({
    Key? key,
    required this.title,
    this.canGoBack = true,
    this.isCenterTitle,
    this.onBackPress,
    this.backgroundColor,
    this.actions,
    this.leadingWidget,
    this.height,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size(
        size.width,
        height != null ? height!.h : 65,
      );
}

class _CustomAppBarState extends State<CustomAppBar> {
  DeviceScreenType deviceScreenType = DeviceScreenType.Mobile;
  void onChangeView(DeviceScreenType value) {
    deviceScreenType = value;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        onChangeView: onChangeView,
        smallScreen: AppBar(
          centerTitle: widget.isCenterTitle ?? false,
          automaticallyImplyLeading: widget.canGoBack ?? true,
          toolbarHeight: widget.height,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: ColorManager.backgroundDark,
            ),
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: ColorManager.lightPrimary, statusBarBrightness: Brightness.light, statusBarIconBrightness: Brightness.dark),
          title: Padding(
            padding: getPadding(top: AppPadding.p10),
            child: Text(
              widget.title,
              style: getMediumStyle(color: ColorManager.textColor),
            ),
          ),
          leading: widget.canGoBack ?? true
              ? InkWell(
                  onTap: widget.onBackPress != null
                      ? widget.onBackPress as void Function()?
                      : () {
                          Navigator.pop(context);
                        },
                  child: widget.leadingWidget ??
                    Container(
                      padding: getPadding(horizontal: AppPadding.p16, vertical: AppPadding.p12),
                      margin: getPadding(horizontal: AppPadding.p16, vertical: AppPadding.p8),
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(AppPadding.p8),
                        boxShadow: [BoxShadow(blurRadius: 10, spreadRadius: 2, color: const Color(0xffd3d1d8).withOpacity(0.22))],
                      ),
                      child: CustomSvgImage(
                        height: 12,
                        width: 12,
                        imageName: Assets.assetsSvgArrowBack,
                      ),
                    ))
              : Container(
                  width: 20,
                ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leadingWidth: (widget.canGoBack ?? true)
              ? deviceScreenType == DeviceScreenType.Mobile
                  ? 75
                  : deviceScreenType == DeviceScreenType.Tablet
                      ? 80
                      : 80
              : 16,
          titleSpacing: 0,
          actions: widget.actions ?? [],
        ));
  }
}
