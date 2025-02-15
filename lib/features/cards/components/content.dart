import 'package:flutter/material.dart';
import 'package:webtu_v2/features/cards/components/header.dart';
import 'package:webtu_v2/features/cards/components/student_data.dart';
import 'package:webtu_v2/shared/qr_image.dart';

class CardContent extends StatelessWidget {
  const CardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CardHeader(),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [StudentData(), QRCode()],
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Text(
            '2024/2025',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ]),
    );
  }
}
