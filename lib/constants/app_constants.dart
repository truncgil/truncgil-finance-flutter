import 'package:flutter/material.dart';

class AppConstants {
  static const double scrollOffsetRatio = 0.15; // Scroll mesafesi oranı

  // Ekran yüksekliğinin belirli bir oranı kadar scroll mesafesi
  static double getScrollOffset(BuildContext context) {
    return MediaQuery.of(context).size.height * scrollOffsetRatio;
  }
}
