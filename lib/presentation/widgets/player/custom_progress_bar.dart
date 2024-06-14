import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomProgressBar extends StatefulWidget {

  final int segments;
  final Duration totalDuration;
  double progress = 0.0;
  Duration currentDuration = Duration.zero;

  final Future<void> Function(Duration) seekPosition;

  CustomProgressBar({super.key, required this.segments, required this.totalDuration, required this.progress, required this.seekPosition});

  @override
  State<CustomProgressBar> createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar> {

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onHorizontalDragUpdate: (details) async {
              RenderBox box = context.findRenderObject() as RenderBox;
              var localPosition = box.globalToLocal(details.globalPosition);
              var newProgress = (localPosition.dx / box.size.width) * widget.segments;
                widget.currentDuration = widget.totalDuration * (localPosition.dx / box.size.width);
                await widget.seekPosition(widget.currentDuration);
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: List.generate(
                  widget.segments,
                  (index) => Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      height: 10,
                      color: index < (widget.progress * widget.segments)
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey[300],
                    ),
                  ),
                ),
              ),
            ),
          )]);
  }
}