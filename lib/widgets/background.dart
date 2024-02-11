import 'package:flutter/material.dart';
import 'package:hackthisfall/constants/color.dart';

Container buildBackgroundGradient() {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          orange,
          yellow,
          cyan,
        ],
      ),
    ),
  );
}
