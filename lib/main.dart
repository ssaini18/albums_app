import 'package:albums_app/bloc/albums_bloc/album_bloc.dart';
import 'package:albums_app/bloc/photos_bloc/photos_bloc.dart';
import 'package:albums_app/data/database_helper.dart';
import 'package:albums_app/data/providers/album_provider.dart';
import 'package:albums_app/data/providers/photo_provider.dart';
import 'package:albums_app/data/repositories/album_repository.dart';
import 'package:albums_app/data/repositories/photo_repository.dart';
import 'package:albums_app/presentation/pages/albums_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AlbumRepository>(
            create: (context) =>
                const AlbumRepository(albumProvider: AlbumProvider()),
          ),
          RepositoryProvider<PhotoRepository>(
            create: (context) =>
                const PhotoRepository(photoProvider: PhotoProvider()),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AlbumBloc(
                albumRepository: context.read<AlbumRepository>(),
                databaseHelper: DatabaseHelper.instance,
              ),
            ),
            BlocProvider(
              create: (context) => PhotoBloc(
                photoRepository: context.read<PhotoRepository>(),
                databaseHelper: DatabaseHelper.instance,
              ),
            ),
          ],
          child: const AlbumsPage(),
        ),
      ),
    );
  }
}
