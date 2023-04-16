part of '../view.dart';

class _HistoryTile extends StatelessWidget {
  final PetAdoptionDetails adoptionDetails;
  final PetDetails? petDetails;
  final UserDetails? userDetails;
  const _HistoryTile({
    super.key,
    required this.adoptionDetails,
    required this.petDetails,
    required this.userDetails,
  });

  @override
  Widget build(BuildContext context) {
    final theme = KAppX.theme.current;

    final petName = petDetails?.name ?? '';

    final petImageUrl = petDetails?.imageUrl?[0] ?? '';

    final adoptionTime = adoptionDetails.timestamp?.formattedTime ?? '';

    final adoptionDate = adoptionDetails.timestamp?.formattedDate ?? '';

    final userName = userDetails?.name?.split(' ').first ?? '';

    final userImageUrl = userDetails?.photoUrl ?? '';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffFAFAFA),
        border: Border.all(
          width: 1,
          color: const Color(0xffF1F1F0),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: KAppX.theme.current.colors.secondary,
            ),
            padding: const EdgeInsets.all(2),
            child: KImageProvider(
              petImageUrl,
              width: 60,
              height: 60,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        petName,
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
                          _buildSubTexts(
                            'Adopted on: ',
                            TextStyle(
                              fontStyle: FontStyle.italic,
                              color: KAppX.theme.current.colors.onBackgroundVariant,
                            ),
                          ),
                          _buildSubTexts(adoptionDate),
                          // const TextSeparatorDot(
                          //   padding: EdgeInsets.only(left: 4, right: 8),
                          // ),
                          // _buildSubTexts(adoptionTime),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Transform.rotate(
                        angle: -pi / 6,
                        child: Icon(
                          Icons.pets,
                          size: 12,
                          color: theme.colors.secondary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      _buildSubTexts(userName),
                      const SizedBox(width: 4),
                      KImageProvider(
                        userImageUrl,
                        width: 30,
                        height: 30,
                        borderRadius: BorderRadius.circular(30 / 2),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text _buildSubTexts(String text, [TextStyle? style]) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: KAppX.theme.current.fontWeight.wRegular,
        color: KAppX.theme.current.colors.onBackground,
      ).merge(style),
      overflow: TextOverflow.ellipsis,
    );
  }
}
