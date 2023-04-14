import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:peto/presentation/core_widgets/scaffold.dart';
import 'package:peto/utils/app_extensions.dart';
import 'package:peto/utils/assets/images.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return KScaffold(
      body: Center(
        child: Image.asset(
          KImages.logo,
          width: 243.73,
          height: 63.49,
        ),
      ),
    );
  }
}
