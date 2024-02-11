import 'package:flutter/material.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';

class GameAttemptItem extends StatelessWidget {
  final bool isSelected;

  const GameAttemptItem({Key? key, this.isSelected = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      height: 15,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(ColorCode.lightGrey)
            : const Color(ColorCode.lightGrey7),
        borderRadius: const BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
      ),
    );
  }
}
