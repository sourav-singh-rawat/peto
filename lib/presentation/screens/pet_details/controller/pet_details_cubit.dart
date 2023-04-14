part of '../view.dart';

class _PetDetailsCubit extends Cubit<_PetDetailsState> {
  _PetDetailsCubit() : super(_PetDetailsState.init());

  final scrollController = ScrollController();

  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >= 325) {
        emit(state.copyWith(
          isScrolledToTop: true,
        ));
      } else {
        emit(state.copyWith(
          isScrolledToTop: false,
        ));
      }
    });
  }

  void onAdoptMePressed() {}
}
