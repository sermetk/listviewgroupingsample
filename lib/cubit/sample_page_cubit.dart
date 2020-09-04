import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:listviewgroupingsample/cubit/cubit_list_base.dart';
import 'package:listviewgroupingsample/cubit/listview_state.dart';
import 'package:listviewgroupingsample/repository/sample_repository.dart';

class SamplePageCubit extends CubitListBase {
  Future<void> fetchPosts(int take, int skip) async {
    final currentState = state;
    var result = await GetIt.I<SampleService>().getSampleList(take, skip);
    if (result != null) {
      controlServiceResult(currentState, result, take);
    } else {
      emit(ErrorState());
    }
  }
}
