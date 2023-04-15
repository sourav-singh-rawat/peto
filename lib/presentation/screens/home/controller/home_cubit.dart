part of '../view.dart';

class _HomeCubit extends Cubit<_HomeState> {
  _HomeCubit() : super(_HomeState.init());

  PetListRequest _petListRequest = PetListRequest();

  final searchTextFieldController = TextEditingController();

  final throttle = KThrottle(duration: const Duration(milliseconds: 3000));

  void onSearchIconPressed(BuildContext context) {
    final hasText = searchTextFieldController.text.isNotEmpty;

    if (hasText) {
      return;
    }

    final isSearchBarVisible = state.isSearching;

    if (isSearchBarVisible) {
      emit(state.copyWith(isSearching: false));
    } else {
      emit(state.copyWith(isSearching: true));

      searchTextFieldController.addListener(() {
        throttle.call(() {
          _petListRequest = _petListRequest.copyWith(
            queryValue: searchTextFieldController.text,
          );

          BlocProvider.of<_PetListCubit>(context).fetchPetList(
            request: _petListRequest,
            isSearching: true,
          );
        });
      });
    }
  }
}
