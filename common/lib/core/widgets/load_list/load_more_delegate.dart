import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';

class ListViewLoadMoreDelegate extends LoadMoreDelegate {
  @override
  Widget buildChild(LoadMoreStatus status,
      {Function builder = DefaultLoadMoreTextBuilder.chinese}) {
    return const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black));
  }

  @override
  double widgetHeight(LoadMoreStatus status) {
    if (status == LoadMoreStatus.idle || status == LoadMoreStatus.loading) {
      return 60;
    }
    return 0;
  } // the loadMore height. default is 80.0

  @override
  Duration loadMoreDelay() => const Duration(milliseconds: 500);
}
