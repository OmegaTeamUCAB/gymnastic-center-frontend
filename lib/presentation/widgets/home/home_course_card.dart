import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/common/new_chip.dart';

class HomeCourseCard extends StatelessWidget {
  //todo: add the course object
  final dynamic course;
  const HomeCourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashColor: Theme.of(context).colorScheme.surfaceTint,
      borderRadius: BorderRadius.circular(10),
      child: Ink(
        height: 130,
        width: 380,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 0.5,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/course_sample.jpg'),
                  ),
                  const Positioned(bottom: 5, left: 5, child: NewChip()),
                ],
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    //! temporary
                    course['title'],
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('${course['description']} | ${course['author']}')
                ],
              ),
              const Spacer(),
              const Icon(Icons.chevron_right)
            ],
          ),
        ),
      ),
    );
  }
}
