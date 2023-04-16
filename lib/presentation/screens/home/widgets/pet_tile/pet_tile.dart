part of '../../view.dart';

class _PetTile extends StatelessWidget {
  final PetDetails petDetails;
  const _PetTile({
    super.key,
    required this.petDetails,
  });

  @override
  Widget build(BuildContext context) {
    final theme = KAppX.theme.current;

    final type = petDetails.type?.name.capitalize();

    final gender = petDetails.gender?.name.capitalize();

    final breed = petDetails.breed;

    final age = petDetails.age;

    final weight = 20 + Random().nextInt(40 - 20);

    final stateController = BlocProvider.of<_PetListCubit>(context);

    final isAdopted = petDetails.adoptionDetails?.isAdopted ?? false;

    return GestureDetector(
      onTap: () => stateController.onPetTilePressed(petDetails),
      child: Hero(
        tag: '${petDetails.pid}-home',
        child: Stack(
          children: [
            Opacity(
              opacity: isAdopted ? 0.55 : 1,
              child: Card(
                color: KAppX.theme.current.colors.backgroundVariant,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: theme.colors.onPrimaryVariant.withOpacity(0.09),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          foregroundDecoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff1C1A1A),
                                Colors.transparent,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: [0, 0.45],
                            ),
                          ),
                          child: KImageProvider(
                            petDetails.imageUrl?[0] ?? '',
                            width: 120,
                            height: 120,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          height: 113,
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    petDetails.name ?? '',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: theme.fontWeight.wBold,
                                      color: theme.colors.onBackgroundVariant,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (type != null) ...[
                                        _buildSubTexts(type),
                                        _buildSeparator(6, 8),
                                      ],
                                      if (breed != null) _buildSubTexts(breed),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (age != null) ...[
                                    _buildSubTexts('${age}years'),
                                    _buildSeparator(4, 10),
                                  ],
                                  if (gender != null) ...[
                                    _buildSubTexts(gender),
                                    _buildSeparator(8, 10),
                                  ],
                                  _buildSubTexts('${weight}kg')
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (isAdopted)
              Positioned(
                top: 4,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colors.secondary,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  child: Text(
                    'Adopted',
                    style: TextStyle(
                      color: theme.colors.onSecondary,
                      fontSize: 16,
                      fontWeight: theme.fontWeight.wRegular,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Text _buildSubTexts(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 17,
        fontWeight: KAppX.theme.current.fontWeight.wRegular,
        color: KAppX.theme.current.colors.onBackground,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSeparator(double left, double right) {
    return TextSeparatorDot(
      padding: EdgeInsets.only(
        left: left,
        right: right,
      ),
    );
  }
}
