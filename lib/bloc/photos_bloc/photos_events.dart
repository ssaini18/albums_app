part of 'photos_bloc.dart';

sealed class PhotosEvents {}

final class PhotosFetched extends PhotosEvents {
  final String albumId;
  PhotosFetched({required this.albumId});
}
