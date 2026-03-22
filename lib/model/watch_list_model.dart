import 'package:equatable/equatable.dart';

class WatchlistData extends Equatable {
  final List<Watchlist> watchlist;

  const WatchlistData({required this.watchlist});

  factory WatchlistData.fromJson(Map<String, dynamic> json) {
    return WatchlistData(
      watchlist: (json['watchlist'] as List)
          .map((e) => Watchlist.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'watchlist': watchlist.map((e) => e.toJson()).toList(),
    };
  }

  WatchlistData copyWith({List<Watchlist>? watchlist}) {
    return WatchlistData(
      watchlist: watchlist ?? this.watchlist,
    );
  }

  @override
  List<Object?> get props => [watchlist];
}

class Watchlist extends Equatable {
  final String watchlistName;
  final List<WatchlistItem> items;

  const Watchlist({
    required this.watchlistName,
    required this.items,
  });

  factory Watchlist.fromJson(Map<String, dynamic> json) {
    return Watchlist(
      watchlistName: json['watchlistName'] ?? '',
      items: (json['items'] as List)
          .map((e) => WatchlistItem.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'watchlistName': watchlistName,
      'items': items.map((e) => e.toJson()).toList(),
    };
  }

  Watchlist copyWith({String? watchlistName, List<WatchlistItem>? items}) {
    return Watchlist(
      watchlistName: watchlistName ?? this.watchlistName,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [watchlistName, items];
}

class WatchlistItem extends Equatable {
  final String? symbol;
  final String? displayName;
  final String? type;
  final String? exchange;
  final String? sector;
  final bool? isDerivative;
  final String? optionType;
  final int? strikePrice;
  final String? expiry;
  final String? underlying;

  const WatchlistItem({
    this.symbol,
    this.displayName,
    this.type,
    this.exchange,
    this.sector,
    this.isDerivative,
    this.optionType,
    this.strikePrice,
    this.expiry,
    this.underlying,
  });

  factory WatchlistItem.fromJson(Map<String, dynamic> json) {
    return WatchlistItem(
      symbol: json['symbol'],
      displayName: json['displayName'],
      type: json['type'],
      exchange: json['exchange'],
      sector: json['sector'],
      isDerivative: json['isDerivative'],
      optionType: json['optionType'],
      strikePrice: json['strikePrice'],
      expiry: json['expiry'],
      underlying: json['underlying'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'displayName': displayName,
      'type': type,
      'exchange': exchange,
      'sector': sector,
      'isDerivative': isDerivative,
      'optionType': optionType,
      'strikePrice': strikePrice,
      'expiry': expiry,
      'underlying': underlying,
    };
  }

  @override
  List<Object?> get props => [
        symbol,
        displayName,
        type,
        exchange,
        sector,
        isDerivative,
        optionType,
        strikePrice,
        expiry,
        underlying,
      ];
}
