import 'package:flutter/material.dart';
import 'package:minervafrontend/controller/song_api_controller.dart';
import 'package:minervafrontend/view/components/search.dart';
import 'package:minervafrontend/view/components/songs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _options = const ['Songs', 'Graph', 'Search'];
  int _selectedIndex = 0;
  final _view = [
    const Songs(),
    const Center(child: Text('Need more time :(')),
    const Search()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_options[_selectedIndex]),
      ),
      body:_view[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Songs'),
          BottomNavigationBarItem(icon: Icon(Icons.insights), label: 'Graph'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
