import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageViewerScreen extends StatefulWidget {
  final String id;
  final List<String> images;
  final int initialIndex;
  final Function(int index)? onPageChangedCallback;
  const ImageViewerScreen({
    Key? key,
    required this.id,
    required this.images,
    required this.initialIndex,
    this.onPageChangedCallback,
  }) : super(key: key);

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  late int currentIndex;

  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: PhotoViewGallery.builder(
              pageController: PageController(
                initialPage: widget.initialIndex,
              ),
              onPageChanged: (index) {
                onPageChanged(index);
                widget.onPageChangedCallback?.call(index);
              },
              scrollPhysics: const ClampingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  basePosition: Alignment.center,
                  imageProvider: CachedNetworkImageProvider(
                    widget.images[index],
                    cacheKey: widget.images[index],
                  ),
                  initialScale: PhotoViewComputedScale.contained,
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 1.1,
                  // heroAttributes: PhotoViewHeroAttributes(
                  //   tag: '${widget.images[widget.initialIndex]}${widget.id}',
                  // ),
                );
              },
              itemCount: widget.images.length,
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: _buildDots(),
          // ),
          // Positioned(
          //   top: 0,
          //   child: Container(
          //     width: 360.toAutoScaledWidth,
          //     padding: EdgeInsets.only(top: safePadding, left: 4.toAutoScaledWidth),
          //     color: Colors.black.withOpacity(0.5),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         IconButton(
          //           color: Colors.white,
          //           height: 24.toAutoScaledHeight,
          //           width: 24.toAutoScaledHeight,
          //           cancel: true,
          //           onPressed: () {
          //             QAppX.router.pop();
          //           },
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
