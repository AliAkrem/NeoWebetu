import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtu_v2/blocs/student/student_bloc.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final studentState = context.watch<StudentBloc>().state;
    final academicYear = studentState is StudentLoaded
        ? studentState.student.academicYearCode
        : '';

    final registrationNumber = studentState is StudentLoaded
        ? studentState.student.registrationNumber
        : '';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          // padding: const EdgeInsets.symmetric(
          //   horizontal: 12,
          // ),
          child: Text(
            registrationNumber,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          // padding: const EdgeInsets.symmetric(
          //   horizontal: 12,
          // ),
          child: Text(
            '$academicYear السنة الجامعية',
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
