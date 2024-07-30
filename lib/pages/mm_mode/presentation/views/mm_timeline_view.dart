import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/consts/colors.dart';
import 'package:pleyo_tablet_app/model/start_game.dart';
import 'package:pleyo_tablet_app/pages/mm_mode/presentation/controllers/mm_controller.dart';
import 'package:pleyo_tablet_app/widgets/scale_widget.dart';

import '../../../../base/library_item_model.dart';
import '../../../../model/strapi/game_variant.dart';

final containersColor = Color(0xff1E1E1E) ;
final timelineItemWidth = 180.0 ;
class MMTimeline extends GetView<MMController> {
  MMTimeline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          // Resetting the orientation to default when leaving this screen
          SystemChrome.setPreferredOrientations(DeviceOrientation.values);
          return true;
        },
        child: Scaffold(
          backgroundColor: Color(0xff323232),
          body: Container(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 48 ,right: 48,top:16 /*, bottom: 24*/),
                  child: Row(
                    children: [
                      Expanded(
                        child: LibrarySection(
                            title: 'Games Library', items: controller.games),
                      ),
                      SizedBox(width: 8,),
                      Container(
                        width: 550,
                        child: LibrarySection(
                            title: 'Videos Library', items: controller.videos),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 48 ,right: 48, top:15 , bottom: /*34*/16),
                  child: ControlBar(),
                ),
                Expanded(child: TimelineView()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LibrarySection extends StatelessWidget {
  final String title;
  final List<GameVariant> items;
  final _scrollController = ScrollController();

  LibrarySection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[850],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 32 , fontFamily: 'Cocon' ),
            ),
          ),
          Scrollbar(
            thickness: 14,
            thumbVisibility: true,
            interactive: true,
            radius: Radius.circular(8),
            controller: _scrollController,
            child: Container(
              height: 382,
              padding: EdgeInsets.only(left: 36 , right: 36 , top: 16, bottom: 49),
              decoration: BoxDecoration(
                color: containersColor,
                borderRadius: BorderRadius.all(Radius.circular(16))
              ),
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 135 / 185,
                  mainAxisSpacing: 22,
                  crossAxisSpacing: 42,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  var item = items[index];

                  return Draggable<GameVariant>(
                    data: item,
                    feedback: Container(
                      child: Material(
                        color: Colors.transparent,
                        child: LibraryItem(item: item),
                      ),
                    ),
                    childWhenDragging: Opacity(
                      opacity: 0.5,
                      child: LibraryItem(item: item),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Get.find<MMController>().addTimeLineItem(item) ;
                      },
                        child: LibraryItem(item: item)
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Offset adjustPosition(BuildContext context, Offset position){
  final RenderBox? renderObject = context.findRenderObject() as RenderBox?;
  return renderObject?.globalToLocal(
    Offset(
      position.dx,
      position.dy,
    ),
  ) ?? position;
}

class InfoWidget extends StatelessWidget{
  final String label ;
  final String value ;
  final Widget icon ;
  final Color valueColor ;

  const InfoWidget ({Key? key, required this.label , required this.value , required this.icon , required this.valueColor}) : super(key: key) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 32,
      padding: EdgeInsets.only(left: 6 , right: 6),
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.white
        ),
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(fontFamily: 'Inter', color: valueColor, fontSize: 24 , fontWeight: FontWeight.w700, height: 1 ),
          ),
          SizedBox(
            width: 4,
          ),
          Text(
           label,
            style: TextStyle(fontFamily: 'Inter',color: Colors.white, fontSize: 16 , height: 1),
          ),
          Spacer(
          ),
          icon,
        ],
      ),
    ) ;
  }

}
class LibraryItem extends StatelessWidget {
  final GameVariant item;

  LibraryItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 185,
      height: 135,
      padding: EdgeInsets.only(left: 8 ,right: 8, top: 4 , bottom: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          stops: [
            0 , 0.44 , 1
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.5),
            Color(0xff888888).withOpacity(0.25),
            Colors.white.withOpacity(0.5)
          ]
        ),
        image: DecorationImage(
            image: CachedNetworkImageProvider(item.image ?? ""),
            fit: BoxFit.cover,
            opacity: 0.5),
        border: Border.all(
          color: Color(ColorCode.aqua)
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              item.name ?? "",
              style: TextStyle(fontFamily: 'Inter',
                height: 1,
                  color: Colors.white, fontSize: 26, fontWeight: FontWeight.w900),
            ),
          ),
          InfoWidget(
              label: item.duration! < 60 ? "Sec" : "Min",
              value: item.duration! < 60
                  ? item.duration.toString()
                  : (item.duration! / 60).toStringAsPrecision(1),
              icon: SvgPicture.asset(
                'assets/images/icon_duration.svg',
                width: 24,
                color: Colors.white,
              ),
              valueColor: Colors.yellow),
          item.type == "GAME"
              ? InfoWidget(
                  label: "max",
                  value: item.attributes?.maxNumberOfPlayers?.toString() ?? "",
                  icon: SvgPicture.asset(
                    'assets/images/icon_players.svg',
                    width: 24,
                    color: Colors.white,
                  ),
                  valueColor: Colors.white)
              : Container(),
        ],
      ),
    );
  }
}

