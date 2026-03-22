import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_assignment/home_screen/home_screen_bloc/home_screen_bloc.dart';
import 'package:sample_assignment/home_screen/home_screen_event/home_screen_event.dart';
import 'package:sample_assignment/home_screen/home_screen_state/home_screen_state.dart';
import 'package:sample_assignment/model/watch_list_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeScreenBloc()..add(HomeScreenInitialEvent()),
      child: const HomeScreenView(),
    );
  }
}

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView>
    with TickerProviderStateMixin {
  TabController? _tabController;
  int _watchlistsCount = 0;

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _setupTabController(int length) {
    if (_watchlistsCount != length) {
      _tabController?.dispose();
      _tabController = TabController(length: length, vsync: this);
      _watchlistsCount = length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        if (state is HomeScreenInitialState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        List<Watchlist> watchlists = [];
        if (state is HomeScreenLoadedState) {
          watchlists = state.watchlistData.watchlist;
        } else if (state is HomeScreenTabChangeState) {
          watchlists = state.watchlistData.watchlist;
        }

        if (watchlists.isEmpty) {
          return const Scaffold(
            body: Center(child: Text('No watchlists found')),
          );
        }

        _setupTabController(watchlists.length);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Watchlist'),
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              onTap: (index) {
                context
                    .read<HomeScreenBloc>()
                    .add(HomeScreenTabChangeEvent(index: index));
              },
              tabs: watchlists
                  .map((e) => Tab(text: e.watchlistName))
                  .toList(),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: List.generate(
              watchlists.length,
              (index) => WatchlistListView(
                tabIndex: index,
                items: watchlists[index].items,
              ),
            ),
          ),
        );
      },
    );
  }
}

class WatchlistListView extends StatelessWidget {
  final int tabIndex;
  final List<WatchlistItem> items;

  const WatchlistListView({
    super.key,
    required this.tabIndex,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      itemCount: items.length,
      padding: const EdgeInsets.symmetric(vertical: 8),
      onReorder: (oldIndex, newIndex) {
        context.read<HomeScreenBloc>().add(
              HomeScreenReorderEvent(
                tabIndex: tabIndex,
                oldIndex: oldIndex,
                newIndex: newIndex,
              ),
            );
      },
      itemBuilder: (context, index) {
        final item = items[index];
        return WatchlistItemTile(
          key: ValueKey('${item.symbol}_$index'),
          item: item,
        );
      },
    );
  }
}

class WatchlistItemTile extends StatelessWidget {
  final WatchlistItem item;

  const WatchlistItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(
          item.displayName ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: [
            Text(
              item.exchange ?? '',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                item.type ?? '',
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.drag_handle, color: Colors.grey),
      ),
    );
  }
}
