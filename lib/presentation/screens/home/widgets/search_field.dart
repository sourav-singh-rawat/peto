part of '../view.dart';

class _SearchField extends StatelessWidget {
  const _SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = KAppX.theme.current;

    return BlocBuilder<_HomeCubit, _HomeState>(
      builder: (context, state) {
        final stateController = BlocProvider.of<_HomeCubit>(context);

        return Padding(
          padding: const EdgeInsets.only(top: 6),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SizeTransition(
                axis: Axis.horizontal,
                axisAlignment: 1,
                sizeFactor: animation,
                child: child,
              );
            },
            child: state.isSearching
                ? Container(
                    padding: const EdgeInsets.only(top: 4),
                    height: 40,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: TextField(
                      autofocus: state.isSearching,
                      controller: stateController.searchTextFieldController,
                      style: TextStyle(
                        fontWeight: theme.fontWeight.wRegular,
                      ),
                      decoration: InputDecoration(
                        // prefixIcon: IconButton(
                        //   onPressed: () {
                        //     showModalBottomSheet(
                        //       backgroundColor: Colors.transparent,
                        //       context: context,
                        //       builder: (context) {
                        //         return MultiBlocProvider(
                        //           providers: [
                        //             BlocProvider(create: (_) => _HomeCubit()),
                        //             BlocProvider(create: (_) => _PetListCubit()),
                        //           ],
                        //           child: const _FilterOptions(),
                        //         );
                        //       },
                        //     );
                        //   },
                        //   icon: const Icon(
                        //     Icons.filter_list,
                        //     size: 24,
                        //   ),
                        // ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: theme.colors.primary,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: theme.colors.onPrimaryVariant.withOpacity(0.45),
                            width: 1,
                          ),
                        ),
                        hintText: 'Name, Type, Breed, Location...',
                        hintStyle: TextStyle(
                          height: 0.6,
                          color: const Color(0xffB5B4B4).withOpacity(0.6),
                          fontWeight: theme.fontWeight.wRegular,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () => stateController.onSearchIconPressed(context),
                          icon: const Icon(
                            Icons.search,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  )
                : IconButton(
                    onPressed: () => stateController.onSearchIconPressed(context),
                    icon: const Icon(
                      Icons.search,
                      size: 24,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
