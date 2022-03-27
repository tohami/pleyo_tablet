import 'package:flutter/material.dart';

class CustomButtonContainer extends StatelessWidget {
  final double width;
  final double height;
  final Widget buttonWidget;
  final double borderWidth;
  final int borderColor;

  const CustomButtonContainer(this.buttonWidget,
      {required this.width,
      required this.height,
      this.borderWidth = 0,
      this.borderColor = 0,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        border: Border.all(width: borderWidth, color: Color(borderColor)),
      ),
      child: buttonWidget,
    );
  }
}
