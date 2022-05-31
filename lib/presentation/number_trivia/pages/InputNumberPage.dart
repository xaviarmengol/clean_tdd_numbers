import 'package:clean_tdd_numbers/di/number_trivia/providers_CachedValuePage.dart';
import 'package:clean_tdd_numbers/di/number_trivia/providers_number_trivia.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/number_trivia/entities/number_trivia.dart';
import '../../../di/number_trivia/providers_InputNumberPage.dart';
import '../notifier/number_trivia_state.dart';
import '../notifier/InputNumberPage_state.dart';
import 'CachedValuesPage.dart';

class InputNumberPage extends ConsumerWidget {
  const InputNumberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numberState = ref.watch(numberNotifierProvider);

    // Page State
    final pageState = ref.watch(inputNumberPageNotifierProvider);

    ref.listen<InputNumberPageState>(inputNumberPageNotifierProvider,
        (previous, next) {
      final snackBarText = next.snackBarText;
      if (snackBarText != "") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(snackBarText)));
      }
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
        title: Text("Number Trivia"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.cached_sharp),
            tooltip: 'Cache Management',
            onPressed: () async {
              ref.read(cachedValuesPageNotifierProvider.notifier).getCacheSet();
              final returnMessage = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CacheListPage()));
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
              ref.read(cachedValuesPageNotifierProvider.notifier).deleteCache();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(pageState.hasInternetConnection.toString()),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: NumberStateDisplayer(numberState),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: RequestNumberButtons(pageState: pageState),
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class RequestNumberButtons extends ConsumerWidget {
  const RequestNumberButtons({
    Key? key,
    required this.pageState,
  }) : super(key: key);

  final InputNumberPageState pageState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: <Widget>[
        TextField(
          onChanged: (valueRaw) {
            ref
                .read(inputNumberPageNotifierProvider.notifier)
                .setRequestedValue(valueRaw);
          },
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Input Number',
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    ref
                        .read(numberNotifierProvider.notifier)
                        .getConcreteTrivia(pageState.requestedValue);
                  },
                  child: Text('Search'),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey)),
                  onPressed: () {
                    ref.read(numberNotifierProvider.notifier).getRandomTrivia();
                  },
                  child: const Text(
                    'Get Random Trivia',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class NumberStateDisplayer extends ConsumerWidget {
  final NumberTriviaState state;
  const NumberStateDisplayer(this.state);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (state is Empty) {
      return Text(
        "Start Searching!",
        style: Theme.of(context).textTheme.headline6,
      );
    } else if (state is Loading) {
      return const CircularProgressIndicator();
    } else if (state is Loaded) {
      // TODO: Why is not direcly casted?????
      return DataIsLoaded(numberTrivia: (state as Loaded).trivia);
    } else if (state is Error) {
      return Column(
        children: [
          Text(
            "It seems that we have problems with your number, try again!",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            (state as Error).message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      );
    } else {
      throw UnimplementedError("State not implemented");
    }
  }
}

class DataIsLoaded extends StatelessWidget {
  final NumberTrivia numberTrivia;

  const DataIsLoaded({required this.numberTrivia});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            numberTrivia.number.toStringAsFixed(0),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Text(
          numberTrivia.text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
