import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webtu_v2/DatabaseHelper/Repositories/exams_notes.dart';
import 'package:webtu_v2/DatabaseHelper/Repositories/periods.dart';
import 'package:webtu_v2/blocs/exams_notes/exams_notes_bloc.dart';
import 'package:webtu_v2/blocs/period/period_bloc.dart';
import 'package:webtu_v2/features/home/exams_notes/tab.dart';
import 'package:webtu_v2/models/exam_notes.dart';

class ExamsNotesScreen extends StatefulWidget {
  const ExamsNotesScreen({super.key});

  @override
  State<ExamsNotesScreen> createState() => _ExamsNotesScreenState();
}

class _ExamsNotesScreenState extends State<ExamsNotesScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PeriodBloc(periodRepository: PeriodRepository())
            ..add(GetPeriod()),
        ),
        BlocProvider(
          create: (context) => ExamsNotesBloc(ExamsNotesRepository())
            ..add(RevalidateExamNotesEvent()),
        )
      ],
      child: BlocBuilder<ExamsNotesBloc, ExamsNotesState>(
        builder: (context, state) {
          if (state is ExamsNotesLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is ExamsNotesLoaded) {
            // Group notes by period
            final notesByPeriod = <int, List<ExamNotes>>{};
            for (var note in state.notes) {
              notesByPeriod.putIfAbsent(note.periodId, () => []).add(note);
            }

            _tabController = TabController(
              length: notesByPeriod.length,
              vsync: this,
            );

            return Scaffold(
              appBar: AppBar(
                  title: const Text('Exam Notes'),
                  bottom: PeriodTab(tabController: _tabController)),
              body: TabBarView(
                controller: _tabController,
                children: notesByPeriod.entries.map((entry) {
                  return ListView.builder(
                    itemCount: entry.value.length,
                    itemBuilder: (context, index) {
                      final note = entry.value[index];
                      return ListTile(
                        title: Text(note.labelFr),
                        subtitle: Text(note.labelAr),
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
