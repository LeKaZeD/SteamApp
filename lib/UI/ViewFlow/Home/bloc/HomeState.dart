import 'package:flutter/material.dart';

class HomeState {
  final bool isFirstLoadRunning;
  final bool hasNextPage;

  final bool isLoadMoreRunning;

  final List posts;

  late ScrollController controller = ScrollController();

  final search = TextEditingController();

  void setState(Function() function) {
    this.controller = ScrollController()..addListener(function);
  }

  HomeState({
    this.isFirstLoadRunning = false,
    this.hasNextPage = true,
    this.isLoadMoreRunning = false,
    this.posts = const [],
  });

  HomeState copyWith(
      {bool? isFirstLoading,
      bool? hasNextPage,
      bool? isLoadMoreRun,
      List? post}) {
    return HomeState(
        isFirstLoadRunning: isFirstLoading ?? this.isFirstLoadRunning,
        hasNextPage: hasNextPage ?? this.hasNextPage,
        isLoadMoreRunning: isLoadMoreRun ?? this.isLoadMoreRunning,
        posts: post ?? this.posts);
  }
}
