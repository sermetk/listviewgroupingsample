import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:listviewgroupingsample/cubit/sample_page_cubit.dart';
import 'package:listviewgroupingsample/cubit/listview_state.dart';
import 'package:listviewgroupingsample/repository/sample_repository.dart';
import 'package:listviewgroupingsample/widgets/custom_listview.dart';
import 'package:listviewgroupingsample/widgets/list_view_item_widget.dart';

void main() {
  registerDependencies();
  runApp(ListViewGroupingSample());
}

void registerDependencies() {
  GetIt.I.registerLazySingleton(() => SampleService());
}

class ListViewGroupingSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    searchController.addListener(() {
      context.bloc<SamplePageCubit>().fetchPosts(10, 0);
    });
    return MaterialApp(
      home: BlocProvider<SamplePageCubit>(
          create: (context) => SamplePageCubit(),
          child: Scaffold(
              resizeToAvoidBottomPadding: false,
              body: BlocBuilder<SamplePageCubit, ListViewState>(builder: (context, state) {
                return CustomListView(
                    groupByFunction: (obj) => obj.title,
                    itemWidget: CustomItemTemplate(),
                    onRefresh: () => (context.bloc<SamplePageCubit>().fetchPosts(20, 0)),
                    fetch:
                        context.bloc<SamplePageCubit>().fetchPosts(20, state is LoadMoreState ? state.data.length : 0),
                    state: state);
              }))),
    );
  }
}

// ignore: must_be_immutable
class CustomItemTemplate extends StatelessWidget with ListViewItemWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: ListTile(
            leading: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: data.iconColor),
                padding: EdgeInsets.all(12),
                child: Icon(data.icon)),
            title: Text(data.text),
            subtitle: Text(DateFormat('d MMM yy').format(data.date)),
            dense: true,
          ),
        ),
      ),
    );
  }

  @override
  ListViewItemWidget copyWith(dynamic data) {
    var widget = CustomItemTemplate();
    widget.data = data;
    return widget;
  }
}
