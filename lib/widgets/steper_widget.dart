import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import '../consts/colors.dart';

class StepperWidget extends StatelessWidget {
  final bool isChoiceActive;
  final bool isGenerateActive;
  final bool isPrintingActive;

  const StepperWidget({
    Key? key,
    this.isChoiceActive = false,
    this.isGenerateActive = false,
    this.isPrintingActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 335,
      child: Stack(
        children: [
          Positioned(
              top: 22,
              right: 20,
              left: 20,
              child: Container(
                height: 2,
                color: const Color(0xffe6e6e6),
              )),
          Column(
            children: [
              Row(
                children: [
                  stepItem("CHOICE", isChoiceActive),
                  Expanded(
                    child: Container(),
                  ),
                  stepItem("GENERATE", isGenerateActive),
                  Expanded(
                    child: Container(),
                  ),
                  stepItem("PRINTING", isPrintingActive)
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget stepItem(String title, bool isActive) {
    return SizedBox(
      height: 69,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            top: 10,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 16.0,
                height: 16.0,
                decoration: const BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: isActive ? 1.0 : 0.0,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 46.0,
                  height: 46.0,
                  decoration: const BoxDecoration(
                    color: Color(0xffbfbfbf),
                    borderRadius:
                        BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: 20,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 6.0,
                height: 6.0,
                decoration: const BoxDecoration(
                  color: Color(0xff000000),
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 46,
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Arial',
                  fontSize: 10,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
                textHeightBehavior:
                    const TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.center,
                softWrap: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
