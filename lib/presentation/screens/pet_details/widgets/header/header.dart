part of '../../view.dart';

class _Header extends StatelessWidget {
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      icon: Container(
        decoration: BoxDecoration(
          color: KAppX.theme.current.colors.backgroundVariant,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(6),
        child: Icon(
          Icons.close,
          color: KAppX.theme.current.colors.onBackground,
          size: 28,
        ),
      ),
      onPressed: () {
        KAppX.router.pop();
      },
    );
  }
}
