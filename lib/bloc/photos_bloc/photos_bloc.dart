import 'package:albums_app/data/database_helper.dart';
import 'package:albums_app/data/repositories/photo_repository.dart';
import 'package:bloc/bloc.dart';

import '../../data/models/photo.dart';

part 'photos_events.dart';
part 'photos_state.dart';

class PhotoBloc extends Bloc<PhotosEvents, PhotosState> {
  final PhotoRepository photoRepository;
  final DatabaseHelper databaseHelper;
  final Map<String, List<Photo>> _images = {};
  PhotoBloc({required this.photoRepository, required this.databaseHelper})
      : super(PhotosInitial()) {
    on<PhotosFetched>(_fetchImages);
  }

  Future<void> _fetchImages(
      PhotosFetched event, Emitter<PhotosState> emit) async {
    String albumId = event.albumId;

    //check for images in local first
    final imagesLocal = await databaseHelper.getImages(int.parse(albumId));

    if (imagesLocal.isNotEmpty) {
      _images[albumId] = imagesLocal;
      emit(PhotosLoaded(imagesByAlbum: _images));
      return;
    }

    if (_images.containsKey(albumId)) {
      emit(PhotosLoaded(imagesByAlbum: _images));
      return;
    }
    emit(PhotosLoading());
    try {
      final images = await photoRepository.fetchImages(albumId);
      // save images to cache for next time
      databaseHelper.insertImages(images);
      _images[albumId] = images;
      emit(PhotosLoaded(imagesByAlbum: _images));
    } catch (_) {
      emit(PhotosLoadingError('Failed to load images'));
    }
  }
}
