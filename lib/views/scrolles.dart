import 'package:flutter/material.dart';

class CustomScrollBehavior extends MaterialScrollBehavior {
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return GlowingOverscrollIndicator(
      axisDirection: axisDirection,
      color: const Color.fromARGB(255, 243, 189, 108), // Cambia el color aquí
      child: child,
    );
  }
}
