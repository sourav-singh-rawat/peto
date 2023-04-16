part of '../../view.dart';

class _PetDetailedInfo extends StatelessWidget {
  final String? name;
  final PetDetails? petDetails;
  const _PetDetailedInfo({
    super.key,
    required this.name,
    required this.petDetails,
  });

  @override
  Widget build(BuildContext context) {
    final theme = KAppX.theme.current;

    final state = BlocProvider.of<_PetDetailsCubit>(context).state;

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: theme.colors.backgroundVariant,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            petDetails?.name ?? name ?? '',
            style: TextStyle(
              fontSize: 32,
              fontWeight: theme.fontWeight.wBold,
              color: theme.colors.onBackgroundVariant,
            ),
          ),
          if (state.petDetailsStatus == ApiStatus.loading)
            Container(
              height: 359,
              alignment: Alignment.center,
              child: const KLottieBuilder(KLottie.dot_loader),
            )
          else
            const SizedBox(height: 16),
          _BasicInfoPoints(
            age: state.petDetails?.age,
            gender: state.petDetails?.gender?.name,
            breed: state.petDetails?.breed,
          ),
          const SizedBox(height: 22),
          _PetStory(
            petName: petDetails?.name,
            petStory: petDetails?.description,
            location: petDetails?.location,
          ),
        ],
      ),
    );
  }
}

class _BasicInfoPoints extends StatelessWidget {
  final int? age;
  final String? gender;
  final String? breed;
  const _BasicInfoPoints({
    super.key,
    required this.age,
    required this.gender,
    required this.breed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = KAppX.theme.current;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (age != null) ...[
          Text(
            '${age}years',
            style: TextStyle(
              fontSize: 17,
              fontWeight: theme.fontWeight.wRegular,
              color: theme.colors.onBackground,
            ),
          ),
          const TextSeparatorDot(),
        ],
        if (gender != null) ...[
          Text(
            gender!.capitalize(),
            style: TextStyle(
              fontSize: 17,
              fontWeight: theme.fontWeight.wRegular,
              color: theme.colors.onBackground,
            ),
          ),
          const TextSeparatorDot(),
        ],
        if (breed != null)
          Text(
            breed!,
            style: TextStyle(
              fontSize: 17,
              fontWeight: theme.fontWeight.wRegular,
              color: theme.colors.onBackground,
            ),
          ),
      ],
    );
  }
}

class _PetStory extends StatelessWidget {
  final String? petName;
  final String? petStory;
  final String? location;
  const _PetStory({
    super.key,
    required this.petName,
    required this.petStory,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final theme = KAppX.theme.current;

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
        horizontal: 16,
        vertical: 12,
      ).copyWith(bottom: 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (petName != null && petStory != null) ...[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  KIcons.pen,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  "$petName's story",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: theme.fontWeight.wBold,
                    color: const Color(0xff1C1A1A),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
          if (petStory != null) ...[
            Text(
              petStory!,
              style: TextStyle(
                fontSize: 17,
                fontWeight: theme.fontWeight.wRegular,
                color: theme.colors.onBackgroundVariant,
              ),
            ),
            const SizedBox(height: 19),
          ],
          if (location != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  KIcons.pin_location,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  location!,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: theme.fontWeight.wRegular,
                    color: theme.colors.onBackground,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
