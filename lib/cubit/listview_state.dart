import 'package:equatable/equatable.dart';

abstract class ListViewState extends Equatable {
  const ListViewState();
  @override
  List<Object> get props => [];
}

class InitialState extends ListViewState {}

class EmptyState extends ListViewState {}

class ErrorState extends ListViewState {}

class LoadMoreState extends ListViewState {
  final List<dynamic> data;
  final bool hasReachedMax;

  const LoadMoreState({
    this.data,
    this.hasReachedMax,
  });

  LoadMoreState copyWith({
    List<dynamic> posts,
    bool hasReachedMax,
  }) {
    return LoadMoreState(
      data: posts ?? this.data,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [data, hasReachedMax];

  @override
  String toString() => 'PostLoaded { posts: ${data.length}, hasReachedMax: $hasReachedMax }';
}
