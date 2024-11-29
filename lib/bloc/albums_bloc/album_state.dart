part of 'album_bloc.dart';

sealed class AlbumState {}

final class AlbumInitial extends AlbumState {}

final class AlbumLoading extends AlbumState {}

final class AlbumLoaded extends AlbumState {
  final List<Album> albums;
  AlbumLoaded({required this.albums});
}

final class AlbumLoadingError extends AlbumState {
  final String error;
  AlbumLoadingError(this.error);
}
