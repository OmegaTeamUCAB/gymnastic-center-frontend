import 'package:gymnastic_center/application/models/comment.dart';

class Blog {
  final String id;
  final String imageUrl;
  final String title;
  final String description;
  final String content;
  final DateTime uploadDate;
  final List<Comment> comments;
  

  Blog({required this.id,
    required this.imageUrl,
    required this.title, 
    required this.description, 
    required this.content, 
    required this.uploadDate, 
    required this.comments});
}