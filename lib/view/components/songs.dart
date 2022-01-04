import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:minervafrontend/controller/song_api_controller.dart';
import 'package:minervafrontend/model/songs_provider.dart';
import 'package:provider/provider.dart';

class Songs extends StatefulWidget {
  const Songs({Key? key}) : super(key: key);

  @override
  _SongsState createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(pagination);
    super.initState();
  }

  void pagination() {
    if (_scrollController.position.maxScrollExtent -
            _scrollController.position.pixels <
        50) {
      context.read<SongsProvider>().fetchMoreSong();
    }
  }

  @override
  Widget build(BuildContext context) {
    // if(songsProvider == null){
    //   songsProvider = Provider.of<SongsProvider>(context,listen: false);
    //   if(songsProvider!.songs.isEmpty) {
    //     songsProvider?.fetchMoreSong();
    //   }
    // }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        child: Consumer<SongsProvider>(
          builder: (context, songsProvider, _) {
            return Stack(
              children: [
                Table(
                  border: TableBorder.all(),
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(100),
                    1: FixedColumnWidth(120),
                    2: FixedColumnWidth(150),
                    3: FixedColumnWidth(100),
                    4: FixedColumnWidth(100),
                    5: FixedColumnWidth(100),
                    6: FixedColumnWidth(100),
                    7: FixedColumnWidth(100),
                    8: FixedColumnWidth(100),
                    9: FixedColumnWidth(100),
                    10: FixedColumnWidth(100),
                    11: FixedColumnWidth(300),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: <TableRow>[
                    TableRow(
                      children: [
                        getTableCell('index', 0),
                        getTableCell('id', 1),
                        getTableCell('title', 2),
                        getTableCell('danceability', 3),
                        getTableCell('energy', 4),
                        getTableCell('mode', 5),
                        getTableCell('acousticness', 6),
                        getTableCell('tempo', 7),
                        getTableCell('duration_ms', 8),
                        getTableCell('num_sections', 9),
                        getTableCell('num_segments', 10),
                        getTableCell('star_rating', 11),
                      ],
                    ),
                    ...songsProvider.songs.map<TableRow>((song) {
                      return TableRow(children: [
                        getTableCell(song.index.toString(), 0),
                        getTableCell(song.id.toString(), 1),
                        getTableCell(song.title.toString(), 2),
                        getTableCell(song.danceability.toString(), 3),
                        getTableCell(song.energy.toString(), 4),
                        getTableCell(song.mode.toString(), 5),
                        getTableCell(song.acousticness.toString(), 6),
                        getTableCell(song.tempo.toString(), 7),
                        getTableCell(song.durationMs.toString(), 8),
                        getTableCell(song.numSections.toString(), 9),
                        getTableCell(song.numSegments.toString(), 10),
                        getTableCell(song.starRating.toString(), 11,
                            index: song.index, isStarRating: true),
                      ]);
                    }).toList(),
                  ],
                ),
                if (songsProvider.loading)
                  const Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  TableCell getTableCell(String s, int columnIndex,
      {int? index, bool isStarRating = false}) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: InkWell(
        onTap: () {
          context.read<SongsProvider>().sort(columnIndex);
        },
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: !isStarRating
              ? Text(
                  s,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20.0),
                )
              : RatingBar.builder(
                  initialRating: double.parse(s) * 1.0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    updateRating(index!, rating);
                  },
                ),
        ),
      ),
    );
  }

  void updateRating(int index, double ratingValue) async {
    final apiController = SongApiController();
    await apiController.updateRating(index: index, ratingValue: ratingValue);

    context.read<SongsProvider>().updateRating(index, ratingValue);
  }
}
