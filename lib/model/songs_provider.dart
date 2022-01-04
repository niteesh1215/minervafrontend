import 'package:flutter/foundation.dart';
import 'package:minervafrontend/controller/song_api_controller.dart';
import 'package:minervafrontend/model/l_response.dart';

class Song {
  int? index;
  String? id;
  String? title;
  double? danceability;
  double? energy;
  int? mode;
  double? acousticness;
  double? tempo;
  int? durationMs;
  int? numSections;
  int? numSegments;
  double? starRating;

  Song(
      {this.index,
      this.id,
      this.title,
      this.danceability,
      this.energy,
      this.mode,
      this.acousticness,
      this.tempo,
      this.durationMs,
      this.numSections,
      this.numSegments,
      this.starRating});

  factory Song.fromJson(Map<String, dynamic> data) {
    return Song(
      index: data['index'],
      id: data['id'],
      title: data['title'],
      danceability: data['danceability'],
      energy: data['energy'],
      mode: data['mode'],
      acousticness: data['acousticness'],
      tempo: data['tempo'],
      durationMs: data['duration_ms'],
      numSections: data['num_sections'],
      numSegments: data['num_segments'],
      starRating: data['star_rating'].toDouble(),
    );
  }

  @override
  String toString() {
    return 'Song{index: $index, id: $id, title: $title, danceability: $danceability, energy: $energy, mode: $mode, acousticness: $acousticness, tempo: $tempo, durationMs: $durationMs, numSections: $numSections, numSegments: $numSegments, starRating: $starRating}';
  }
}

class SongsProvider with ChangeNotifier {
  List<Song> _songs = [];

  List<Song> get songs => _songs;

  bool loading = false;

  bool hasMore = true;

  int _start = 0;
  final int _count = 10;

  int _lastSortedColumnIndex = -1;
  bool _isAscendingOrder = true;

  void addSongs(List<Song> songs) {
    _songs.addAll(songs);
    if (_lastSortedColumnIndex != -1) sort(_lastSortedColumnIndex);
    notifyListeners();
  }

  Future<void> fetchMoreSong() async {
    if (loading || !hasMore) return;

    loading = true;
    notifyListeners();
    final songsApiController = SongApiController();

    final lResponse =
        await songsApiController.fetchPlayList(start: _start, count: _count);

    if (lResponse.responseStatus == ResponseStatus.success) {
      if (lResponse.data != null) {
        addSongs(lResponse.data!);
        print(lResponse.data!.length);
        if (lResponse.data!.length < _count) {
          hasMore = false;
        }
        _start += _count;
      }
    }
    loading = false;
    notifyListeners();
  }

  sort(
    int columnIndex,
  ) {
    if (_lastSortedColumnIndex == columnIndex) {
      _isAscendingOrder = !_isAscendingOrder;
    } else {
      _isAscendingOrder = true;
      _lastSortedColumnIndex = columnIndex;
    }
    switch (columnIndex) {
      case 0:
        sortByIndex();
        break;
      case 1:
        sortById();
        break;
      case 2:
        sortByTitle();
        break;
      case 3:
        sortByDanceability();
        break;
      case 4:
        sortByEnergy();
        break;
      case 5:
        sortByMode();
        break;
      case 6:
        sortByAcousticness();
        break;
      case 7:
        sortByTempo();
        break;
      case 8:
        sortByDurationMs();
        break;
      case 9:
        sortByNumSections();
        break;
      case 10:
        sortByNumSegment();
        break;
      case 11:
        sortByStarRating();
        break;
    }

    notifyListeners();
  }

  sortByIndex() {
    _songs.sort((a, b) {
      if (_isAscendingOrder) {
        return a.index!.compareTo(b.index!);
      } else {
        return b.index!.compareTo(a.index!);
      }
    });
  }

  sortById() {
    _songs.sort((a, b) {
      if (_isAscendingOrder) {
        return a.id!.compareTo(b.id!);
      } else {
        return b.id!.compareTo(a.id!);
      }
    });
  }

  sortByTitle() {
    _songs.sort((a, b) {
      if (_isAscendingOrder) {
        return a.title!.compareTo(b.title!);
      } else {
        return b.title!.compareTo(a.title!);
      }
    });
  }

  sortByDanceability() {
    _songs.sort((a, b) {
      if (_isAscendingOrder) {
        return a.danceability!.compareTo(b.danceability!);
      } else {
        return b.danceability!.compareTo(a.danceability!);
      }
    });
  }

  sortByEnergy() {
    _songs.sort((a, b) {
      if (_isAscendingOrder) {
        return a.energy!.compareTo(b.energy!);
      } else {
        return b.energy!.compareTo(a.energy!);
      }
    });
  }

  sortByMode() {
    _songs.sort((a, b) {
      if (_isAscendingOrder) {
        return a.mode!.compareTo(b.mode!);
      } else {
        return b.mode!.compareTo(a.mode!);
      }
    });
  }

  sortByAcousticness() {
    _songs.sort((a, b) {
      if (_isAscendingOrder) {
        return a.acousticness!.compareTo(b.acousticness!);
      } else {
        return b.acousticness!.compareTo(a.acousticness!);
      }
    });
  }

  sortByTempo() {
    _songs.sort((a, b) {
      if (_isAscendingOrder) {
        return a.tempo!.compareTo(b.tempo!);
      } else {
        return b.tempo!.compareTo(a.tempo!);
      }
    });
  }

  sortByDurationMs() {
    _songs.sort((a, b) {
      if (_isAscendingOrder) {
        return a.durationMs!.compareTo(b.durationMs!);
      } else {
        return b.durationMs!.compareTo(a.durationMs!);
      }
    });
  }

  sortByNumSections() {
    songs.sort((a, b) {
      if (_isAscendingOrder) {
        return a.numSections!.compareTo(b.numSections!);
      } else {
        return b.numSections!.compareTo(a.numSections!);
      }
    });
  }

  sortByNumSegment() {
    songs.sort((a, b) {
      if (_isAscendingOrder) {
        return a.numSegments!.compareTo(b.numSegments!);
      } else {
        return b.numSegments!.compareTo(a.numSegments!);
      }
    });
  }

  sortByStarRating() {
    songs.sort((a, b) {
      if (_isAscendingOrder) {
        return a.starRating!.compareTo(b.starRating!);
      } else {
        return b.starRating!.compareTo(a.starRating!);
      }
    });
  }

  updateRating(int index, double ratingValue) {
    final int i = _songs.indexWhere((element) => element.index == index);
    if (i != -1) {
      _songs[i].starRating = ratingValue;
    }
    notifyListeners();
  }
}
