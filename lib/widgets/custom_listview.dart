import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:listviewgroupingsample/cubit/listview_state.dart';
import 'package:listviewgroupingsample/widgets/bottom_loader.dart';
import 'package:listviewgroupingsample/widgets/list_view_item_widget.dart';

class CustomListView extends StatelessWidget {
  final dynamic state;
  final Future fetch;
  final Widget emptyView;
  final Widget errorView;
  final Function onRefresh;
  final ListViewItemWidget itemWidget;
  final Function groupByFunction;
  CustomListView(
      {this.state, this.fetch, this.emptyView, this.errorView, this.onRefresh, this.itemWidget, this.groupByFunction});
  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final scrollThreshold = MediaQuery.of(context).size.height;
    scrollController.addListener(() async {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      if (maxScroll - currentScroll <= scrollThreshold) {
        await fetch;
      }
    });
    if (state is Error) {
      return errorView == null ? Center(child: Text('Failed to fetch data')) : errorView;
    } else if (state is EmptyState) {
      return emptyView == null ? Center(child: Text('No data')) : emptyView;
    } else if (state is LoadMoreState) {
      var data = state.data;
      if (groupByFunction != null) {
        data = groupBy(state.data, groupByFunction);
        for (var i = 0; i == data.length; i++) {
          print(data[i]);
        }
      } else {
        data = state.data;
      }
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              dynamic body;
              if (groupByFunction != null) {
                var childItems = List<Widget>();
                var key = data.keys.elementAt(index);
                childItems.add(Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                  child: Text(key.toString()),
                ));
                for (var i = 0; i < data[key].length; i++) {
                  var child = itemWidget.copyWith(data[key][i]);
                  childItems.add(child as Widget);
                }
                body = Column(
                  children: childItems,
                  crossAxisAlignment: CrossAxisAlignment.start,
                );
              } else {
                itemWidget.data = data[index];
                body = itemWidget;
              }
              return index >= data.length ? BottomLoader() : body;
            },
            itemCount: state.hasReachedMax ? data.length : data.length + 1,
            controller: scrollController),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
