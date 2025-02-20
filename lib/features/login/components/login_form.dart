import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:webtu_v2/blocs/student/student_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
   final _studentIdController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _handleLogin() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<StudentBloc>().add(SignInStudentEvent(
            _studentIdController.text, _passwordController.text));
      },
    );
  }

  @override
  void dispose() {
    _studentIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool obscure = true;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<StudentBloc, StudentState>(
      listener: (context, state) {
        if (state is StudentLoadingState) {
          setState(() {
            _isLoading = true;
          });
        }

        if (state is StudentLoadedState) {
          context.go('/home');

          setState(() {
            _isLoading = false;
          });
        }

        if (state is SignInFailureState) {
          setState(() {
            _errorMessage = state.errorMessage;
          });

          setState(() {
            _isLoading = false;
          });
        }
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_errorMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.red.shade200,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Colors.red.shade700,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _errorMessage!,
                            style: TextStyle(
                              color: Colors.red.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                FormBuilderTextField(
                  controller: _studentIdController,
                  name: 'username',
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(12,
                        errorText: "Student ID must be at least 12 characters"),
                  ]),
                ),
                const SizedBox(height: 24),
                FormBuilderTextField(
                  controller: _passwordController,
                  name: 'password',
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(6,
                        errorText: "Password must be at least 6 characters"),
                  ]),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () async {
                      _formKey.currentState?.saveAndValidate();

                      bool? validation = _formKey.currentState?.validate();

                      if (validation != null && validation) {
                        await _handleLogin();
                      }
                    },
                    child: _isLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                              color: Colors.white,
                            ),
                          )
                        : Text("Login"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}