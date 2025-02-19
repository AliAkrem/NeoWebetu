import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:webtu_v2/blocs/student/student_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool theme = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        if (state is StudentLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is StudentLoadedState) {
          final student = state.student;

          return Scaffold(
            appBar: AppBar(
              title: const Text('My Profile'),
              centerTitle: true,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 100,
                          child: CircleAvatar(
                            minRadius: 52,
                            backgroundImage: CachedMemoryImageProvider(
                              'profile://image/${student.id}',
                              base64: student.imageBase64,
                            ),
                          ),
                        ),
                        Text(
                          '${student.firstNameLatin} ${student.lastNameLatin}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          // Date of Birth
                          ListTile(
                            leading: const Icon(Icons.cake),
                            title: const Text('Date of Birth'),
                            subtitle: Text(
                                student.birthDate.toString().split(" ").first),
                          ),
                          // Place of Birth
                          ListTile(
                            leading: const Icon(Icons.location_city),
                            title: const Text('Place of Birth'),
                            subtitle: Text(student.birthPlace),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Settings Cards
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          // Language Selection
                          ListTile(
                            leading: const Icon(Icons.language),
                            title: const Text('Language'),
                            trailing: DropdownButton<String>(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              value: 'English',
                              underline: const SizedBox(),
                              items: const [
                                DropdownMenuItem(
                                    value: 'English', child: Text('English')),
                                DropdownMenuItem(
                                    value: 'French', child: Text('French')),
                                DropdownMenuItem(
                                    value: 'Arabic', child: Text('Arabic')),
                              ],
                              onChanged: (value) {
                                // Handle language change
                              },
                            ),
                          ),
                          ListTile(
                              leading: const Icon(Icons.dark_mode_outlined),
                              title: const Text('theme'),
                              trailing: Switch(
                                  value: AdaptiveTheme.of(context).mode ==
                                      AdaptiveThemeMode.dark,
                                  onChanged: (val) {
                                    if (val) {
                                      AdaptiveTheme.of(context).setDark();
                                    } else {
                                      AdaptiveTheme.of(context).setLight();
                                    }
                                  })),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.read<StudentBloc>().add(SignOutStudentEvent());
                        context.go('/login');
                      },
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
