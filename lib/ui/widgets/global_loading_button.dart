import 'package:buksam_flutter_practicum/utils/extension/extension.dart';
import 'package:buksam_flutter_practicum/utils/style/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalLoadingButton extends StatefulWidget {
  const GlobalLoadingButton({
    super.key,
    required this.title,
    required this.onTap,
    this.borderColor = Colors.transparent,
    this.backgroundColor = Colors.blueAccent,
    this.textColor = Colors.white,
    this.borderRadius = 16,
    this.buttonHeight = 60,
    this.textStyle,
    this.isLoading = false,
  });

  final String title;
  final VoidCallback onTap;
  final Color borderColor, backgroundColor, textColor;
  final double borderRadius, buttonHeight;
  final TextStyle? textStyle;
  final bool isLoading;

  @override
  State<GlobalLoadingButton> createState() => _GlobalLoadingButtonState();
}

class _GlobalLoadingButtonState extends State<GlobalLoadingButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          curve: Curves.linearToEaseOut,
          width: widget.isLoading ? widget.buttonHeight.w : 300.w,
          height: widget.buttonHeight.w,
          decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: widget.isLoading
                  ? null
                  : BorderRadius.circular(widget.borderRadius.w),
              border: Border.all(
                width: 1,
                color: widget.borderColor,
              )),
          child: Center(
            child: widget.isLoading
                ? null
                : Text(
                    widget.title,
                    style: widget.textStyle ??
                        AppTextStyle.medium.copyWith(
                          color: widget.textColor,
                          fontSize: 24,
                        ),
                  ),
          ),
        ),
      ),
    );
  }
}
