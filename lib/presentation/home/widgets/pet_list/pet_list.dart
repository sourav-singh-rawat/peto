part of '../../view.dart';

class _PetList extends StatefulWidget {
  const _PetList({super.key});

  @override
  State<_PetList> createState() => __PetListState();
}

class __PetListState extends State<_PetList> {
  @override
  void initState() {
    BlocProvider.of<_PetListCubit>(context).initState();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_PetListCubit, _PetListState>(
      builder: (context, state) {
        if (state.petListStatus == ApiStatus.loading && state.pets.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SingleChildScrollView(
          controller: BlocProvider.of<_PetListCubit>(context).scrollController,
          child: Column(
            children: [
              ...state.pets.map((pet) {
                return SizedBox(
                  height: 100,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      onTap: () {
                        KAppX.router.push(
                          PetDetailsView(
                            petDetails: pet,
                          ),
                          fullScreenDialog: true,
                        );
                      },
                      leading: KImageProvider(
                        pet.imageUrl?[0] ?? '',
                        width: 50,
                        height: 50,
                      ),
                      title: Text(pet.name ?? ''),
                    ),
                  ),
                );
              }).toList(),
              const SizedBox(height: 20),
              if (state.petListStatus != ApiStatus.success)
                Container(
                  padding: const EdgeInsets.only(bottom: 16),
                  alignment: Alignment.center,
                  child: () {
                    if (state.petListStatus == ApiStatus.loading) {
                      return const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.petListStatus == ApiStatus.failed) {
                      return const Text('Failed to fetch');
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
