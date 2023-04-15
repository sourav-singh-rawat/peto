import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto/presentation/core_widgets/image_provider.dart';
import 'package:peto/presentation/core_widgets/indicator_dot.dart';
import 'package:peto/presentation/screens/image_viewer/view.dart';
import 'package:peto/respository/domain/pet/pet_repository.dart';
import 'package:peto/utils/app_extensions.dart';
import 'package:peto/utils/custom_extensions/custom_extensions.dart';

part 'widgets/image_preview/controller/pet_image_preview_cubit.dart';
part 'widgets/image_preview/controller/pet_image_preview_state.dart';
part 'widgets/image_preview/image_preview.dart';
part 'widgets/header/header.dart';
part 'widgets/detailed_info/detailed_info.dart';
part 'widgets/action_button/action_button.dart';
part 'controller/pet_details_cubit.dart';
part 'controller/pet_details_state.dart';

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
      child: BlocBuilder<_PetDetailsCubit, _PetDetailsState>(
        bloc: BlocProvider.of<_PetDetailsCubit>(context)..initState(),
        builder: (context, state) {
          final safePadding = MediaQuery.of(context).padding.top;

          final stateController = BlocProvider.of<_PetDetailsCubit>(context);

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: state.isScrolledToTop
                ? AppBar(
                    leading: IconButton(
                      onPressed: () {
                        KAppX.router.pop();
                      },
                      icon: const Icon(Icons.close),
                    ),
                    centerTitle: true,
                    title: Text(petDetails.name ?? ''),
                  )
                : null,
            body: Stack(
              fit: StackFit.expand,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: _PetImagePreview(
                    pid: petDetails.pid,
                    images: petDetails.imageUrl,
                  ),
                ),
                Positioned.fill(
                  child: SafeArea(
                    child: SingleChildScrollView(
                      controller: stateController.scrollController,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            height: 325 - safePadding,
                            color: Colors.transparent,
                            child: const _Header(),
                          ),
                          _PetDetailedInfo(
                            petDetails: petDetails,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            bottomSheet: Container(
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ).copyWith(
                  bottom: 24,
                ),
                child: const _AdoptMeButton(),
              ),
            ),
          );
        },
      ),
    );
  }
}
