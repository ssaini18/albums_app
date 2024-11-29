import 'package:albums_app/bloc/photos_bloc/photos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/album.dart';
import '../../data/models/photo.dart';
import 'cached_image_widget.dart';

class AlbumWidget extends StatefulWidget {
  final double height;
  final Album album;
  const AlbumWidget({super.key, required this.height, required this.album});

  @override
  State<AlbumWidget> createState() => _AlbumWidgetState();
}

class _AlbumWidgetState extends State<AlbumWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PhotoBloc>().add(PhotosFetched(albumId: '${widget.album.id}'));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: widget.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(widget.album.title),
            SizedBox(
              height: widget.height * 0.60,
              child: BlocBuilder<PhotoBloc, PhotosState>(
                  builder: (context, state) {
                if (state is PhotosLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PhotosLoaded) {
                  int albumId = widget.album.id;
                  if (!state.imagesByAlbum.containsKey('$albumId')) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      double screenWidth = MediaQuery.of(context).size.width;
                      double itemWidth = (screenWidth - 60) / 3;

                      List<Photo> images = state.imagesByAlbum['$albumId']!;
                      Photo image = images[index % 3];

                      return CachedImageWidget(
                        url: image.url,
                        width: itemWidth,
                        height: 100,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 20,
                      );
                    },
                    itemCount:
                        1000, //given high value to imitate infinite scroll
                  );
                } else {
                  return const Center(
                    child: Text("Error loading images"),
                  );
                }
              }),
            ),
            const Divider(
              thickness: 2,
              color: Colors.grey,
            )
          ],
        ));
  }
}
