import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto/modules/domain/router/router.dart';
import 'package:peto/presentation/home/view.dart';
import 'package:peto/utils/booter/app_booter_cubit.dart';
import 'package:peto/utils/profile/profile_cubit.dart';
import 'package:peto/utils/theme/theme_cubit.dart';

class KMultiBlocProvider extends StatefulWidget {
  const KMultiBlocProvider({super.key});

  @override
  State<KMultiBlocProvider> createState() => _KMultiBlocProviderState();
}

class _KMultiBlocProviderState extends State<KMultiBlocProvider> {
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

    return BlocBuilder<KThemeCubit, KThemeState>(
      builder: (context, state) {
        return MaterialApp(
          navigatorKey: KRouterBox.instance.navigatorKey,
          // navigatorObservers: [KRouterBox.instance.routeObserver],
          debugShowCheckedModeBanner: false,
          title: 'Peto',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomeView(),
        );
      },
    );
  }
}
