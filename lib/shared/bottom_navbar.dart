import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  _getCurrentIndex() {
    final String path = GoRouterState.of(context).matchedLocation;
    if (path.contains('/home/cards')) {
      return 1;
    } else if (path.contains('/home/profile')) {
      return 2;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _getCurrentIndex(),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.house,
            size: 20,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.creditCard,
            size: 20,
          ),
          label: 'Cards',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.user,
            size: 20,
          ),
          label: 'Profile',
        ),
      ],
      onTap: (int value) {
        switch (value) {
          case 0:
            context.go('/home');
            break;
          case 1:
            context.go('/home/cards');
            break;
          case 2:
            context.go('/home/profile');
            break;
          default:
        }
      },
    );
  }
}
