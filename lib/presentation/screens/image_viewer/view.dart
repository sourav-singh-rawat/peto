import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:peto/presentation/core_widgets/indicator_dot.dart';
import 'package:peto/utils/app_extensions.dart';
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
          Center(
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
          Positioned(
            top: 0,
            left: 16,
            child: SafeArea(
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: KAppX.theme.current.colors.onBackground,
                  size: 28,
                ),
                onPressed: () {
                  KAppX.router.pop();
                },
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        height: 100,
        color: Colors.black,
        width: double.infinity,
        alignment: Alignment.topCenter,
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: widget.images.length,
          itemBuilder: (context, index) {
            return KIndicatorDot(
              isActive: currentIndex == index,
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: 8);
          },
        ),
      ),
    );
  }
}
