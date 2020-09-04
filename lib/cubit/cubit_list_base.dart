import 'package:bloc/bloc.dart';
import 'package:listviewgroupingsample/cubit/listview_state.dart';

class CubitListBase extends Cubit<ListViewState> {
  CubitListBase() : super(InitialState());
  controlServiceResult(ListViewState currentState, dynamic data, int take) {
    if (currentState is InitialState) {
      data == null ? emit(EmptyState()) : emit(LoadMoreState(data: data, hasReachedMax: (data as List).length < take));
    } else if (currentState is LoadMoreState) {
      data == null || (data as List).length < take
          ? emit(currentState.copyWith(hasReachedMax: true))
          : emit(LoadMoreState(data: currentState.data + data, hasReachedMax: false));
    } else {
      emit(ErrorState());
    }
  }
}
