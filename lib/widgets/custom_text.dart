import 'package:flutter/material.dart';

import '../consts/text_styles.dart';

class CustomText extends StatelessWidget {
  final String text;
  final int maxLines;
  final TextStyle textStyle;
  final TextAlign textAlign;
  final TextHeightBehavior? textHeightBehavior;

  const CustomText(this.text,
      {Key? key,
      this.textStyle = TextStyles.textMedium,
      this.maxLines = 2,
      this.textAlign = TextAlign.center,
      this.textHeightBehavior,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      textHeightBehavior: textHeightBehavior,
    );
  }
}
