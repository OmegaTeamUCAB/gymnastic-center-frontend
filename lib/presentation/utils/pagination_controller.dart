import 'package:flutter/material.dart';

class PaginationController {
  final ScrollController scrollController = ScrollController();
  final Function(int) requestNextPage;
  int currentPage = 1;
  bool hasMore = true;

  PaginationController({required this.requestNextPage}) {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom && hasMore) {
      currentPage++;
      requestNextPage(currentPage);
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
