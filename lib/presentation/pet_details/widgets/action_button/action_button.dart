part of '../../view.dart';

class _AdoptMeButton extends StatelessWidget {
  const _AdoptMeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_PetDetailsCubit, _PetDetailsState>(
      builder: (context, state) {
        final stateController = context.read<_PetDetailsCubit>();

        return GestureDetector(
          onTap: () {
            if (!state.isAdopting) {
              HapticFeedback.mediumImpact();

              stateController.onAdoptMePressed();
            }
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(24),
            ),
            constraints: const BoxConstraints(maxWidth: 150),
            child: Stack(
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    child: Text(
                      'Adopt me',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 24,
                  top: 0,
                  bottom: 0,
                  child: state.isAdopting
                      ? const SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(),
                        )
                      : const Icon(
                          Icons.pets,
                          size: 25,
                          color: Colors.white,
                        ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
