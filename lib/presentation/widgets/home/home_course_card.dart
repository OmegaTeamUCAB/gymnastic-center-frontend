import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gymnastic_center/presentation/widgets/common/new_chip.dart';

class HomeCourseCard extends StatelessWidget {
  const HomeCourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashColor: Theme.of(context).colorScheme.surfaceTint,
      borderRadius: BorderRadius.circular(10),
      child: Ink(
        height: 130,
        width: 380,
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
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Full-Body Burner',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('10 min | John Doe')
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
