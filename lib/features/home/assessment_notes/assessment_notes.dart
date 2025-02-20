import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtu_v2/blocs/assessment_note/assessment_notes_bloc.dart';
import 'package:webtu_v2/blocs/period/period_bloc.dart';
import 'package:webtu_v2/features/home/exams_notes/components/tab.dart';
import 'package:webtu_v2/models/assessment_notes.dart';

class AssessmentNotesScreen extends StatefulWidget {
  const AssessmentNotesScreen({super.key});

  @override
  State<AssessmentNotesScreen> createState() => _AssessmentNotesScreenState();
}

class _AssessmentNotesScreenState extends State<AssessmentNotesScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AssessmentNotesBloc()..add(GetAssessmentNotesEvent()),
        ),
        BlocProvider(
          create: (context) => PeriodBloc()..add(GetPeriodEvent()),
        ),
      ],
      child: BlocBuilder<AssessmentNotesBloc, AssessmentNotesState>(
        builder: (context, state) {
          if (state is AssessmentNoteLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is AssessmentNotesLoaded) {
            // Group notes by period
            final notesByPeriod = <String, List<AssessmentNote>>{};
            for (var note in state.notes) {
              notesByPeriod.putIfAbsent(note.llPeriode, () => []).add(note);
            }

            _tabController = TabController(
              length: notesByPeriod.length,
              vsync: this,
            );

            return Scaffold(
              appBar: AppBar(
                  title: const Text('Assessment Notes'),
                  bottom: PeriodTab(tabController: _tabController)),
              body: TabBarView(
                controller: _tabController,
                children: notesByPeriod.entries.map((entry) {
                  return ListView.builder(
                    itemCount: entry.value.length,
                    itemBuilder: (context, index) {
                      final note = entry.value[index];
                      return ListTile(
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(note.rattachementMcMcLibelleFr),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              note.apCode,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ],
                        ),
                        subtitle: Text(note.rattachementMcMcLibelleAr),
                        trailing: Text(
                          'Note: ${note.note > -1 ? note.note : 'N/A'}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: note.note >= 10
                                ? Colors.green
                                : note.note < 10 && note.note >= 0
                                    ? Colors.red
                                    : Colors.white,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            );
          }

          if (state is FailureState) {
            return Scaffold(
              body: Center(
                child: Text(state.errorMessage),
              ),
            );
          }

          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
