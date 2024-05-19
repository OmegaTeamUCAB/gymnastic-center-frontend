sealed class BlogsByCategoryEvent {
  const BlogsByCategoryEvent();
}

class BlogsByCategoryRequested extends BlogsByCategoryEvent {
  final String categoryId;

  BlogsByCategoryRequested({required this.categoryId});
}
