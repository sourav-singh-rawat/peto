import 'dart:async';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto/presentation/core_widgets/image_provider.dart';
import 'package:peto/presentation/core_widgets/indicator_dot.dart';
import 'package:peto/presentation/core_widgets/loader/circular_loader.dart';
import 'package:peto/presentation/core_widgets/lottie.dart';
import 'package:peto/presentation/core_widgets/scaffold.dart';
import 'package:peto/presentation/screens/image_viewer/view.dart';
import 'package:peto/respository/domain/pet/pet_repository.dart';
import 'package:peto/utils/app_extensions.dart';
import 'package:peto/utils/assets/icons.dart';
import 'package:peto/utils/assets/lottie.dart';
import 'package:peto/utils/custom_extensions/custom_extensions.dart';
import 'package:peto/utils/profile/profile_cubit.dart';

part 'widgets/image_preview/controller/pet_image_preview_cubit.dart';
part 'widgets/image_preview/controller/pet_image_preview_state.dart';
part 'widgets/image_preview/image_preview.dart';
part 'widgets/header/header.dart';
part 'widgets/detailed_info/detailed_info.dart';
part 'widgets/action_button/action_button.dart';
part 'controller/pet_details_cubit.dart';
part 'controller/pet_details_state.dart';
part 'widgets/adopted_dialog.dart';

class PetDetailsView extends StatelessWidget {
  final PetDetails petDetails;
  const PetDetailsView({
    Key? key,
    required this.petDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _PetDetailsCubit()),
        BlocProvider(create: (_) => _PetImagePreviewCubit()),
      ],
      child: _PetDetailsViewBody(
        petDetails: petDetails,
      ),
    );
  }
}

class _PetDetailsViewBody extends StatefulWidget {
  final PetDetails petDetails;
  const _PetDetailsViewBody({
    super.key,
    required this.petDetails,
  });

  @override
  State<_PetDetailsViewBody> createState() => __PetDetailsViewBodyState();
}

class __PetDetailsViewBodyState extends State<_PetDetailsViewBody> {
  @override
  void initState() {
    BlocProvider.of<_PetDetailsCubit>(context).initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.of(context).padding.top;

    final theme = KAppX.theme.current;

    final stateController = context.read<_PetDetailsCubit>();

    final isAdopted = widget.petDetails.adoptionDetails?.isAdopted ?? false;

    return BlocBuilder<_PetDetailsCubit, _PetDetailsState>(
      builder: (context, state) {
        return KScaffold(
          appBar: state.isScrolledToTop
              ? AppBar(
                  leading: IconButton(
                    onPressed: () {
                      KAppX.router.pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                  centerTitle: true,
                  title: Text(widget.petDetails.name ?? ''),
                )
              : null,
          body: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height + safePadding,
                child: _PetImagePreview(
                  pid: widget.petDetails.pid,
                  images: widget.petDetails.imageUrl,
                ),
              ),
              const Positioned(
                top: 0,
                left: 16,
                child: SafeArea(
                  child: _Header(),
                ),
              ),
              if (isAdopted)
                Positioned(
                  top: 0,
                  right: 16,
                  child: SafeArea(
                    child: Image.asset(
                      KIcons.adopted_stamp,
                      width: 150,
                      height: 150,
                      color: theme.colors.secondary,
                    ),
                  ),
                ),
              Positioned(
                top: 325,
                child: SingleChildScrollView(
                  child: _PetDetailedInfo(
                    petDetails: widget.petDetails,
                  ),
                ),
              ),
            ],
          ),
          bottomSheet: Container(
            height: 72,
            color: Colors.transparent,
            width: double.infinity,
            padding: const EdgeInsets.only(
              bottom: 24,
            ),
            alignment: Alignment.center,
            child: _AdoptMeButton(
              petDetails: widget.petDetails,
            ),
          ),
        );
      },
    );
  }
}
