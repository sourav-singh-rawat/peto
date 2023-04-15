part of '../view.dart';

class _FilterOptions extends StatelessWidget {
  const _FilterOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = KAppX.theme.current;

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: theme.colors.backgroundVariant,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Text(
            'Filters',
            style: TextStyle(
              fontSize: 20,
              fontWeight: theme.fontWeight.wBold,
              color: theme.colors.onBackgroundVariant,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 28,
              horizontal: 24,
            ),
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                ...PetType.values.map<Widget>((value) {
                  return _buildFilterPill<PetType>(
                    text: value.name.capitalize(),
                    value: value,
                  );
                }).toList(),
                ...PetGender.values.map<Widget>((value) {
                  return _buildFilterPill<PetGender>(
                    text: value.name.capitalize(),
                    value: value,
                  );
                }).toList(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFilterPill<T extends Enum>({required String text, required T value}) {
    return BlocBuilder<_HomeCubit, _HomeState>(
      builder: (context, state) {
        final stateController = BlocProvider.of<_HomeCubit>(context);

        final isSelected = state.filters.contains(value);

        final theme = KAppX.theme.current;

        return Padding(
          padding: const EdgeInsets.only(right: 8, bottom: 8),
          child: GestureDetector(
            onTap: () => stateController.onFilterOptionPressed(value, context),
            child: KPill(
              backgroundColor: isSelected ? theme.colors.primary : null,
              child: Text(
                text,
                style: TextStyle(
                  color: isSelected ? theme.colors.onPrimary : theme.colors.onBackground,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
