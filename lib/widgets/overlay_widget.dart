
import 'package:flutter/material.dart';

class OverlayWidget extends StatefulWidget {
  const OverlayWidget(
      {Key? key,
        required this.parentWidget,
        required this.horizontalOffset,
        required this.verticalOffset,
        required this.mediaQuery,
        required this.onTap,
        required this.child
      })
      : super(key: key);
  final GlobalKey parentWidget;
  final double horizontalOffset;
  final double verticalOffset;
  final MediaQueryData mediaQuery;
  final GestureTapCallback? onTap;
  final Widget child ;


  @override
  State<OverlayWidget> createState() => _OverlayWidgetState();
}

class _OverlayWidgetState extends State<OverlayWidget> {
  OverlayEntry? overlay;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    removeOverlay();
  }

  @override
  Widget build(BuildContext context) {
    Future(addOverlay);
    return Container();
  }

  void addOverlay() {
    removeOverlay();
    RenderBox? renderBox = context.findAncestorRenderObjectOfType<RenderBox>();

    var parentSize = renderBox!.size;
    var parentPosition = renderBox.localToGlobal(Offset.zero);

    overlay = _overlayEntryBuilder(parentPosition, parentSize);
    Overlay.of(context)!.insert(overlay!);
  }

  void removeOverlay() {
    overlay?.remove();
  }

  OverlayEntry _overlayEntryBuilder(Offset parentPosition, Size parentSize) {
    const clickableArea = 100.0;

    return OverlayEntry(
      maintainState: true,
      builder: (context) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: parentPosition.dx +
                  parentSize.width -
                  clickableArea -
                  widget.horizontalOffset,
              top: parentPosition.dy +
                  parentSize.height -
                  clickableArea -
                  widget.verticalOffset,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.onTap,
                  child: Container(
                    color: Colors.blue.withAlpha(200),
                    width: clickableArea,
                    height: clickableArea,
                    child: Text(
                      'InkWell (Overlay)',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: parentPosition.dx +
                  parentSize.width -
                  clickableArea -
                  widget.horizontalOffset,
              top: parentPosition.dy + widget.verticalOffset,
              child: GestureDetector(
                onTap: widget.onTap,
                child: Container(
                  color: Colors.purple.withAlpha(200),
                  width: clickableArea,
                  height: clickableArea,
                  child: Text(
                    'Gesture (Overlay)',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}