import 'package:flutter/material.dart';
import 'package:gymnastic_center/application/models/comment.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/presentation/widgets/blog/add_comment_bar.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';

import 'package:intl/intl.dart';

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

class BlogDetail extends StatelessWidget {
  final Blog blog;

  const BlogDetail({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const AddCommentBar(),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Stack(
                    children: [
                      Transform.translate(
                        offset: const Offset(0, 20),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(40.0),
                                  ),
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        blog.imageUrl,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 300,
                                        fit: BoxFit.cover,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 300,
                                        color: Colors.black.withOpacity(0.6),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 300,
                                    child: Text(
                                      blog.title,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(1.0, 1.0),
                                            blurRadius: 3.0,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Text(
                                    DateFormat('yyyy-MM-dd')
                                        .format(blog.uploadDate),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(1.0, 1.0),
                                          blurRadius: 3.0,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      PreferredSize(
                        preferredSize: const Size(double.infinity, 100),
                        child: SizedBox(
                          width: double.infinity,
                          child: CustomAppBar(
                            content: SizedBox(
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Transform.translate(
                                    offset: const Offset(0, -12),
                                    child: IconButton(
                                        icon: const Icon(Icons.chevron_left,
                                            color: Colors.white),
                                        iconSize: 40,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ),
                                  const Text(
                                    'BLOG DETAIL',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      blog.description,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      blog.content,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  CommentExpansionPanel(comments: blog.comments),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
