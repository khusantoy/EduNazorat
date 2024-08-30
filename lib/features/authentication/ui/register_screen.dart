import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/data/models/models.dart';
import 'package:millima/features/authentication/bloc/authentication_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  int _selectedRoleIndex = 1;
  final List<String> _roles = [
    'Student',
    'Teacher',
    'Admin',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              StatefulBuilder(builder: (context, setState) {
                return Column(
                  children: [
                    DropdownButtonFormField<int>(
                      value: _selectedRoleIndex,
                      decoration: const InputDecoration(
                        labelText: 'Role',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        for (var index = 0; index < _roles.length; index++)
                          DropdownMenuItem<int>(
                            value: index + 1,
                            child: Text(_roles[index]),
                          )
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedRoleIndex = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 32.0),
                    FilledButton(
                      onPressed: () {
                        // Handle registration logic
                        final name = _nameController.text;
                        final phone = _phoneController.text;
                        final password = _passwordController.text;
                        final confirmPassword = _confirmPasswordController.text;
                        final role = _selectedRoleIndex;

                        if (password != confirmPassword) {
                          // Show error
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Passwords do not match!')),
                          );
                        } else {
                          context.read<AuthenticationBloc>().add(
                                RegisterEvent(
                                  request: RegisterRequest(
                                    name: name,
                                    phone: phone,
                                    password: password,
                                    passwordConfirmation: confirmPassword,
                                    roleId: role,
                                  ),
                                ),
                              );
                        }
                      },
                      child: const Text('Register'),
                    ),
                  ],
                );
              }),
              TextButton(
                onPressed: () {
                  // Navigate back to login screen
                  Navigator.pop(context);
                },
                child: const Text('Back to Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
