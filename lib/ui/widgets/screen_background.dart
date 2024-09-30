import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/assets_path.dart';

class ScreenBackground extends StatelessWidget {
  const ScreenBackground({
    super.key, required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        SvgPicture.asset(AssetsPath.backgroundSvg,
          fit: BoxFit.cover,
          height: screenSize.height,
          width: screenSize.width,
        ),
        SafeArea(child: child),


      ],
    );
  }
}