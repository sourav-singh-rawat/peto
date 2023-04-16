part of '../view.dart';

class _AdoptionHistoryCubit extends Cubit<_AdoptionHistoryState> {
  _AdoptionHistoryCubit() : super(_AdoptionHistoryState.init());

  final scrollController = ScrollController();

  void initState() async {
    final petRepository = PetRepository();

    final response = await petRepository.adoptionHistory(
      request: AdoptionHistoryRequest(),
    );

    void onSuccess(AdoptionHistorySuccess success) {
      emit(state.copyWith(
        historyListStatus: ApiStatus.success,
        adoptionHistoryList: [...state.adoptionHistoryList, ...success.adoptionHistoryList],
      ));
    }

    void onFailure(AdoptionHistoryFailure failure) {
      emit(state.copyWith(
        historyListStatus: ApiStatus.failed,
      ));
    }

    response.resolve(onSuccess, onFailure);
  }
}
