import 'package:flutter/material.dart';

class WishlistState {
  bool empty = true;
  bool loading = true;
  List posts = [];

  late ScrollController controller = ScrollController();

  void setStateScrollController(Function() function) {
    this.controller = ScrollController()..addListener(function);
  }

  WishlistState(
      {this.empty = true, this.loading = true, this.posts = const []});

  WishlistState copyWith({bool? empty, bool? loading, List? posts}) {
    return WishlistState(
      empty: empty ?? this.empty,
      loading: loading ?? this.loading,
      posts: posts ?? this.posts,
    );
  }
}
