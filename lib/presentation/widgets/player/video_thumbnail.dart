import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoThumbnailImage extends StatelessWidget {
  final String videoPath;
  final double width;
  final double height;
  VideoThumbnailImage({
    super.key,
    required this.videoPath,
    required this.width,
    required this.height
});

  Future<String?> _generateThumbnail(String videoPath) async {
final fileName = await VideoThumbnail.thumbnailFile(
  video: videoPath,
  thumbnailPath: (await getTemporaryDirectory()).path,
  imageFormat: ImageFormat.PNG,
  maxHeight: 100, 
  maxWidth: 100,
  quality: 10,
);
    return fileName;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _generateThumbnail(videoPath),
      builder: (context, snapshot) {
        if(snapshot.data != null && snapshot.connectionState == ConnectionState.done){
        return Image.file(
          File(snapshot.data!),
          width: width,
          height: height,
          fit: BoxFit.cover,
        );
        }

        return Container(
            width: width,
            height: height,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.05),
              borderRadius: BorderRadius.circular(15.0)
            ),
          );
      }, 
    );
  }
}