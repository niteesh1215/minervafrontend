import 'package:flutter/material.dart';
import 'package:minervafrontend/controller/api_controller.dart';
import 'package:minervafrontend/controller/song_api_controller.dart';
import 'package:minervafrontend/model/l_response.dart';
import 'package:minervafrontend/model/songs_provider.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String searchText = '';

  final SongApiController apiController = SongApiController();

  Song? searchedSong;

  bool firstSearchComplete = false;

  void search() async {
    firstSearchComplete = true;
    final lResponse = await apiController.searchSongByTitle(searchText);
    if (lResponse.responseStatus == ResponseStatus.success) {
      setState(() {
        searchedSong = lResponse.data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (text) => searchText = text,
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              ElevatedButton(onPressed: search, child: const Text('Search'))
            ],
          ),
          if (firstSearchComplete)
            Expanded(
              child: Center(
                child: Text(searchedSong?.toString() ?? 'Not Found'),
              ),
            )
        ],
      ),
    );
  }
}
