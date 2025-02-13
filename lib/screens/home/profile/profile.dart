import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:webtu_v2/blocs/student/student_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        setState(() {
          theme = ThemeModelInheritedNotifier.of(context).theme.brightness ==
              Brightness.dark;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        if (state is StudentLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is StudentLoaded) {
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
                  // Profile Image
                  Center(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                          radius: 58,
                          backgroundImage: student.imageBase64 != null
                              ? CachedMemoryImageProvider(
                                  'profile://image',
                                  base64: student.imageBase64,
                                )
                              : AssetImage('assets/default_avatar.png')),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // User Info ShadCard
                  ShadCard(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            '${student.firstNameLatin} ${student.lastNameLatin}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),

                          const SizedBox(height: 16),
                          // Date of Birth
                          ListTile(
                            leading: const Icon(Icons.cake),
                            title: const Text('Date of Birth'),
                            subtitle: Text(
                                '${student.dateOfBirth?.toString().split(" ").first}'),
                          ),
                          // Place of Birth
                          ListTile(
                            leading: const Icon(Icons.location_city),
                            title: const Text('Place of Birth'),
                            subtitle: Text('${student.placeOfBirth}'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Settings Cards
                  ShadCard(
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
                              trailing:
                                  Switch(value: false, onChanged: (val) {})),
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
                  SizedBox(
                    height: 18,
                  )
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
