import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/pages/mm_mode/presentation/controllers/mm_controller.dart';

class MMTimeline extends GetView<MMController> {
  const MMTimeline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TimelineScreen(),
    );
  }
}

class TimelineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Locking the orientation to landscape when this screen is displayed
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    return WillPopScope(
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
                    child: LibrarySection(title: 'Games Library', items: [
                      'Game 1',
                      'Game 2',
                      'Game 3',
                      'Game 4',
                      'Game 5',
                      'Game 6',
                      'Game 7',
                      'Game 8',
                      'Game 9',
                    ]),
                  ),
                  VerticalDivider(color: Colors.white),
                  Expanded(
                    child: LibrarySection(title: 'Videos Library', items: [
                      'Video 1',
                      'Video 2',
                      'Video 3',
                      'Video 4',
                      'Video 5',
                    ]),
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
    );
  }
}

class LibrarySection extends StatelessWidget {
  final String title;
  final List<String> items;

  LibrarySection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[850],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0 , top: 8.0, right: 8.0),
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 14 ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 6/7,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Draggable<String>(
                  data: items[index],
                  feedback: Material(
                    color: Colors.transparent,
                    child: LibraryItem(title: items[index]),
                  ),
                  childWhenDragging: Opacity(
                    opacity: 0.5,
                    child: LibraryItem(title: items[index]),
                  ),
                  child: LibraryItem(title: items[index]),
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
  final String title;

  LibraryItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.primaries[title.hashCode % Colors.primaries.length],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}

class ControlBar extends StatelessWidget {
  final controllersColor = const Color(0xff4D4D4D);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.only(left: 8.0 , right: 8.0,top: 4 , bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.zero,
                child: Icon(Icons.toggle_off, color: controllersColor, size: 20),
              ),
              Container(
                child: Icon(Icons.replay, color: controllersColor, size: 20),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                child: Icon(Icons.play_circle_outline, color: controllersColor, size: 20),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('session Duration', style: TextStyle(color: Colors.green, fontSize: 8)),
              Text('00:30:00', style: TextStyle(color: controllersColor, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

class TimelineView extends StatefulWidget {
  @override
  _TimelineViewState createState() => _TimelineViewState();
}

class _TimelineViewState extends State<TimelineView> {
  List<String> timelineItems = ['Game 1', 'Game 3', 'Video 2', 'Game 3', 'Game 3'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          color: Color(0xff4D4D4D),
          padding: const EdgeInsets.only(left: 8.0 , right: 8.0 , top: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Current Time', style: TextStyle(color: Color(0xffBFDCFF), fontSize: 8)),
                  Text('00:30:00', style: TextStyle(color: Color(0xff2186FC), fontSize: 12)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Time to end', style: TextStyle(color: Colors.red, fontSize: 8)),
                  Text('00:30:00', style: TextStyle(color: Color(0xff2186FC), fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 8 , right: 8 , top: 3 , bottom: 2),
          child: LinearProgressIndicator(
            color: Color(0xff52A2FF),
            value: 0.6,
            backgroundColor: Color(0xff4D4D4D),
            minHeight: 1,
          ),
        ),
        Expanded(
          child: DragTarget<String>(
            onAccept: (data) {
              setState(() {
                timelineItems.add(data);
              });
            },
            builder: (context, candidateData, rejectedData) {
              return Container(
            color: Colors.black,
                child: ReorderableListView(
              scrollDirection: Axis.horizontal,
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) {
                        newIndex -= 1;
                      }
                      final String item = timelineItems.removeAt(oldIndex);
                      timelineItems.insert(newIndex, item);
                    });
                  },
              children: [
                    for (int index = 0; index < timelineItems.length; index++)
                      TimelineItem(
                        key: ValueKey(timelineItems[index]),
                        title: timelineItems[index],
                      ),
              ],
            ),
              );
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              timelineItems.clear();
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
          child: Text(
            'Clear timeline',
            style: TextStyle(color: Colors.white, fontSize: 12 ),
          ),
        ),
        ),
      ],
    );
  }
}

class TimelineItem extends StatelessWidget {
  final String title;

  TimelineItem({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.primaries[title.hashCode % Colors.primaries.length],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}
