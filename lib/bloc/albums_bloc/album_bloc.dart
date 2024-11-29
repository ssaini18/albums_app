import 'package:albums_app/data/database_helper.dart';
import 'package:bloc/bloc.dart';

import '../../data/repositories/album_repository.dart';
import '../../data/models/album.dart';

part 'album_events.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvents, AlbumState> {
  final DatabaseHelper databaseHelper;
  final AlbumRepository albumRepository;

  AlbumBloc({required this.albumRepository, required this.databaseHelper})
      : super(AlbumInitial()) {
    on<AlbumFetched>(_fetchAlbums);
  }

  Future<void> _fetchAlbums(
      AlbumFetched event, Emitter<AlbumState> emit) async {
    //try and check for data in local storage first
    final albumsLocal = await databaseHelper.getAlbums();
    if (albumsLocal.isNotEmpty) {
      emit(AlbumLoaded(albums: albumsLocal));
      return;
    }
    emit(AlbumLoading());
    try {
      final albums = await albumRepository.fetchAlbums();
      //save albums to cache for next time
      databaseHelper.insertAlbums(albums);
      emit(AlbumLoaded(albums: albums));
    } catch (_) {
      emit(AlbumLoadingError('Failed to load albums'));
    }
  }
}
