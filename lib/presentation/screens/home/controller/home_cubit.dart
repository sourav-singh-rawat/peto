part of '../view.dart';

class _HomeCubit extends Cubit<_HomeState> {
  _HomeCubit() : super(_HomeState.init());

  PetListRequest _petListRequest = PetListRequest();

  final searchTextFieldController = TextEditingController();

  final throttle = KThrottle(duration: const Duration(milliseconds: 2000));

  void onSearchIconPressed(BuildContext context) {
    final petListStateController = BlocProvider.of<_PetListCubit>(context);

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
        final hasNoText = searchTextFieldController.text.isEmpty;

        if (hasNoText) {
          petListStateController.resetSearch();
          return;
        }

        throttle.call(() => petListStateController.searchInPetList(searchTextFieldController.text));
      });
    }
  }

  void onFilterOptionPressed<T extends Enum>(T value, BuildContext context) {
    var newList = [...state.filters];

    if (state.filters.contains(value)) {
      newList.remove(value);
    } else {
      newList = [...newList, value];
    }

    emit(state.copyWith(
      filters: newList,
    ));

    final petListStateController = BlocProvider.of<_PetListCubit>(context);

    petListStateController.filterPetList(newList);
  }

  void logout() async {
    emit(state.copyWith(
      isLoggingOut: true,
    ));

    final userRepository = UserRepository();

    final response = await userRepository.googleLogout();

    void onSuccess(GoogleLogoutSuccess s) {
      emit(state.copyWith(
        isLoggingOut: false,
      ));
    }

    void onFailure(GoogleLogoutFailure f) {
      emit(state.copyWith(
        isLoggingOut: false,
      ));
    }

    response.resolve(onSuccess, onFailure);
  }

  void onAdoptionHistoryPressed() {
    KAppX.router.push(
      path: '/adoption_history',
      page: const AdoptionHistoryScreen(),
    );
  }
}
