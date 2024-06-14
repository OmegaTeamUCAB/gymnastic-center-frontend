import 'package:flutter/material.dart';

class PaginationController {
  final ScrollController scrollController = ScrollController();
  final Function(int) requestNextPage;
  int currentPage = 1;
  bool hasMore = true;
  bool isLoading = false;

  PaginationController({required this.requestNextPage}) {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() async {
    if (_isBottom && hasMore && !isLoading) {
      currentPage++;
      isLoading = true;
      await requestNextPage(currentPage);
      isLoading = false;
    }
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void dispose() {
    scrollController.dispose();
  }

  void setHasMore(bool value) {
    hasMore = value;
  }
}
