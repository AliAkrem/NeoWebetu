import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:neowebetu/blocs/session/session_bloc.dart';
import 'package:neowebetu/constant/api_endpoint.dart';

class QRCode extends StatefulWidget {
  const QRCode({super.key});

  @override
  _QRCodeState createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) {
        if (state is SessionLoadedState) {
          return Center(
            child: SizedBox(
              width: 100,
              child: QrImageView(
                data: CHECK_URL(state.session.userName),
                version: QrVersions.auto,
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
