import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/presentation/screens/trainer_screen.dart';
import 'package:gymnastic_center/presentation/utils/calculate_reading_time.dart';
import 'package:gymnastic_center/presentation/widgets/profile/profile_avatar.dart';
import 'package:timeago/timeago.dart';

class BlogInfo extends StatelessWidget {
  final Blog blog;
  const BlogInfo({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(blog.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                ProfileAvatar(
                  fullName: blog.trainer!['name'],
                  urlImage: blog.trainer['image'],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TrainerScreen(
                                trainerId: blog.trainer['id'],
                              )),
                    );
                  },
                  radius: 25,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(blog.trainer!['name'],
                        style: const TextStyle(
                          fontSize: 18,
                        )),
                    Text(
                        '${calculateReadingTime(blog.content!)} min read \u2022 ${format(DateTime.parse(blog.uploadDate!))}')
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Image.network(
            blog.images.first,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                Text(
                  blog.content!,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
