part of '../view.dart';

class _AdoptedDialog extends StatelessWidget {
  final String userImageUrl;
  final String petImageUrl;
  const _AdoptedDialog({
    super.key,
    required this.petImageUrl,
    required this.userImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = KAppX.theme.current;
    return Stack(
      children: [
        CupertinoAlertDialog(
          title: Text(
            'Adopted!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: theme.fontWeight.wBold,
              color: theme.colors.secondary,
            ),
          ),
          content: SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAvatar(userImageUrl),
                const SizedBox(width: 16),
                Transform.rotate(
                  angle: -pi / 6,
                  child: Icon(
                    Icons.pets,
                    size: 28,
                    color: theme.colors.secondary,
                  ),
                ),
                const SizedBox(width: 16),
                _buildAvatar(petImageUrl),
              ],
            ),
          ),
        ),
        const Positioned.fill(
          child: IgnorePointer(
            child: KLottieBuilder(KLottie.confetti),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(String imageUrl) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: KAppX.theme.current.colors.secondary,
        shape: BoxShape.circle,
      ),
      child: KImageProvider(
        imageUrl,
        width: 70,
        height: 70,
        borderRadius: BorderRadius.circular(70 / 2),
      ),
    );
  }
}
