part of '../../view.dart';

class _PetList extends StatelessWidget {
  const _PetList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_PetListCubit, _PetListState>(
      bloc: BlocProvider.of<_PetListCubit>(context)..initState(),
      builder: (context, state) {
        if (state.petListStatus == ApiStatus.loading && state.pets.isEmpty) {
          return const Center(
            child: KCircularLoader(),
          );
        }

        return SingleChildScrollView(
          controller: BlocProvider.of<_PetListCubit>(context).scrollController,
          child: Column(
            children: [
              const SizedBox(height: 4),
              ...state.pets.map((pet) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _PetTile(petDetails: pet),
                );
              }).toList(),
              const SizedBox(height: 16),
              if (state.petListStatus != ApiStatus.success)
                Container(
                  padding: const EdgeInsets.only(bottom: 16),
                  alignment: Alignment.center,
                  child: () {
                    if (state.petListStatus == ApiStatus.loading) {
                      return const SizedBox(
                        width: 20,
                        height: 20,
                        child: KCircularLoader(),
                      );
                    } else if (state.petListStatus == ApiStatus.failed) {
                      return Text(
                        'Oops, Failed to fetch!',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: KAppX.theme.current.fontWeight.wRegular,
                          color: KAppX.theme.current.colors.onBackground,
                        ),
                      );
                    }

                    return const Placeholder();
                  }(),
                )
            ],
          ),
        );
      },
    );
  }
}
