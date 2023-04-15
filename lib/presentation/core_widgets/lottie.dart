import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class KLottieBuilder extends StatefulWidget {
  final String asset;
  final double? width;
  final double? height;
  final AnimationController? controller;
  final bool autoLoad;
  const KLottieBuilder(
    this.asset, {
    super.key,
    this.height,
    this.width,
    this.controller,
    this.autoLoad = true,
  });

  @override
  State<KLottieBuilder> createState() => _KLottieBuilderState();
}

class _KLottieBuilderState extends State<KLottieBuilder> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _controller = AnimationController(vsync: this);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      widget.asset,
      width: widget.width,
      height: widget.height,
      controller: _controller,
      onLoaded: widget.autoLoad
          ? (composition) {
              _controller
                ..duration = composition.duration
                ..forward();
            }
          : null,
    );
  }
}
