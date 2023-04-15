part of '../../view.dart';

class _PetImagePreview extends StatefulWidget {
  final String pid;
  final List<String>? images;

  const _PetImagePreview({
    Key? key,
    required this.pid,
    required this.images,
  }) : super(key: key);

  @override
  State<_PetImagePreview> createState() => _PetImagePreviewState();
}

class _PetImagePreviewState extends State<_PetImagePreview> {
  @override
  Widget build(BuildContext context) {
    final aspectRatio = MediaQuery.of(context).size.width / 356;

    final stateController = context.read<_PetImagePreviewCubit>();

    return BlocBuilder<_PetImagePreviewCubit, _PetImageState>(
      builder: (context, state) {
        return Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 359,
              child: CarouselSlider(
                items: widget.images?.map<Widget>((imageUrl) {
                  return SizedBox(
                    width: double.infinity,
                    child: _ImageViewer(
                      pid: widget.pid,
                      images: widget.images ?? [],
                      initialIndex: state.currentIndex,
                      onPageChangedCallback: (int index) {
                        stateController.onPageChanged(index);
                      },
                      child: Container(
                        foregroundDecoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff1C1A1A),
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [0, 0.45],
                          ),
                        ),
                        child: KImageProvider(
                          imageUrl,
                          backgroundColor: KAppX.theme.current.colors.onBackgroundVariant,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                carouselController: stateController.controller,
                options: CarouselOptions(
                  pageViewKey: PageStorageKey(aspectRatio),
                  onPageChanged: (index, changeReason) {
                    stateController.onPageChanged(index);
                  },
                  viewportFraction: 0.9999,
                  aspectRatio: aspectRatio,
                  scrollDirection: Axis.horizontal,
                  scrollPhysics: const ClampingScrollPhysics(),
                ),
              ),
            ),
            if ((widget.images?.length ?? 0) > 1)
              Positioned(
                left: 0,
                right: 0,
                top: 300,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 12,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.images?.length ?? 0,
                    itemBuilder: (context, index) {
                      return KIndicatorDot(
                        isActive: state.currentIndex == index,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 8);
                    },
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _ImageViewer extends StatelessWidget {
  final String pid;
  final int initialIndex;

  final Widget child;

  final List<String> images;

  final Function(int index)? onPageChangedCallback;

  const _ImageViewer({
    Key? key,
    required this.pid,
    required this.initialIndex,
    required this.child,
    required this.images,
    this.onPageChangedCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        KAppX.router.push(
          path: '/image_viewer',
          page: ImageViewerScreen(
            id: pid,
            images: images,
            initialIndex: initialIndex,
            onPageChangedCallback: onPageChangedCallback,
          ),
          fullScreenDialog: true,
        );
      },
      // child: Hero(
      //   tag: '${images[initialIndex]}$pid',
      //   child: child,
      // ),
      child: child,
    );
  }
}
