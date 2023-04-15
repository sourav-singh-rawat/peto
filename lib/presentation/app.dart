import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto/modules/domain/router/router.dart';
import 'package:peto/modules/domain/theme/theme.dart';
import 'package:peto/presentation/screens/home/view.dart';
import 'package:peto/presentation/screens/splash_screen/view.dart';
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
  void initState() {
    BlocProvider.of<KAppBooterCubit>(context).bootUp();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KThemeCubit, KThemeState>(
      builder: (context, state) {
        return MaterialApp(
          navigatorKey: KRouterBox.instance.navigatorKey,
          navigatorObservers: [KRouterBox.instance.observer],
          debugShowCheckedModeBanner: false,
          title: 'Petter',
          theme: ThemeData(
            brightness: state.type == KThemeType.dark ? Brightness.dark : Brightness.light,
            fontFamily: 'Mulish',
            shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
            iconTheme: Theme.of(context).iconTheme.copyWith(color: state.type == KThemeType.light ? const Color(0xffB5B4B4) : Colors.white),
            appBarTheme: Theme.of(context).appBarTheme.copyWith(
                  iconTheme: Theme.of(context).iconTheme.copyWith(
                        color: state.type == KThemeType.light ? const Color(0xffB5B4B4) : Colors.white,
                      ),
                ),
          ),
          home: const SplashView(),
        );
      },
    );
  }
}
