import 'package:flutter/material.dart';

class CardHeader extends StatelessWidget {
  const CardHeader(
      {super.key,
      this.cardTitle = 'Student Card',
      this.university = 'Mascara University'});
  final cardTitle;
  final university;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            "the People's Democratic Republic of Algeria",
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          Text(
            university,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          Text(
            cardTitle,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
