import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomProgressBar extends StatefulWidget {
  final int segments;
  final Duration totalDuration;
  double progress = 0.0;
  Duration currentDuration = Duration.zero;

  final Future<void> Function(Duration) seekPosition;

  CustomProgressBar(
      {super.key,
      required this.segments,
      required this.totalDuration,
      required this.progress,
      required this.seekPosition});

  @override
  State<CustomProgressBar> createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      GestureDetector(
        onHorizontalDragUpdate: (details) async {
          RenderBox box = context.findRenderObject() as RenderBox;
          var localPosition = box.globalToLocal(details.globalPosition);
          widget.currentDuration =
              widget.totalDuration * (localPosition.dx / box.size.width);
          await widget.seekPosition(widget.currentDuration);
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: List.generate(
              widget.segments,
              (index) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1.0),
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: index < (widget.progress * widget.segments)
                          ? const Color(0xFF4F14A0)
                          : Theme.of(context).colorScheme.onSecondaryContainer,
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
