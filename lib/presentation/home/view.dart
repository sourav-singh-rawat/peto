import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto/respository/domain/pet/pet_repository.dart';
import 'package:peto/respository/repository_helper_abstract.dart';

part 'widgets/pet_list/cubit/pet_list_cubit.dart';
part 'widgets/pet_list/cubit/pet_list_state.dart';
part 'widgets/pet_list/pet_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _PetListCubit()),
      ],
      child: const Scaffold(
        body: _PetList(),
      ),
    );
  }
}
