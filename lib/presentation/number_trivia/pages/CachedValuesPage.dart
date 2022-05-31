import 'package:clean_tdd_numbers/di/number_trivia/providers_CachedValuePage.dart';
import 'package:clean_tdd_numbers/presentation/number_trivia/notifier/CachedValuesPage_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../di/number_trivia/providers_InputNumberPage.dart';
import '../../../domain/number_trivia/entities/number_trivia.dart';
import '../notifier/InputNumberPage_state.dart';

class CacheListPage extends ConsumerWidget {
  const CacheListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cachePageState = ref.watch(cachedValuesPageNotifierProvider);

    // Page State
    final pageState = ref.watch(inputNumberPageNotifierProvider);

    ref.listen<InputNumberPageState>(inputNumberPageNotifierProvider,
        (previous, next) {
      /*
      final snackBarText = next.snackBarText;
      if (snackBarText != "") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(snackBarText)));
      }
       */
    });

    ref.listen<CachedValuesPageState>(cachedValuesPageNotifierProvider,
        (previous, next) {
      print("SET = ${next.toString()}");
    });

    // TODO: Check if this is the way to listen to streams
    ref
        .read(inputNumberPageNotifierProvider.notifier)
        .onConnectionStatusChange()
        .listen((status) {
      if (!status) print("Connection lost");
    });

    return Scaffold(
        appBar: AppBar(
          title: Text("Cached values list"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.access_time_filled),
              tooltip: 'Print state',
              onPressed: () {
                ref
                    .read(cachedValuesPageNotifierProvider.notifier)
                    .getCacheSet();
                print(cachePageState.cachedNumberTrivias.toString());
              },
            ),
            if (pageState.hasInternetConnection)
              const Icon(Icons.signal_cellular_4_bar)
            else
              const Icon(Icons.signal_cellular_connected_no_internet_0_bar),
            IconButton(
              icon: const Icon(Icons.clear_all),
              tooltip: 'Clear cache',
              onPressed: () {
                ref
                    .read(cachedValuesPageNotifierProvider.notifier)
                    .deleteCache();
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: cachePageState.cachedNumberTrivias.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: ListItem(
                  cacheItem: cachePageState.cachedNumberTrivias[index]),
            );
          },
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.cacheItem,
  }) : super(key: key);

  final NumberTrivia cacheItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  cacheItem.number.toStringAsFixed(0),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox()
          ),
          Expanded(
            flex: 5,
            child: TextSelectionGestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  cacheItem.text,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              //onTapDown: ,
            ),
          ),
        ],
      ),
      margin: EdgeInsets.all(4.0),
    );
  }
}
