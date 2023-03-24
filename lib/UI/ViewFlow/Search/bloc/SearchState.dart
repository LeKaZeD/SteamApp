import 'package:flutter/material.dart';

class SearchState {
  final bool isFirstLoadRunning;
  final bool hasNextPage;

  final bool isLoadMoreRunning;

  final bool isField;

  final List posts;

  late ScrollController controller = ScrollController();

  final search;

  void setStateScrollController(Function() function) {
    this.controller = ScrollController()..addListener(function);
  }

  SearchState(
      {this.isFirstLoadRunning = false,
      this.hasNextPage = true,
      this.isLoadMoreRunning = false,
      this.posts = const [],
      required this.search,
      this.isField = true});

  SearchState copyWith(
      {bool? isFirstLoading,
      bool? hasNextPage,
      bool? isLoadMoreRun,
      List? post,
      bool? isField}) {
    return SearchState(
        isFirstLoadRunning: isFirstLoading ?? this.isFirstLoadRunning,
        hasNextPage: hasNextPage ?? this.hasNextPage,
        isLoadMoreRunning: isLoadMoreRun ?? this.isLoadMoreRunning,
        posts: post ?? this.posts,
        search: this.search,
        isField: isField ?? this.isField);
  }
}
