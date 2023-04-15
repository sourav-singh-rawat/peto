import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:peto/presentation/core_widgets/lottie.dart';
import 'package:peto/utils/assets/lottie.dart';

class DotLoader extends StatelessWidget {
  const DotLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const KLottieBuilder(
      KLottie.dot_loader,
    );
  }
}
