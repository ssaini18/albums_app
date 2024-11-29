import 'package:albums_app/data/repositories/photo_repository.dart';
import 'package:bloc/bloc.dart';

import '../../data/models/photo.dart';

part 'photos_events.dart';
part 'photos_state.dart';

class ImageBloc extends Bloc<PhotosEvents, PhotosState> {
  final PhotoRepository photoRepository;
  final Map<String, List<Photo>> _images = {};
  ImageBloc({required this.photoRepository}) : super(PhotosInitial()) {
    on<PhotosFetched>(_fetchImages);
  }

  Future<void> _fetchImages(
      PhotosFetched event, Emitter<PhotosState> emit) async {
    String albumId = event.albumId;

    if (_images.containsKey(albumId)) {
      emit(PhotosLoaded(imagesByAlbum: _images));
      return;
    }
    emit(PhotosLoading());
    try {
      final images = await photoRepository.fetchImages(albumId);
      _images[albumId] = images;
      emit(PhotosLoaded(imagesByAlbum: _images));
    } catch (_) {
      emit(ImageError('Failed to load images'));
    }
  }
}
