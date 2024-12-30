import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;
  final Widget? tablet;

  // Định nghĩa Constructor
  const ResponsiveWidget({
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  // Xác định xem có phải màn hình mobile hay không
  static bool isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 904;
  }
  static bool isTablet(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 1280 &&
    MediaQuery.sizeOf(context).width >= 904;
  }

  // Xác định xem có phải màn hình desktop hay không
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1280;
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    if (size.width >= 1280) {
      return desktop;
    }
    else if (size.width >= 904 && tablet != null) {
      return tablet!;
    }
    else {
      return mobile;
    }
  }
}
