import 'package:bloc/bloc.dart';

import '../../data/repositories/album_repository.dart';
import '../../data/models/album.dart';

part 'album_events.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvents, AlbumState> {
  final AlbumRepository albumRepository;

  AlbumBloc({required this.albumRepository}) : super(AlbumInitial()) {
    on<AlbumFetched>(_fetchAlbums);
  }

  Future<void> _fetchAlbums(
      AlbumFetched event, Emitter<AlbumState> emit) async {
    emit(AlbumLoading());
    try {
      final albums = await albumRepository.fetchAlbums();
      emit(AlbumLoaded(albums: albums));
    } catch (_) {
      emit(AlbumLoadingError('Failed to load albums'));
    }
  }
}
