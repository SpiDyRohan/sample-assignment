import 'package:equatable/equatable.dart';
import '../../model/watch_list_model.dart';

abstract class HomeScreenState extends Equatable {
  const HomeScreenState();

  @override
  List<Object?> get props => [];
}

class HomeScreenInitialState extends HomeScreenState {}

class HomeScreenLoadedState extends HomeScreenState {
  final WatchlistData watchlistData;

  const HomeScreenLoadedState({required this.watchlistData});

  @override
  List<Object?> get props => [watchlistData];
}

class HomeScreenTabChangeState extends HomeScreenState {
  final int index;
  final WatchlistData watchlistData;

  const HomeScreenTabChangeState({
    required this.index,
    required this.watchlistData,
  });

  @override
  List<Object?> get props => [index, watchlistData];
}

class HomeScreenReorderState extends HomeScreenState {
  final int tabIndex;
  final int oldIndex;
  final int newIndex;

  const HomeScreenReorderState({
    required this.tabIndex,
    required this.oldIndex,
    required this.newIndex,
  });

  @override
  List<Object?> get props => [tabIndex, oldIndex, newIndex];
}
