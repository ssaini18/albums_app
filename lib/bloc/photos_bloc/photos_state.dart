part of 'photos_bloc.dart';

sealed class PhotosState {}

final class PhotosInitial extends PhotosState {}

final class PhotosLoading extends PhotosState {}

final class PhotosLoaded extends PhotosState {
  final Map<String, List<Photo>> imagesByAlbum;
  // final List<Photo> images;
  PhotosLoaded({required this.imagesByAlbum});
}

final class PhotosLoadingError extends PhotosState {
  final String error;
  PhotosLoadingError(this.error);
}
