import 'package:albums_app/bloc/albums_bloc/album_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/album.dart';
import '../widgets/album_widget.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({super.key});

  @override
  State<AlbumsPage> createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AlbumBloc>().add(AlbumFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AlbumBloc, AlbumState>(builder: (context, state) {
        if (state is AlbumLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AlbumLoaded) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
            child: ListView.builder(
              itemBuilder: (context, index) {
                Album album = state.albums[index % 4];
                double deviceHeight = MediaQuery.of(context).size.height;
                double rowHeight = (deviceHeight - 80) / 4;
                return AlbumWidget(
                  height: rowHeight,
                  album: album,
                );
              },
            ),
          );
        } else if (state is AlbumLoadingError) {
          return const Center(
            child: Text('Error loading albums'),
          );
        } else {
          return const Center(
            child: Text('Your Albums list will appear soon'),
          );
        }
      }),
    );
  }
}
