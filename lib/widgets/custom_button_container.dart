import 'package:flutter/material.dart';

class CustomButtonContainer extends StatelessWidget {
  final double width;
  final double height;
  final Widget buttonWidget;

  const CustomButtonContainer(this.buttonWidget,
      {required this.width, required this.height, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.zero,
      child: buttonWidget,
    );
  }
}
