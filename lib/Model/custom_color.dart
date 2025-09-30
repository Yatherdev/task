import 'package:flutter/material.dart';

class CustomColors {
  // درجات الدم
  static const Color white = Color(0xFFFFFFFF);
  static const Color oxygenated = Color(0xFFFF4C4C); // دم مؤكسج (فاتح)
  static const Color arterial   = Color(0xFFB22222); // دم قاني
  static const Color venous     = Color(0xFF8A0303); // دم وريدي
  static const Color clotted    = Color(0xFF5C0000); // دم متجلط
  static const Color dried      = Color(0xFF3B0A0A); // دم جاف/قديم

  // ألوان إضافية (اختيارية)
  static const Color mediumRed  = Color(0xFFCC0000);
  static const Color darkRed    = Color(0xFF990000);
  static const Color maroon     = Color(0xFF800000);

  // Gradient خطي
  static const LinearGradient linearGradient = LinearGradient(
    colors: [
      oxygenated,
      arterial,
      venous,
      clotted,
      dried,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Gradient دائري
  static const RadialGradient radialGradient = RadialGradient(
    colors: [
      oxygenated,
      arterial,
      venous,
      clotted,
      dried,
    ],
    center: Alignment.center,
    radius: 0.8,
  );
}