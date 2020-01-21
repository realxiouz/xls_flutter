import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoPage extends StatefulWidget {
  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  @override
  Widget build(BuildContext context) {
    dynamic arguments = ModalRoute.of(context).settings.arguments;
    List<dynamic> photos = arguments['photos'];
    return Container(
      child: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(photos[index]['image']),
            initialScale: PhotoViewComputedScale.contained * 0.8,
            // heroAttributes: HeroAttributes(tag: galleryItems[index].id),
          );
        },
        itemCount: photos.length,
        // loadingChild: widget.loadingChild,
        // backgroundDecoration: widget.backgroundDecoration,
        pageController: PageController(),
        // onPageChanged: onPageChanged,
      )
    );
  }
}