import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webtu_v2/constant/api_endpoint.dart';
import 'package:webtu_v2/services/auth_service.dart';

class QRCode extends StatefulWidget {
  const QRCode({super.key});

  @override
  _QRCodeState createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  String qrUrl = "";

  Future<String> getCheckUrl() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = await AuthService(prefs).getCurrentUser();
    return user != null ? CHECK_URL(user.userName) : "";
  }

  @override
  void initState() {
    super.initState();
    getCheckUrl().then((url) {
      setState(() {
        qrUrl = url;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 100,
        child: QrImageView(
          data: qrUrl.isNotEmpty ? qrUrl : CHECK_URL(""),
          version: QrVersions.auto,
        ),
      ),
    );
  }
}
