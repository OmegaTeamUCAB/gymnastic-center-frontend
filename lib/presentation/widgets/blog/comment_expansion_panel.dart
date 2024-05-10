import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:gymnastic_center/application/models/comment.dart';

class CommentExpansionPanel extends StatelessWidget {
  final List<Comment> comments;

  const CommentExpansionPanel({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList.radio(
        initialOpenPanelValue: 1,
        children: [
          ExpansionPanelRadio(
            value: -1,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(
                  'Comentarios (${comments.length})',
                  style: const TextStyle(
                    color: Colors.black, // Cambia esto al color que quieras
                  ),
                ),
              );
            },
            body: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: comments.map((Comment comment) {
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://www.example.com/path/to/your/generic/image.jpg'),
                  ),
                  title: const Text('USUARIO'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(comment.content),
                      Text(DateFormat('dd/MM/yyyy').format(comment.postedAt)),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
