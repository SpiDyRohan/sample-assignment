import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_assignment/home_screen/home_screen_event/home_screen_event.dart';
import 'package:sample_assignment/home_screen/home_screen_state/home_screen_state.dart';
import 'package:sample_assignment/model/watch_list_model.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitialState()) {
    on<HomeScreenInitialEvent>(_onInitialEvent);
    on<HomeScreenLoadedEvent>(_onLoadedEvent);
    on<HomeScreenTabChangeEvent>(_onTabChangeEvent);
    on<HomeScreenReorderEvent>(_onReorderEvent);
  }

  void _onInitialEvent(
    HomeScreenInitialEvent event,
    Emitter<HomeScreenState> emit,
  ) {
    emit(
      HomeScreenLoadedState(
        watchlistData: WatchlistData.fromJson(watchlistDataMap),
      ),
    );
  }

  void _onLoadedEvent(
    HomeScreenLoadedEvent event,
    Emitter<HomeScreenState> emit,
  ) {
    emit(HomeScreenLoadedState(watchlistData: event.watchlistData));
  }

  void _onTabChangeEvent(
    HomeScreenTabChangeEvent event,
    Emitter<HomeScreenState> emit,
  ) {
    final WatchlistData? currentData = _getCurrentData();
    if (currentData != null) {
      emit(
        HomeScreenTabChangeState(
          index: event.index,
          watchlistData: currentData,
        ),
      );
    }
  }

  void _onReorderEvent(
    HomeScreenReorderEvent event,
    Emitter<HomeScreenState> emit,
  ) {
    final WatchlistData? data = _getCurrentData();
    if (data == null) return;

    final updatedWatchlists = List<Watchlist>.from(data.watchlist);
    final tab = updatedWatchlists[event.tabIndex];
    final updatedItems = List<WatchlistItem>.from(tab.items);

    int newIndex = event.newIndex;
    if (newIndex > event.oldIndex) {
      newIndex -= 1;
    }

    final item = updatedItems.removeAt(event.oldIndex);
    updatedItems.insert(newIndex, item);

    updatedWatchlists[event.tabIndex] = tab.copyWith(items: updatedItems);
    final updatedData = data.copyWith(watchlist: updatedWatchlists);

    emit(HomeScreenLoadedState(watchlistData: updatedData));
  }

  WatchlistData? _getCurrentData() {
    if (state is HomeScreenLoadedState) {
      return (state as HomeScreenLoadedState).watchlistData;
    } else if (state is HomeScreenTabChangeState) {
      return (state as HomeScreenTabChangeState).watchlistData;
    }
    return null;
  }

  final Map<String, dynamic> watchlistDataMap = {
    "watchlist": [
      {
        "watchlistName": "Watchlist 1",
        "items": [
          {
            "symbol": "RELIANCE",
            "displayName": "Reliance Industries Ltd",
            "type": "EQUITY",
            "exchange": "NSE",
            "sector": "Energy",
            "isDerivative": false
          },
          {
            "symbol": "HDFCBANK",
            "displayName": "HDFC Bank Ltd",
            "type": "EQUITY",
            "exchange": "NSE",
            "sector": "Banking",
            "isDerivative": false
          },
          {
            "symbol": "ITC",
            "displayName": "ITC Ltd",
            "type": "EQUITY",
            "exchange": "NSE",
            "sector": "FMCG",
            "isDerivative": false
          },
          {
            "symbol": "HINDUNILVR",
            "displayName": "Hindustan Unilever Ltd",
            "type": "EQUITY",
            "exchange": "NSE",
            "sector": "FMCG",
            "isDerivative": false
          },
          {
            "symbol": "NIFTY",
            "displayName": "Nifty 50",
            "type": "INDEX",
            "exchange": "NSE",
            "sector": "Broad Market",
            "isDerivative": false
          }
        ]
      },
      {
        "watchlistName": "Banking",
        "items": [
          {
            "symbol": "ICICIBANK",
            "displayName": "ICICI Bank Ltd",
            "type": "EQUITY",
            "exchange": "NSE",
            "sector": "Banking",
            "isDerivative": false
          },
          {
            "symbol": "SBIN",
            "displayName": "State Bank of India",
            "type": "EQUITY",
            "exchange": "NSE",
            "sector": "Banking",
            "isDerivative": false
          },
          {
            "symbol": "KOTAKBANK",
            "displayName": "Kotak Mahindra Bank",
            "type": "EQUITY",
            "exchange": "NSE",
            "sector": "Banking",
            "isDerivative": false
          },
          {
            "symbol": "AXISBANK",
            "displayName": "Axis Bank Ltd",
            "type": "EQUITY",
            "exchange": "NSE",
            "sector": "Banking",
            "isDerivative": false
          },
          {
            "symbol": "BANKNIFTY",
            "displayName": "Nifty Bank",
            "type": "INDEX",
            "exchange": "NSE",
            "sector": "Banking",
            "isDerivative": false
          }
        ]
      },
      {
        "watchlistName": "Tech & Auto",
        "items": [
          {
            "symbol": "TCS",
            "displayName": "Tata Consultancy Services",
            "type": "EQUITY",
            "exchange": "NSE",
            "sector": "IT",
            "isDerivative": false
          },
          {
            "symbol": "INFY",
            "displayName": "Infosys Ltd",
            "type": "EQUITY",
            "exchange": "NSE",
            "sector": "IT",
            "isDerivative": false
          },
          {
            "symbol": "WIPRO",
            "displayName": "Wipro Ltd",
            "type": "EQUITY",
            "exchange": "NSE",
            "sector": "IT",
            "isDerivative": false
          },
          {
            "symbol": "TATAMOTORS",
            "displayName": "Tata Motors Ltd",
            "type": "EQUITY",
            "exchange": "NSE",
            "sector": "Automobile",
            "isDerivative": false
          },
          {
            "symbol": "MARUTI",
            "displayName": "Maruti Suzuki India Ltd",
            "type": "EQUITY",
            "exchange": "NSE",
            "sector": "Automobile",
            "isDerivative": false
          }
        ]
      }
    ]
  };
}
