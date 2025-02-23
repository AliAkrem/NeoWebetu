import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neowebetu/blocs/student/student_bloc.dart';
import 'package:neowebetu/data/student_card.dart' as studentCard;

class CardHeader extends StatelessWidget {
  const CardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final studentState = context.watch<StudentBloc>().state;
    final university = studentState is StudentLoadedState
        ? studentState.student.institutionNameArabic
        : '';

    return Center(
      child: Column(
        children: [
          const Text(
            studentCard.pdra,
            style: TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
          ),
          const Text(
            studentCard.mohe,
            style: TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
          ),
          Text(
            university,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const Text(
            studentCard.cardTitle,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
