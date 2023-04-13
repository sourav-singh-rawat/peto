import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto/modules/domain/router/router.dart';
import 'package:peto/modules/domain/theme/theme.dart';
import 'package:peto/utils/app_extensions.dart';
import 'package:peto/utils/booter/app_booter_cubit.dart';
import 'package:peto/utils/profile/profile_cubit.dart';
import 'package:peto/utils/theme/theme_cubit.dart';

class KMultiBlocProvider extends StatelessWidget {
  const KMultiBlocProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<KAppBooterCubit>(create: (context) {
          return KAppBooterCubit();
        }),
        BlocProvider<KThemeCubit>(create: (context) {
          return KThemeCubit();
        }),
        BlocProvider<KProfileCubit>(create: (context) {
          return KProfileCubit();
        })
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<KAppBooterCubit>(context).bootUp();

    return MaterialApp(
      navigatorKey: KRouterBox.instance.navigatorKey,
      // navigatorObservers: [KRouterBox.instance.routeObserver],
      title: 'Peto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<KThemeCubit, KThemeState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: KAppX.theme.current.colors.primary,
            body: Center(
              child: TextButton(
                onPressed: () {},
                child: const Text('change'),
              ),
            ),
          );
        },
      ),
    );
  }
}
