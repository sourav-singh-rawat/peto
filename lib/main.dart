import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto/firebase_options.dart';
import 'package:peto/utils/booter/app_booter_cubit.dart';
import 'package:peto/utils/profile/profile_cubit.dart';
import 'package:peto/utils/theme/theme_cubit.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<KAppBooterCubit>(create: (context) {
          final booter = KAppBooterCubit();

          booter.bootUp();

          return booter;
        }),
        BlocProvider<KThemeCubit>(create: (context) {
          return KThemeCubit();
        }),
        BlocProvider<KProfileCubit>(create: (context) {
          return KProfileCubit();
        })
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Placeholder(),
    );
  }
}
