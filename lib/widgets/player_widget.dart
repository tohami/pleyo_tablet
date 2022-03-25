import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';

class PlayerWidget extends StatelessWidget {
  final bool addPlayer;
  final bool isSelected;
  final String playerName;
  final VoidCallback? onTap;

  const PlayerWidget({
    Key? key,
    this.addPlayer = false,
    this.isSelected = false,
    this.playerName = 'Ajouter',
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 210,
        margin: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: const Color(ColorCode.darkGrayBackground),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            width: 3.0,
            color: isSelected
                ? const Color(ColorCode.accentLightColor)
                : const Color(ColorCode.whiteBackground),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(ColorCode.blackBackground),
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Container(
          margin: EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                addPlayer
                    ? 'assets/images/icon_add_person.svg'
                    : 'assets/images/icon_person_white.svg',
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: 5,
              ),
              CustomText(
                playerName,
                textStyle: TextStyles.textMedium.copyWith(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
