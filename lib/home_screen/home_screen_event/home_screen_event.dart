import 'package:equatable/equatable.dart';
import '../../model/watch_list_model.dart';

abstract class HomeScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeScreenInitialEvent extends HomeScreenEvent {}

class HomeScreenLoadedEvent extends HomeScreenEvent {
  final WatchlistData watchlistData;
  HomeScreenLoadedEvent({required this.watchlistData});

  @override
  List<Object?> get props => [watchlistData];
}

class HomeScreenTabChangeEvent extends HomeScreenEvent {
  final int index;
  HomeScreenTabChangeEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class HomeScreenSwapEvent extends HomeScreenEvent {
  final WatchlistItem watchlistItem;
  HomeScreenSwapEvent({required this.watchlistItem});

  @override
  List<Object?> get props => [watchlistItem];
}

class HomeScreenReorderEvent extends HomeScreenEvent {
  final int tabIndex;
  final int oldIndex;
  final int newIndex;

  HomeScreenReorderEvent({
    required this.tabIndex,
    required this.oldIndex,
    required this.newIndex,
  });

  @override
  List<Object?> get props => [tabIndex, oldIndex, newIndex];
}
