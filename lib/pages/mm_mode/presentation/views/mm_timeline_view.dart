import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/pages/mm_mode/presentation/controllers/mm_controller.dart';

import '../../../../base/library_item_model.dart';
import '../../../../model/strapi/game_variant.dart';

class MMTimeline extends GetView<MMController> {
  const MMTimeline({Key? key}) : super(key: key);

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
          backgroundColor: Color(0xff333333),
          body: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: LibrarySection(
                          title: 'Games Library', items: controller.games),
                    ),
                    VerticalDivider(color: Colors.white),
                    Expanded(
                      child: LibrarySection(
                          title: 'Videos Library', items: controller.videos),
                    ),
                  ],
                ),
              ),
              VerticalDivider(color: Colors.white),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    ControlBar(),
                    Expanded(child: TimelineView()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LibrarySection extends StatelessWidget {
  final String title;
  final List<GameVariant> items;

  LibrarySection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[850],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 135 / 175,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
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
                  child: LibraryItem(item: item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LibraryItem extends StatelessWidget {
  final GameVariant item;

  LibraryItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      height: 135,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: CachedNetworkImageProvider(item.image ?? ""),
            fit: BoxFit.cover,
            opacity: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.name ?? "",
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.timelapse,
                size: 12,
                color: Colors.white,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                (item.duration! / 60).toStringAsFixed(1),
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                "Minutes",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
          item.type == "GAME"
              ? Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 12,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      item.description ?? "",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                )
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
      color: Colors.grey[100],
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4, bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
                    activeColor: Colors.green,
                  );
                }),
              ),
            ],
          ),
          Row(
            children: [
              Obx(() {
                return Visibility(
                  visible: controller.currentGameIndex.value > 0,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: IconButton(
                    icon: Icon(Icons.skip_previous, color: controllersColor),
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
                        controller.pauseGame();
                      }
                    },
                    child: Icon(
                        state.value
                            ? Icons.play_circle_outline
                            : Icons.pause_circle_outline,
                        color: controllersColor,
                        size: 20),
                  );
                }, controller.isPaused),
              ),
              Obx(() {
                return Visibility(
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: controller.currentGameIndex.value <
                      controller.timelineItems.length - 1,
                  child: IconButton(
                    icon: Icon(Icons.skip_next, color: controllersColor),
                    onPressed: controller.playNext,
                  ),
                );
              }),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('session Duration',
                  style: TextStyle(color: Colors.green, fontSize: 8)),
              ObxValue((state) {
                return Text(
                    controller
                        .formatDuration(controller.calculateSessionDuration()),
                    style: TextStyle(color: controllersColor, fontSize: 12));
              }, controller.timelineItems),
            ],
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
          color: Color(0xff4D4D4D),
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Current Time',
                      style: TextStyle(color: Color(0xffBFDCFF), fontSize: 8)),
                  Obx(() {
                    return Text(
                      controller
                          .formatDuration(controller.playlistProgress.value),
                      style: TextStyle(color: Color(0xff2186FC), fontSize: 12),
                    );
                  }),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Time to end',
                      style: TextStyle(color: Colors.red, fontSize: 8)),
                  Obx(() {
                    int timeToEnd = controller.calculateSessionDuration() -
                        controller.playlistProgress.value;
                    return Text(
                      controller.formatDuration(timeToEnd),
                      style: TextStyle(color: Color(0xff2186FC), fontSize: 12),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 8, right: 8, top: 3, bottom: 2),
          child: Obx(() {
            double progress = controller.playlistProgress.value /
                controller.calculateSessionDuration();
            return LinearProgressIndicator(
              color: Color(0xff52A2FF),
              value: progress.isNaN || progress.isInfinite ? 0 : progress,
              backgroundColor: Color(0xff4D4D4D),
              minHeight: 1,
            );
          }),
        ),
        Expanded(
          child: DragTarget<GameVariant>(
            onWillAcceptWithDetails: (data) {
              controller.dropIndex.value = -1;
              return true;
            },
            onMove: (details) {
              double totalWidth = 0;
              for (int i = 0; i < controller.timelineItems.length; i++) {
                totalWidth += controller.timelineItems[i].duration! * controller.secondToWidthRatio;
                if (details.offset.dx < totalWidth) {
                  controller.dropIndex.value = i;
                  break;
                }
              }
              if (details.offset.dx >= totalWidth) {
                controller.dropIndex.value = controller.timelineItems.length;
              }
            },
            onLeave: (data) {
              controller.dropIndex.value = -1;
            },
            onAcceptWithDetails: (data) {
              if (controller.dropIndex.value != -1) {
                controller.timelineItems
                    .insert(controller.dropIndex.value, data.data.copyWith(internalId: DateTime.now().millisecondsSinceEpoch));
              } else {
                controller.timelineItems.add(data.data);
              }
              controller.dropIndex.value = -1;
            },
            builder: (context, candidateData, rejectedData) {
              return Container(
                color: Colors.black,
                child: Obx(() {
                  return ReorderableListView(
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
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          child: Container(
                            width: controller.timelineItems[index].duration! *
                                controller.secondToWidthRatio,
                            child: TimelineItem(
                              key: ValueKey(
                                  '${controller.timelineItems[index].internalId}'),
                              item: controller.timelineItems[index],
                              isCurrent:
                                  index == controller.currentGameIndex.value,
                              isGrayedOut: index <
                                      controller.currentGameIndex.value ||
                                  index > controller.currentGameIndex.value + 1
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
          onTap: () {
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

class TimelineItem extends StatelessWidget {
  final GameVariant item;
  final bool isCurrent;
  final bool isGrayedOut;
  // final double width;

  TimelineItem(
      {Key? key,
      required this.item,
      required this.isCurrent,
      required this.isGrayedOut,
      /*required this.width*/})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: width,
      height: 135,
      margin: const EdgeInsets.all(4.0),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: CachedNetworkImageProvider(item.image ?? ""),
            fit: BoxFit.cover,
            opacity: isGrayedOut ? 0.2 : 0.4),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isCurrent ? Colors.green : Colors.transparent,
          width: 3,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.name ?? "",
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.timelapse,
                size: 12,
                color: Colors.white,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                (item.duration! / 60).toStringAsFixed(1),
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                "Minutes",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
          // item.type == "GAME"
          //     ? Row(
          //         children: [
          //           Icon(
          //             Icons.person,
          //             size: 12,
          //             color: Colors.white,
          //           ),
          //           SizedBox(
          //             width: 4,
          //           ),
          //           Text(
          //             item.description ?? "",
          //             style: TextStyle(color: Colors.white, fontSize: 12),
          //           ),
          //         ],
          //       )
          //     : Container(),
        ],
      ),
    );
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
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Center(
        child: Text(
          'Drop here',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}
