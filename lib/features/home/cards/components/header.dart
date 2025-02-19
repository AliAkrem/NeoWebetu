import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtu_v2/blocs/student/student_bloc.dart';

class CardHeader extends StatelessWidget {
  const CardHeader({super.key, this.cardTitle = 'بطاقة الطالب'});
  final cardTitle;


  @override
  Widget build(BuildContext context) {
    final studentState = context.watch<StudentBloc>().state;
    final university = studentState is StudentLoaded
        ? studentState.student.institutionNameArabic
        : '';

    return Center(
      child: Column(
        children: [
          Text(
            "اﳉﻤﻬﻮرﻳﺔ اﳉﺰاﺋﺮﻳﺔ اﻟﺪﳝﻘﺮاﻃﻴﺔ اﻟﺸﻌﺒﻴﺔ",
            style: TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
          ),
          Text(
            "وزارة التعليم العالي والبحث العلمي",
            style: TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
          ),
          Text(
            university,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          Text(
            cardTitle,
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
