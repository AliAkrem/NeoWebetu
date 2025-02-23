import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neowebetu/blocs/student/student_bloc.dart';
import 'package:neowebetu/data/student_card.dart' as studentCard;

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final studentState = context.watch<StudentBloc>().state;
    final academicYear = studentState is StudentLoadedState
        ? "${studentState.student.academicYearCode} ${studentCard.academicYear}"
        : '';

    final registrationNumber = studentState is StudentLoadedState
        ? studentState.student.registrationNumber
        : '';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          registrationNumber,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          academicYear,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
