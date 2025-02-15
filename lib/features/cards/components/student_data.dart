import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtu_v2/blocs/student/student_bloc.dart';

class StudentData extends StatelessWidget {
  const StudentData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        if (state is StudentLoaded) {
          final student = state.student;
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: Image(
                  image: CachedMemoryImageProvider(
                    'profile://image/${student.id}',
                    base64: student.imageBase64,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  rowData(title: 'First Name:', value: student.firstNameLatin),
                  const SizedBox(height: 4),
                  rowData(title: 'Last Name:', value: student.lastNameLatin),
                ],
              ),
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget rowData({required String title, required String value}) {
    return Row(children: [
      Text(
        title,
        style: const TextStyle(
            fontSize: 12, color: Colors.black, overflow: TextOverflow.clip),
      ),
      SizedBox(
        width: 4,
      ),
      Text(
        value,
        style: const TextStyle(
            fontSize: 12, color: Colors.black, overflow: TextOverflow.clip),
      )
    ]);
  }
}
