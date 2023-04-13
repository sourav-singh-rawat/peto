import 'package:bloc/bloc.dart';

part 'pet_list_state.dart';

class PetListCubit extends Cubit<PetListState> {
  PetListCubit() : super(PetListState.init());
}
