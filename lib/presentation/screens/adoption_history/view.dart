import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto/presentation/core_widgets/app_bar.dart';
import 'package:peto/presentation/core_widgets/image_provider.dart';
import 'package:peto/presentation/core_widgets/indicator_dot.dart';
import 'package:peto/presentation/core_widgets/loader/circular_loader.dart';
import 'package:peto/presentation/core_widgets/pill.dart';
import 'package:peto/presentation/core_widgets/scaffold.dart';
import 'package:peto/respository/domain/pet/pet_repository.dart';
import 'package:peto/respository/domain/user/user_repository.dart';
import 'package:peto/respository/repository_helper_abstract.dart';
import 'package:peto/utils/app_extensions.dart';
import 'package:peto/utils/custom_extensions/custom_extensions.dart';
import 'package:peto/utils/helper/helper.dart';

part 'widgets/history_tile.dart';
part 'controller/adoption_history_cubit.dart';
part 'controller/adoption_history_state.dart';

class AdoptionHistoryScreen extends StatelessWidget {
  const AdoptionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _AdoptionHistoryCubit(),
      child: const _AdoptionHistoryBody(),
    );
  }
}

class _AdoptionHistoryBody extends StatefulWidget {
  const _AdoptionHistoryBody({super.key});

  @override
  State<_AdoptionHistoryBody> createState() => __AdoptionHistoryBodyState();
}

class __AdoptionHistoryBodyState extends State<_AdoptionHistoryBody> {
  DateTime? catchLastDate;
  bool isSameDate = false;

  @override
  void initState() {
    BlocProvider.of<_AdoptionHistoryCubit>(context).initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KScaffold(
      appBar: KAppBar(
        title: Text(
          "Adoption History",
          style: TextStyle(
            fontSize: 20,
            fontWeight: KAppX.theme.current.fontWeight.wBold,
            color: KAppX.theme.current.colors.onBackground,
          ),
        ),
      ),
      body: BlocBuilder<_AdoptionHistoryCubit, _AdoptionHistoryState>(
        builder: (context, state) {
          if (state.historyListStatus == ApiStatus.loading && state.adoptionHistoryList.isEmpty) {
            return const Center(
              child: KCircularLoader(),
            );
          }

          if (state.historyListStatus == ApiStatus.success && state.adoptionHistoryList.isEmpty) {
            return Center(
              child: Text(
                'Oops, No Adoption Yet!',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: KAppX.theme.current.fontWeight.wRegular,
                  color: KAppX.theme.current.colors.onBackground,
                ),
              ),
            );
          }

          return SingleChildScrollView(
            controller: BlocProvider.of<_AdoptionHistoryCubit>(context).scrollController,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 4),
                  ...state.adoptionHistoryList.map((history) {
                    final date = history.details.timestamp;

                    final dateLabel = () {
                      if (date == null) {
                        return null;
                      }

                      if (date.isToday) {
                        return 'Today';
                      } else if (date.isYesterday) {
                        return 'Yesterday';
                      } else {
                        return date.formattedDate;
                      }
                    }();

                    if (date != null) {
                      isSameDate = catchLastDate?.isSameDate(date) ?? false;
                    }

                    catchLastDate = date;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Column(
                        children: [
                          if (!isSameDate) ...[
                            KPill(
                              backgroundColor: KAppX.theme.current.colors.secondary,
                              child: Text(
                                dateLabel ?? '',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: KAppX.theme.current.fontWeight.wRegular,
                                  color: KAppX.theme.current.colors.onSecondary,
                                ),
                              ),
                            ),
                            const SizedBox(height: 2),
                          ],
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: KAppX.theme.current.colors.secondary,
                            ),
                            width: 2,
                            height: 8,
                          ),
                          const SizedBox(height: 2),
                          _HistoryTile(
                            adoptionDetails: history.details,
                            petDetails: history.petDetails,
                            userDetails: history.userDetails,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 16),
                  if (state.historyListStatus != ApiStatus.success)
                    Container(
                      padding: const EdgeInsets.only(bottom: 16),
                      alignment: Alignment.center,
                      child: () {
                        if (state.historyListStatus == ApiStatus.loading) {
                          return const SizedBox(
                            width: 20,
                            height: 20,
                            child: KCircularLoader(),
                          );
                        } else if (state.historyListStatus == ApiStatus.failed) {
                          return Text(
                            'Oops, Failed to fetch!',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: KAppX.theme.current.fontWeight.wRegular,
                              color: KAppX.theme.current.colors.onBackground,
                            ),
                          );
                        }

                        return const Placeholder();
                      }(),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
