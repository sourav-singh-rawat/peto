part of '../view.dart';

class _Drawer extends StatelessWidget {
  const _Drawer({super.key});

  @override
  Widget build(BuildContext context) {
    final stateController = BlocProvider.of<_HomeCubit>(context);

    final homeState = stateController.state;

    return BlocBuilder<KThemeCubit, KThemeState>(
      builder: (context, state) {
        final profile = KAppX.profile.state.userDetails;

        final theme = KAppX.theme.current;
        return Drawer(
          key: ValueKey(state.type),
          backgroundColor: theme.colors.backgroundVariant,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: theme.colors.primary,
                ),
                child: Center(
                  child: Column(
                    children: [
                      KImageProvider(
                        profile?.photoUrl ?? '',
                        width: 75,
                        height: 75,
                        borderRadius: BorderRadius.circular(75 / 2),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        profile?.name ?? '',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: theme.fontWeight.wBold,
                          color: theme.colors.onPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                key: ValueKey(state.type),
                leading: Icon(
                  state.type == KThemeType.dark ? Icons.brightness_high_sharp : Icons.brightness_low,
                  size: 24,
                ),
                title: Text(
                  '${state.type.name.capitalize()} Theme',
                  style: TextStyle(
                    color: theme.colors.onBackgroundVariant,
                    fontSize: 16,
                    fontWeight: theme.fontWeight.wRegular,
                  ),
                ),
                onTap: KAppX.theme.toggleTheme,
              ),
              _buildDivider(),
              ListTile(
                leading: const Icon(
                  Icons.history,
                  size: 24,
                ),
                title: Text(
                  'Adoption History',
                  style: TextStyle(
                    color: theme.colors.onBackgroundVariant,
                    fontSize: 16,
                    fontWeight: theme.fontWeight.wRegular,
                  ),
                ),
                trailing: homeState.isLoggingOut
                    ? const KCircularLoader(
                        width: 24,
                        height: 24,
                      )
                    : null,
                onTap: stateController.onAdoptionHistoryPressed,
              ),
              _buildDivider(),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  size: 24,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    color: theme.colors.onBackgroundVariant,
                    fontSize: 16,
                    fontWeight: theme.fontWeight.wRegular,
                  ),
                ),
                onTap: stateController.logout,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        thickness: 1.2,
        color: KAppX.theme.current.colors.onBackgroundVariant,
      ),
    );
  }
}
