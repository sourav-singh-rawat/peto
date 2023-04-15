part of '../../../view.dart';

class _PetImagePreviewCubit extends Cubit<_PetImageState> {
  _PetImagePreviewCubit() : super(_PetImageState.init());

  final controller = CarouselController();

  void onPageChanged(int index) {
    emit(state.copyWith(
      currentIndex: index,
    ));

    controller.animateToPage(index);
  }
}
