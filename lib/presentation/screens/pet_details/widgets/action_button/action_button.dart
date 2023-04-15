part of '../../view.dart';

class _AdoptMeButton extends StatelessWidget {
  final PetDetails petDetails;
  const _AdoptMeButton({
    super.key,
    required this.petDetails,
  });

  @override
  Widget build(BuildContext context) {
    final profileStateController = context.read<KProfileCubit>();

    return BlocBuilder<_PetDetailsCubit, _PetDetailsState>(
      builder: (context, state) {
        final theme = KAppX.theme.current;

        final stateController = context.read<_PetDetailsCubit>();

        final isAdopted = petDetails.adoptionDetails?.isAdopted ?? false;

        final petImageUrl = petDetails.imageUrl?[0];

        final userImageUrl = profileStateController.state.userDetails?.photoUrl;

        return GestureDetector(
          onTap: () async {
            if (!state.isAdopting && !isAdopted) {
              HapticFeedback.mediumImpact();

              await stateController.onAdoptMePressed(petDetails);

              showCupertinoDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) {
                  return _AdoptedDialog(
                    petImageUrl: petImageUrl ?? '',
                    userImageUrl: userImageUrl ?? '',
                  );
                },
              );
            }
          },
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: isAdopted ? theme.colors.onBackground : theme.colors.secondary,
              borderRadius: BorderRadius.circular(120),
            ),
            constraints: const BoxConstraints(
              maxWidth: 259,
            ),
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 12,
                    ),
                    child: Text(
                      'Adopt me',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: theme.fontWeight.wBold,
                        color: isAdopted ? theme.colors.onPrimary : theme.colors.onSecondary,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 24,
                  top: 0,
                  bottom: 0,
                  child: state.isAdopting
                      ? Center(
                          child: KCircularLoader(
                            color: theme.colors.onSecondary,
                            height: 24,
                            width: 24,
                          ),
                        )
                      : Transform.rotate(
                          angle: pi / 6,
                          child: Icon(
                            Icons.pets,
                            size: 24,
                            color: isAdopted ? theme.colors.onPrimary : theme.colors.onSecondary,
                          ),
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
