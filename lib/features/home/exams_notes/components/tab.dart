import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neowebetu/blocs/period/period_bloc.dart';

class PeriodTab extends StatefulWidget implements PreferredSizeWidget {
  final TabController tabController;
  const PeriodTab({super.key, required this.tabController});

  @override
  State<PeriodTab> createState() => _PeriodTabState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _PeriodTabState extends State<PeriodTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PeriodBloc, PeriodState>(builder: (context, state) {
      if (state is PeriodLoadingState) {
        return TabBar(
          controller: widget.tabController,
          tabs: [1, 2].map((period) {
            return const Tab(
              child: CircularProgressIndicator(),
            );
          }).toList(),
        );
      }

      if (state is PeriodLoadedState) {
        return TabBar(
          controller: widget.tabController,
          tabs: state.periods.map((period) {
            return Tab(text: period.longLabel);
          }).toList(),
        );
      }

      return TabBar(
        controller: widget.tabController,
        tabs: [1, 2].map((period) {
          return const Tab(
            child: CircularProgressIndicator(),
          );
        }).toList(),
      );
    });
  }
}
