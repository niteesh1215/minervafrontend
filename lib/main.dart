import 'package:flutter/material.dart';
import 'package:minervafrontend/model/songs_provider.dart';
import 'package:minervafrontend/view/custom_scroll_behavior.dart';
import 'package:minervafrontend/view/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initializationCompleted = false;
  final SongsProvider _songsProvider = SongsProvider();

  Future<void> _initialize() async {
    if (_initializationCompleted) return;
    _initializationCompleted = true;
    _songsProvider.fetchMoreSong();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const MaterialApp(home: Scaffold());
          }

          return MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: _songsProvider),
            ],
            child: MaterialApp(
              title: 'Minerva',
              theme: ThemeData.dark(),
              scrollBehavior: const CustomScrollBehavior(),
              home: const HomeScreen(),
            ),
          );
        });
  }
}
