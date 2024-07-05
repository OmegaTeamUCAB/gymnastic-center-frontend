import 'package:flutter/material.dart';

class LikeAndDislikeCount extends StatelessWidget {
  final int count;

  const LikeAndDislikeCount({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    String formattedCount;
    if (count >= 1000 && count < 1000000) {
      formattedCount = "${(count / 1000).toStringAsFixed(1)}K";
    } else if (count >= 1000000 && count < 1000000000) {
      formattedCount = "${(count / 1000000).toStringAsFixed(1)}M";
    } else if (count >= 1000000000) {
      formattedCount = "${(count / 1000000000).toStringAsFixed(1)}B";
    } else {
      formattedCount = count.toString();
    }

    return Text(formattedCount);
  }
}
