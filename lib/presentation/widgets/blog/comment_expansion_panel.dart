import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:gymnastic_center/application/models/comment.dart';

class CommentExpansionPanel extends StatelessWidget {
  final List<Comment> comments;

  const CommentExpansionPanel({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList.radio(
        initialOpenPanelValue: 1,
        elevation: 0,
        children: [
          ExpansionPanelRadio(
            backgroundColor: Theme.of(context).colorScheme.background,
            value: -1,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(
                  'Comentarios (${comments.length})',
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimary, // Cambia esto al color que quieras
                  ),
                ),
              );
            },
            body: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              children: comments.map((Comment comment) {
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://www.example.com/path/to/your/generic/image.jpg'),
                  ),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Usuario',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onPrimary)),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(timeago.format(comment.postedAt),
                          style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onPrimary))
                    ],
                  ),
                  subtitle: Text(comment.content),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
