import 'package:flutter/material.dart';
import 'package:webtu_v2/features/home/cards/components/footer.dart';
import 'package:webtu_v2/features/home/cards/components/header.dart';
import 'package:webtu_v2/features/home/cards/components/qr_image.dart';
import 'package:webtu_v2/features/home/cards/components/student_data.dart';

class CardContent extends StatelessWidget {
  const CardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 14),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        CardHeader(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            QRCode(),
            StudentData(),
          ],
        ),
        const Spacer(),
        Footer()
      ]),
    );
  }
}
