part of '../../view.dart';

class _PetList extends StatefulWidget {
  const _PetList({super.key});

  @override
  State<_PetList> createState() => __PetListState();
}

class __PetListState extends State<_PetList> {
  @override
  void initState() {
    BlocProvider.of<_PetListCubit>(context).fetchPetList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_PetListCubit, _PetListState>(
      builder: (context, state) {
        if (state.petListStatus == ApiStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.petListStatus == ApiStatus.failed) {
          return const Center(
            child: Text('Failed to fetch'),
          );
        }

        return ListView.builder(
          itemCount: state.pets.length,
          itemBuilder: (context, index) {
            final pet = state.pets[index];
            return SizedBox(
              height: 100,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  leading: Image.network(
                    pet.imageUrl?[0] ?? '',
                    width: 50,
                    height: 50,
                  ),
                  title: Text(pet.name ?? ''),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
