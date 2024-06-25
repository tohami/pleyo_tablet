import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';


class ScaleWidget extends StatelessWidget {
  final TransitionBuilder builder;
  final Widget child;

  const ScaleWidget({required this.builder, required this.child, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return builder(context, child);
  }
}


scaleWidgetBuilder(BuildContext context,Widget child , {bool withBouncingScroll = true}) {
  return MaxWidthBox(
    maxWidth: 1024,
    background: Container(color: const Color(0xFFF5F5F5)),
    child: ResponsiveScaledBox(

        width: ResponsiveValue<double>(context, conditionalValues: [
          Condition.equals(name: TABLET, value: 600),
          Condition.equals(name: MOBILE, value: 600),
          // Condition.equals(name: TABLET, value: 768),
          // Condition.equals(name: DESKTOP, value: 1024),
        ] , defaultValue: 600).value,
        child: withBouncingScroll
            ? BouncingScrollWrapper.builder(context, child, dragWithMouse: true)
            : child),
  );
}