import 'package:flutter/material.dart';

class LikesState {
  bool empty = true;
  bool loading = true;
  List posts = [];

  late ScrollController controller = ScrollController();

  void setStateScrollController(Function() function) {
    this.controller = ScrollController()..addListener(function);
  }

  LikesState({this.empty = true, this.loading = true, this.posts = const []});

  LikesState copyWith({bool? empty, bool? loading, List? posts}) {
    return LikesState(
      empty: empty ?? this.empty,
      loading: loading ?? this.loading,
      posts: posts ?? this.posts,
    );
  }
}
