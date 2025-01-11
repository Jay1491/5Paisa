import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ZoomableImageScreen extends StatelessWidget {
  final String imageUrl;
  const ZoomableImageScreen({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zoomable Image'),
      ),
      body: PhotoView(
        backgroundDecoration: BoxDecoration(color: Colors.white),
        imageProvider: CachedNetworkImageProvider(imageUrl,),
      ),
    );
  }
}




