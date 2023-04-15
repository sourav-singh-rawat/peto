part of '../../view.dart';

class _PetDetailedInfo extends StatelessWidget {
  final PetDetails petDetails;
  const _PetDetailedInfo({
    super.key,
    required this.petDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
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
            petDetails.name ?? 'Pet',
            textScaleFactor: 2.2,
          ),
          const SizedBox(height: 16),
          _BasicInfoPoints(
            age: petDetails.age,
            gender: petDetails.gender?.name,
            breed: petDetails.breed,
          ),
          const SizedBox(height: 22),
          _PetStory(
            petName: petDetails.name,
            petStory: petDetails.description,
            location: petDetails.location,
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (age != null) ...[
          Text('${age}years'),
          const TextSeparatorDot(),
        ],
        if (gender != null) ...[
          Text(gender!.capitalize()),
          const TextSeparatorDot(),
        ],
        if (breed != null) Text(breed!),
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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8)),
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
                const Icon(Icons.percent, color: Colors.grey, size: 24),
                const SizedBox(width: 12),
                Text(
                  "$petName's story",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
          if (petStory != null) ...[
            Text(petStory!),
            const SizedBox(height: 19),
          ],
          if (location != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.location_on, color: Colors.grey, size: 24),
                const SizedBox(width: 8),
                Text(
                  location!,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
