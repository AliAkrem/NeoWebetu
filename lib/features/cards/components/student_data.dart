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
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  rowData(
                      title: 'اللقب',
                      value: student.lastNameArabic,
                      secondaryValue: student.lastNameLatin),
                  rowData(
                      title: 'الاسم',
                      value: student.firstNameArabic,
                      secondaryValue: student.firstNameLatin),
                  rowData(
                      title: 'تاريخ و مكان الميلاد',
                      value: student.birthDate.toString().split(" ").first,
                      secondaryValue: student.birthPlaceArabic),
                  rowData(title: 'الميدان', value: student.domainLabelArabic),
                  rowData(title: 'الفرع', value: student.branchLabelArabic),
                ],
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 100,
                child: Image(
                  image: CachedMemoryImageProvider(
                    'profile://image/${student.id}',
                    base64: student.imageBase64,
                  ),
                ),
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

  Widget rowData(
      {required String title, required String value, String? secondaryValue}) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black,
              overflow: TextOverflow.clip,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                secondaryValue ?? "",
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  overflow: TextOverflow.clip,
                ),
              ),
              SizedBox(
                width: 24,
              ),
              Text(
                value,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    overflow: TextOverflow.clip),
              ),
            ],
          )
        ]);
  }
}
