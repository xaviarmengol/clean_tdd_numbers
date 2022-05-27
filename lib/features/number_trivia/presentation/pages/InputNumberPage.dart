import 'package:clean_tdd_numbers/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:clean_tdd_numbers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/number_trivia.dart';
import '../notifier/number_trivia_state.dart';
import 'InputNumberPage_state.dart';

class InputNumberPageProvider extends ConsumerWidget {
  const InputNumberPageProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final testInstant = ref.watch(inputConverterProvider);
    //final testFuture = ref.watch(testFutureProvider);
    final numberState = ref.watch(numberNotifierProvider);

    // Page State
    final pageState = ref.watch(inputNumberPageProvider);

    ref.listen(numberNotifierProvider, (previous, next) {
      if (previous != next) {
        //print (next.toString());
        /*
          var snackBar = SnackBar(
            content: Text('Yay! A SnackBar at ${next.toString()}!'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        */
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Number Trivia"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
/*
            testFuture.when(
                data: (data) {return Text(data.toString());},
                error: (error, _) { return Text("Error: ${error.toString()}");},
                loading: () {return const CircularProgressIndicator();}
            ),

 */

            //Text(numberState.toString()),

            Padding(
              padding: const EdgeInsets.all(32.0),
              child: NumberStateDisplayer(numberState),
            ),

            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    onChanged: (valueRaw) {
                      ref
                          .read(inputNumberPageProvider.notifier)
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
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
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
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.grey)),
                            onPressed: () {
                              ref
                                  .read(numberNotifierProvider.notifier)
                                  .getRandomTrivia();
                            },
                            child: Text('Get Random Trivia'),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
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
      final stateLoaded = state as Loaded;
      return DataIsLoaded(numberTrivia: stateLoaded.trivia);
    } else if (state is Error) {
      return Container();
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
        Text(
          numberTrivia.number.toString(),
          style: Theme.of(context).textTheme.headline1,
        ),
        Text(
            numberTrivia.text,
            style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}


