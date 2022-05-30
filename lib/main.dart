import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/cache/di/providers_cache.dart';
import 'features/number_trivia/presentation/pages/InputNumberPage.dart';

// To log Riverpod States
class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
      ProviderBase provider,
      Object? previousValue,
      Object? newValue,
      ProviderContainer container,
      ) {
    print('[${provider.name ?? provider.runtimeType}] value: $newValue');
  }
}


void main() async {

  WidgetsFlutterBinding.ensureInitialized(); // Needed to sync everything

  // Override Provider explained here:
  // https://codewithandrea.com/articles/flutter-state-management-riverpod/#dependency-overrides-with-riverpod

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(ProviderScope(

    observers: [Logger()],
    overrides: [
      // override the previous value with the new object
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    ],
    child: MyApp(),
  ));

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),

      home: InputNumberPageProvider(),
    );
  }
}

