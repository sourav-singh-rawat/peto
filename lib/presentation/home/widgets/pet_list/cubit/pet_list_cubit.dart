import 'package:bloc/bloc.dart';

part 'pet_list_state.dart';

class PetListCubit extends Cubit<_PetListState> {
  PetListCubit() : super(_PetListState.init());
}
