import 'package:flutter/material.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';

class PlayerResultItem extends StatelessWidget {
  final String playerImageURl;
  final bool isEnabled;

  const PlayerResultItem({Key? key, required this.playerImageURl, required this.isEnabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      margin: EdgeInsets.only(right: 20),
      child: Stack(
        children: [
          Image.asset(
            playerImageURl,
            width: 80,
            height: 80,
          ),
          Visibility(
            visible: !isEnabled,
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Color(ColorCode.shadowColor),
                  offset: Offset(0, 6),
                  blurRadius: 12,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