class ControlBar extends GetView<MMController> {
  final controllersColor = const Color(0xff4D4D4D);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 89,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(13),
              decoration: BoxDecoration(
                  color: containersColor,
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Program Duration',
                          style: TextStyle(fontFamily: 'Inter',
                              color: Color(0xff9F9F9F), fontSize: 14, height: 1)),
                      SizedBox(height: 6,),
                      ObxValue((state) {
                        return Text(
                            controller.formatDuration(
                                controller.calculateSessionDuration()),
                            style: TextStyle(fontFamily: 'Inter',
                                color: Color(ColorCode.aqua),
                                fontSize: 30,
                                fontWeight: FontWeight.bold));
                      }, controller.timelineItems),
                    ],
                  ),
                  Spacer() ,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Remaining Program Duration',
                          style: TextStyle(fontFamily: 'Inter',
                              color: Color(0xff9F9F9F), fontSize: 14, height: 1)),
                      SizedBox(height: 6,),
                      Obx(() {
                        int timeToEnd = controller.calculateSessionDuration() -
                            controller.playlistProgress.value;
                        return Text(
                            controller.formatDuration(
                                timeToEnd),
                            style: TextStyle(fontFamily: 'Inter',
                                color: Color(ColorCode.aqua),
                                fontSize: 30,
                                fontWeight: FontWeight.bold));
                      })
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 14,),
          Container(
            width: 250,
            padding: EdgeInsets.all(13),
            decoration: BoxDecoration(
                color: containersColor,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(() {
                  return Visibility(
                    visible: controller.currentGameIndex.value > 0,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: IconButton(
                      icon: Icon(Icons.skip_previous, color: Color(ColorCode.aqua) , size: 48,),
                      onPressed: controller.playPrevious,
                    ),
                  );
                }),
                Container(
                  child: ObxValue<RxBool>((state) {
                    return GestureDetector(
                      onTap: () {
                        if (state.value) {
                          controller.playPlayList();
                        } else {
                          controller.stopGame();
                        }
                      },
                      child: SvgPicture.asset(
                        state.value ? 'assets/images/icon_play.svg' : 'assets/images/icon_pause.svg',
                        width: 40,
                      )
                    );
                  }, controller.isPaused),
                ),
                Obx(() {
                  return Visibility(
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: (controller.currentGameIndex.value <
                        controller.timelineItems.length - 1 || (controller.currentGameIndex.value > -1 && controller.replayEnabled.value)),
                    child: IconButton(
                      icon: Icon(Icons.skip_next, color: Color(ColorCode.aqua) , size: 48,),
                      onPressed: controller.playNext,
                    ),
                  );
                }),
              ],
            ),
          ),
          SizedBox(width: 14,),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(13),
              decoration: BoxDecoration(
                  color: containersColor,
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Obx(() {
                    if(controller.timelineItems.isEmpty || controller.currentGameIndex < 0)
                      return Container() ;

                      return Text(
                          "${controller.currentGameIndex.value +1}/${controller.timelineItems.length}",
                          style: TextStyle(fontFamily: 'Inter',
                              color: Color(ColorCode.aqua),
                              fontSize: 30,
                              fontWeight: FontWeight.bold));
                    }
                  ),

                  SizedBox(width: 24,),
                  Container(
                    width: 1,
                    height: 40,
                    color: controllersColor,
                  ),
                  SizedBox(width: 24,),
                  Column(
                    children: [
                      Text('Loop play list',
                          style: TextStyle(fontFamily: 'Inter',
                              color: Color(0xff9F9F9F), fontSize: 14, height: 1)),
                      SizedBox(height: 0,),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.zero,
                            child: Obx(() {
                              return Switch(
                                value: controller.replayEnabled.value,
                                onChanged: (value) {
                                  controller.replayEnabled.value = value;
                                },
                                activeColor: Color(ColorCode.aqua),

                              );
                            }),
                          ),
                          SizedBox(width: 12,),
                          SvgPicture.asset(
                            'assets/images/icon_loop.svg',
                            width: 36,
                            height: 36,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),


                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class TimelineView extends GetView<MMController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          color: Color(0xff585858),
          height: 50,
          // child: Obx(() {
          //   int timeToEnd = controller.calculateSessionDuration() -
          //       controller.playlistProgress.value;
          //   return Column(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Container(
          //         // padding: EdgeInsets.only(left: controller.playlistProgress.value * controller.secondToWidthRatio),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.end,
          //           children: [
          //             Column(
          //               mainAxisAlignment: MainAxisAlignment.end,
          //               children: [
          //                 SvgPicture.asset(
          //                   'assets/images/icon_curser.svg',
          //                   width: 14,
          //                 ),
          //                 Container(
          //                   width: 1,
          //                   height: 10,
          //                   color: Color(ColorCode.aqua),
          //                 )
          //               ],
          //             ),
          //             SizedBox(
          //               width: 10,
          //             ),
          //             Column(
          //               mainAxisAlignment: MainAxisAlignment.end,
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
          //                 Text('current time ',
          //                     style: TextStyle(
          //                         fontFamily: 'Inter',
          //                         color: Color(0xff9F9F9F),
          //                         fontSize: 14,
          //                         height: 1)),
          //                 Text(controller.formatDuration(timeToEnd),
          //                     style: TextStyle(
          //                         fontFamily: 'Inter',
          //                         color: Color(ColorCode.aqua),
          //                         fontSize: 30,
          //                         fontWeight: FontWeight.bold))
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //       Container(
          //         // width: controller.playlistProgress.value * controller.secondToWidthRatio +7,
          //         height: 7,
          //         color: Color(ColorCode.aqua),
          //       )
          //     ],
          //   );
          // }),
        ),
        Expanded(
          child: DragTarget<GameVariant>(
            onWillAcceptWithDetails: (data) {
              controller.dropIndex.value = -1;
              return true;
            },
            onMove: (details) {
              var scaledOffset = adjustPosition(context, details.offset) ;
              double scrollOffset = controller.scrollController.offset;
              controller.dropIndex.value =
                  ((scaledOffset.dx + scrollOffset) ~/ timelineItemWidth).clamp(0, controller.timelineItems.length); // Adjusted calculation
            },
            onLeave: (data) {
              controller.dropIndex.value = -1;
            },
            onAcceptWithDetails: (data) {
              controller.addTimeLineItem(data.data) ;
            },
            builder: (context, candidateData, rejectedData) {
              return Container(
                color: Colors.black,
                child: Obx(() {
                  return ReorderableListView(
                    scrollController: controller.scrollController, // Set the ScrollController
                    proxyDecorator: (child, index, animation) {
                      return AnimatedBuilder(
                        animation: animation,
                        builder: (BuildContext context, Widget? child) {
                          final double animValue =
                              Curves.easeInOut.transform(animation.value);
                          final double elevation = lerpDouble(0, 6, animValue)!;
                          return Material(
                            elevation: elevation,
                            color: Colors.white,
                            shadowColor: Colors.white,
                            child: child,
                          );
                        },
                        child: child,
                      );
                    },
                    scrollDirection: Axis.horizontal,
                    onReorder: (int oldIndex, int newIndex) {
                      if (newIndex > oldIndex) {
                        newIndex -= 1;
                      }
                      final GameVariant item =
                          controller.timelineItems.removeAt(oldIndex);
                      controller.timelineItems.insert(newIndex, item);

                      if (oldIndex == controller.currentGameIndex.value) {
                        controller.currentGameIndex.value = newIndex;
                      } else if (oldIndex < controller.currentGameIndex.value &&
                          newIndex >= controller.currentGameIndex.value) {
                        controller.currentGameIndex.value--;
                      } else if (oldIndex > controller.currentGameIndex.value &&
                          newIndex <= controller.currentGameIndex.value) {
                        controller.currentGameIndex.value++;
                      }
                    },
                    children: [
                      for (int index = 0;
                          index < controller.timelineItems.length;
                          index++) ...[
                        if (controller.dropIndex.value != -1 &&
                            controller.dropIndex.value == index)
                          PlaceholderItem(key: ValueKey('placeholder_$index')),
                        Dismissible(
                          key: ValueKey(
                              '${controller.timelineItems[index].internalId}'),
                          onDismissed: (direction) {
                            if (index != controller.currentGameIndex.value) {
                              controller.timelineItems.removeAt(index);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    "${controller.timelineItems[index].name} removed from timeline"),
                              ));
                            }
                          },
                          direction: index == controller.currentGameIndex.value
                              ? DismissDirection.none
                              : DismissDirection.vertical,
                          background: Container(
                            color: Colors.red,
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topCenter,
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Icon(Icons.delete, color: Colors.white),
                                ),
                                Spacer(),
                                Container(
                                  alignment: Alignment.topCenter,
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Icon(Icons.delete, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          child: Container(
                            width: timelineItemWidth,
                            child: TimelineItem(
                              key: ValueKey(
                                  '${controller.timelineItems[index].internalId}'),
                              item: controller.timelineItems[index],
                              isCurrent:
                                  index == controller.currentGameIndex.value,
                              isNext: controller.currentGameIndex.value == index - 1,
                              isPrev: controller.currentGameIndex.value == index + 1,
                            ),
                          ),
                        ),
                      ],
                      if (controller.dropIndex.value != -1 &&
                          controller.dropIndex.value ==
                              controller.timelineItems.length)
                        PlaceholderItem(key: ValueKey('placeholder_end')),
                    ],
                  );
                }),
              );
            },
          ),
        ),
        GestureDetector(
          onTap: () async{
            if(controller.currentRunningItem != null){
              var result = await controller.showStopGameConfirmationDialog() ;
              if(!result) {
                return ;
              }
            }
            controller.currentGameIndex.value = -1 ;
            controller.stopGame() ;
            controller.timelineItems.clear();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Clear timeline',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}

class TimelineItem extends GetView<MMController> {
  final GameVariant item;
  final bool isCurrent;
  final bool isNext;
  final bool isPrev;
  // final double width;

  TimelineItem(
      {Key? key,
      required this.item,
      required this.isCurrent,
      required this.isNext,
      required this.isPrev
      /*required this.width*/})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<MMController>() ;
    return ObxValue<Rx<GameStatusType>>( (state) {
      bool isLoading = false ;
      if(isCurrent && [GameStatusType.IDLE, GameStatusType.STARTING].contains(state.value)){
        isLoading = true ;
      }
        return Container(
          // width: width,
          height: 160,
          margin: const EdgeInsets.all(4.0),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: CachedNetworkImageProvider(item.image ?? ""),
                fit: BoxFit.cover,
                opacity: 0.2 ),
            color: Color(isCurrent ? ColorCode.aqua : 0xffD9D9D9).withOpacity((isCurrent && isLoading) || isNext ? 0.5 : 1.0),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.name ?? "",
                    style: TextStyle( fontFamily: "Inter",
                        color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              Spacer() ,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Animate(child: getGameStatusWidget(state.value)),
                ],
              ),
              Spacer() ,
              InfoWidget(
                  label: item.duration! < 60 ? "Sec" : "Min",
                  value: item.duration! < 60
                      ? item.duration.toString()
                      : (item.duration! / 60).toStringAsPrecision(1),
                  icon: SvgPicture.asset(
                    'assets/images/icon_duration.svg',
                    width: 24,
                    color: Colors.white,
                  ),
                  valueColor: Colors.yellow),
              item.type == "GAME"
                  ? InfoWidget(
                  label: "max",
                  value: item.attributes?.maxNumberOfPlayers?.toString() ?? "",
                  icon: SvgPicture.asset(
                    'assets/images/icon_players.svg',
                    width: 24,
                    color: Colors.white,
                  ),
                  valueColor: Colors.white)
                  : Container(),
            ],
          ),
        );
      } , controller.currentGameStatus
    );
  }
  Widget getGameStatusWidget(GameStatusType type) {
    String title = "" ;
    if(isCurrent &&
        [GameStatusType.STARTED ,
          GameStatusType.STARTING ,
          GameStatusType.PAUSED ,
          GameStatusType.RESUMED , GameStatusType.UPDATED, GameStatusType.CLOSED].contains(type)){
      title = type.title ;
    }else if(isPrev && [GameStatusType.CLOSED , GameStatusType.FINISHED].contains(type)){
      title = type.title ;
    }
    return Container(
      child: isCurrent ? Text(
        title ,
        style: TextStyle( fontFamily: "Inter",
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
      ) :Container(),
    ) ;
  }
}

class PlaceholderItem extends StatelessWidget {
  const PlaceholderItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      height: 135,
      margin: const EdgeInsets.all(4.0),
      // decoration: BoxDecoration(
      //   color: Colors.grey[400],
      //   borderRadius: BorderRadius.circular(8),
      //   border: Border.all(color: Colors.white, width: 2),
      // ),
      child: Center(
        child: Text(
          'Drop here',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}
