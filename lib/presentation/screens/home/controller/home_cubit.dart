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

    // final petListStateController = BlocProvider.of<_PetListCubit>(context);

// petListStateController.searchInPetList(searchTextFieldController.text)

    // final _petList = [...]

    // emit(state.copyWith(
    //   filters: newList,
    // ));

    // emit(state.copyWith(

    // ));

    // final petListStateController = BlocProvider.of<_PetListCubit>(context);

    // Map<Enum, List<String>> queryOptionsSelected = {
    //   PetType: [],
    //   'gender': [],
    // };

    // for (var item in newList) {
    //   final type = item.runtimeType;
    //   late String key;
    //   switch (type) {
    //     case PetType:
    //       key = 'type';
    //       item = item as PetType;
    //       break;
    //     case PetGender:
    //       key = 'gender';
    //       item = item as PetGender;
    //       break;
    //   }

    //   queryOptionsSelected[key] = [...queryOptionsSelected[key]!, item.name.capitalize()];
    // }
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
