part of '../view.dart';

class _AdoptionHistoryState {
  final ApiStatus historyListStatus;
  final List<AdoptionHistoryDetails> adoptionHistoryList;

  _AdoptionHistoryState({
    required this.historyListStatus,
    required this.adoptionHistoryList,
  });

  _AdoptionHistoryState.init()
      : this(
          historyListStatus: ApiStatus.loading,
          adoptionHistoryList: [],
        );

  _AdoptionHistoryState copyWith({
    ApiStatus? historyListStatus,
    List<AdoptionHistoryDetails>? adoptionHistoryList,
  }) {
    return _AdoptionHistoryState(
      historyListStatus: historyListStatus ?? this.historyListStatus,
      adoptionHistoryList: adoptionHistoryList ?? this.adoptionHistoryList,
    );
  }
}
