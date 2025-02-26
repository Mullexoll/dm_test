import 'package:dayme_test/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CloseActionButton extends StatelessWidget {
  final void Function() onTap;

  const CloseActionButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SvgPicture.asset(
        AppAssets.closeIcon,
        width: 48,
        height: 48,
      ),
    );
  }
}
