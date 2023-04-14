part of '../../view.dart';

class _Header extends StatelessWidget {
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 16),
      child: IconButton(
        padding: EdgeInsets.zero,
        color: Colors.grey,
        icon: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(8),
          child: const Icon(Icons.close),
        ),
        onPressed: () {
          KAppX.router.pop();
        },
      ),
    );
  }
}
