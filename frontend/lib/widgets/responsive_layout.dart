import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScaffold;
  final Widget desktopScaffold;

  const ResponsiveLayout({
    Key? key,
    required this.mobileScaffold,
    required this.desktopScaffold,
  }) : super(key: key);

  // Batas ukuran layar (breakpoint) untuk membedakan mobile dan desktop
  static const int desktopBreakpoint = 1024;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < desktopBreakpoint) {
          // Tampilan untuk Smartphone / Layar Kecil
          return mobileScaffold;
        } else {
          // Tampilan untuk Desktop / Web / Laptop / Tablet besar
          return desktopScaffold;
        }
      },
    );
  }
}