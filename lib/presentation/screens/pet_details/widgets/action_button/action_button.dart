part of '../../view.dart';

class _AdoptMeButton extends StatelessWidget {
  final bool isAdopted;
  const _AdoptMeButton({
    super.key,
    required this.isAdopted,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_PetDetailsCubit, _PetDetailsState>(
      builder: (context, state) {
        final theme = KAppX.theme.current;

        final stateController = context.read<_PetDetailsCubit>();

        return GestureDetector(
          onTap: () {
            if (!state.isAdopting && !isAdopted) {
              HapticFeedback.mediumImpact();

              stateController.onAdoptMePressed();
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
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
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
                      ? SizedBox(
                          height: 24,
                          width: 24,
                          child: KCircularLoader(
                            color: theme.colors.onSecondary,
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
