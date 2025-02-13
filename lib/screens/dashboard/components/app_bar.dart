import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtu_v2/blocs/student/student_bloc.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends State<HomeAppBar> {
  _handleLogout() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StudentBloc>().add(SignOutStudentEvent());
      // Navigator.of(context).pushReplacementNamed('/login');
    });
  }

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text('Dashboard'),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout_outlined),
          onPressed: () {
            _handleLogout();
          },
        ),
      ],
    );
  }
}
