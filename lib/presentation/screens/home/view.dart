import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto/modules/domain/theme/theme.dart';
import 'package:peto/presentation/core_widgets/app_bar.dart';
import 'package:peto/presentation/core_widgets/image_provider.dart';
import 'package:peto/presentation/core_widgets/indicator_dot.dart';
import 'package:peto/presentation/core_widgets/loader/circular_loader.dart';
import 'package:peto/presentation/core_widgets/scaffold.dart';
import 'package:peto/presentation/screens/pet_details/view.dart';
import 'package:peto/respository/domain/pet/pet_repository.dart';
import 'package:peto/respository/repository_helper_abstract.dart';
import 'package:peto/utils/app_extensions.dart';
import 'package:peto/utils/custom_extensions/custom_extensions.dart';
import 'package:peto/utils/helper/helper.dart';
import 'package:peto/utils/theme/theme_cubit.dart';

part 'widgets/pet_list/controller/pet_list_cubit.dart';
part 'widgets/pet_list/controller/pet_list_state.dart';
part 'widgets/pet_list/pet_list.dart';
part 'widgets/pet_tile/pet_tile.dart';
part 'widgets/search_field.dart';
part 'controller/home_cubit.dart';
part 'controller/home_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _HomeCubit()),
        BlocProvider(create: (_) => _PetListCubit()),
      ],
      child: BlocBuilder<_HomeCubit, _HomeState>(
        builder: (context, state) {
          return KScaffold(
            backgroundColor: KAppX.theme.current.colors.background,
            appBar: KAppBar(
              centerTitle: true,
              title: Text(
                "Adopt",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: KAppX.theme.current.fontWeight.wBold,
                  color: KAppX.theme.current.colors.onBackground,
                ),
              ),
              actions: [
                const _SearchField(),
                IconButton(
                  onPressed: KAppX.theme.toggleTheme,
                  icon: Icon(
                    KAppX.theme.current.type == KThemeType.dark ? Icons.brightness_high_sharp : Icons.brightness_low,
                    size: 24,
                  ),
                ),
              ],
            ),
            body: const _PetList(),
          );
        },
      ),
    );
  }
}
