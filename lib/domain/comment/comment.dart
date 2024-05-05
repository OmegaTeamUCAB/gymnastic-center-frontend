class Comment {
    final String userId;
    final String blogId;
    final String content;
    final DateTime postedAt;

    Comment({
        required this.userId,
        required this.blogId,
        required this.content,
        required this.postedAt,
    });
  }