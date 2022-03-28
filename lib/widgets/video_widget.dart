import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/consts/text_styles.dart';
import 'package:pleyo_tablet_app/model/game_model.dart';
import 'package:pleyo_tablet_app/widgets/custom_text.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatelessWidget {
  final int buttonColor;
  final GameModel _gameModel;
  final VoidCallback onTap;
  late VideoPlayerController _controller;
  RxBool isInitialized = false.obs;
  VideoWidget(this._gameModel,
      {required this.onTap, required this.buttonColor, Key? key})
      : super(key: key) {
    _controller = VideoPlayerController.network(_gameModel.url,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..initialize().then((_) {
        isInitialized.value = true;
        _controller.play();
      });
    _controller.setLooping(true);
    _controller.setVolume(0.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 315,
        height: 256,
        margin: EdgeInsets.only(right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 300,
              height: 180,
              child: ObxValue<RxBool>((state) {
                return state.value
                    ? Container()
                    : Container(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color(buttonColor),
                          ),
                        ),
                      );
              }, isInitialized),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(buttonColor),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/icon_awesome_play.svg',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    children: [
                      CustomText(
                        _gameModel.name,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        textStyle: TextStyles.textLarge.copyWith(
                          fontWeight: FontWeight.normal,
                          color: const Color(ColorCode.white4Background),
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      CustomText(
                        _gameModel.description,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        textStyle: TextStyles.textMedium.copyWith(
                          color: const Color(ColorCode.white2Background),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
