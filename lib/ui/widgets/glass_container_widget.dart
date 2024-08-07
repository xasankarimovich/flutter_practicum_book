import 'package:buksam_flutter_practicum/utils/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
class GlassContainerWidget extends StatelessWidget {
  const GlassContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: SizedBox(
        height: 400.h,
        width: double.infinity,
        child: GlassContainer(
          gradient: LinearGradient(
            colors: [
              Colors.grey.withOpacity(0.30),
              Colors.white.withOpacity(0.30),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderGradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.10),
              Colors.purpleAccent.withOpacity(0.05),
              Colors.purpleAccent.withOpacity(0.60),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.30, 0.49, 0.70, 1.0],
          ),
          blur: 2,
          borderRadius: BorderRadius.circular(24.0),
          borderWidth: 5.0,
          elevation: 3.0,
          isFrostedGlass: true,
          shadowColor: Colors.purple.withOpacity(0.0),
        ),
      ),
    );
  }
}
