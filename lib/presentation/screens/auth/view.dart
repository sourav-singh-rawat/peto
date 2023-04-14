import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto/presentation/core_widgets/loader/circular_loader.dart';
import 'package:peto/presentation/core_widgets/scaffold.dart';
import 'package:peto/respository/domain/user/user_repository.dart';
import 'package:peto/utils/app_extensions.dart';
import 'package:peto/utils/assets/icons.dart';
import 'package:peto/utils/assets/images.dart';

part 'controller/auth_cubit.dart';
part 'controller/auth_state.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<_AuthCubit>(
      create: (context) => _AuthCubit(),
      child: BlocBuilder<_AuthCubit, _AuthState>(
        builder: (context, state) {
          final stateController = context.read<_AuthCubit>();

          return KScaffold(
            body: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Image.asset(
                            KImages.logo,
                            width: 153.55,
                            height: 40,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Image.asset(
                            KImages.login_page_image,
                            width: 293.05,
                            height: 300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: stateController.onGoogleLoginPressed,
                    child: Container(
                      color: state.isAuthenticating ? KAppX.theme.current.colors.primary.shade80 : KAppX.theme.current.colors.primary,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Continue with',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: KAppX.theme.current.fontWeight.wBold,
                              color: KAppX.theme.current.colors.onPrimaryVariant,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: KAppX.theme.current.colors.onPrimary,
                            ),
                            padding: const EdgeInsets.all(8),
                            child: state.isAuthenticating
                                ? const KCircularLoader(
                                    width: 32,
                                    height: 32,
                                  )
                                : Image.asset(
                                    KIcons.google_logo,
                                    width: 32,
                                    height: 32,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
