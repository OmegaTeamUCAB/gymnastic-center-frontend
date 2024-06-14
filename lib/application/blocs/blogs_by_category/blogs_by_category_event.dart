sealed class BlogsByCategoryEvent {
  const BlogsByCategoryEvent();
}

class BlogsByCategoryRequested extends BlogsByCategoryEvent {
  final String categoryId;
  final int page;

  BlogsByCategoryRequested({required this.categoryId, required this.page});
}
