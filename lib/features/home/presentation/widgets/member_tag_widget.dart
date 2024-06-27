import 'package:flutter/material.dart';

import '../../../../shared/resources/color_manager.dart';
import '../../../../shared/resources/font_manager.dart';
import '../../../../shared/resources/manager_values.dart';
import '../../../../shared/resources/styles_manager.dart';


class TagWidget extends StatefulWidget {
  const TagWidget({
    super.key,
    required this.name,
    required this.onPress,
  });

  final String name;
  final Function onPress;

  @override
  State<TagWidget> createState() => _TagWidgetState();
}

class _TagWidgetState extends State<TagWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p12, vertical: AppPadding.p8),
      decoration: BoxDecoration(
        // color: ColorManager.background,
        border: Border.all(color: ColorManager.primary),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.name,
            style: getRegularStyle(
              fontSize: FontSize.s14,
              // color: ColorManager.te,
            ),
          ),
          const SizedBox(width: AppPadding.p4,),
          InkWell(
            onTap: () {
              widget.onPress();
            },
            child: const Icon(
              Icons.close,
              color: ColorManager.primary,
              size: AppSize.s18,
            ),
          ),
        ],
      ),
    );
  }
}
